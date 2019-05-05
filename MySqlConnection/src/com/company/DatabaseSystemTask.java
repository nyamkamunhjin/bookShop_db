package com.company;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

/*
 * In this task, you would implement the embedded sqls in Java using the below code.
 * Every student has their own database and system. So that, on your database, you should develop the four
 * basic sql commands: insert, select, delete, and update. Print the information about
 * sql transactions into Java command line.
 */
public class DatabaseSystemTask{

    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost/internom";

    // Database credentials
    static final String USER = "user";
    static final String PASS = "12345678";
    // private static final Comparator SortbySize = null;
    static Connection conn;
    static Statement stmt;


    public static void main(String[] args) throws SQLException {
        // TODO Auto-generated method stub
        conn = null;
        stmt = null;
        try {
            // STEP 2: Register JDBC driver
            Class.forName(JDBC_DRIVER);

            // STEP 3: Open a connection
            System.out.println("Connecting to database...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            // STEP 4: Create a statement.
            System.out.println("Creating statement...");
            stmt = conn.createStatement();

            // STEP 5: Execute SQL statements
//            String voc_sql = "select * from orders;";
//            System.out.println("SQL: ");
//
//            ResultSet voc_rs = stmt.executeQuery(voc_sql);
//            while(voc_rs.next()) {
//                System.out.println(voc_rs.getString("ship_address"));
//
//            }
//            voc_rs.close();
//            deleteProduct(conn, "p0");
//            insertIntoCategory(conn, 1000, 50);
            orderCartMerger(conn);
        } catch (SQLException se) {
            // Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            // Handle errors for Class.forName
            e.printStackTrace();
        } finally {
            // finally block used to close resources
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException se2) {
            } // nothing we can do
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            } // end finally try
        } // end try
    }

    private static void insertIntoCategory(Connection conn, int rowNumber, int nameLength) {
        if(conn == null) {
            System.out.println("Connection failed.");
            return;
        }

        // inserting random info to `category` table.
        try {
            // generate random values for table `category`.
            List<Category> categoryList = RandomGenerator.categoryGenerator(rowNumber, nameLength);

            String insertCategory = "insert into category(name, featured) " +
                    "values(?,?)";
            PreparedStatement pstmt =
                    conn.prepareStatement(insertCategory, Statement.RETURN_GENERATED_KEYS);

            int i = 0;
            for(Category category : categoryList) {
                // stacking insert values
                pstmt.setString(1, category.name);
                pstmt.setInt(2, category.isFeatured);
                pstmt.addBatch();
                i++;

                // batch size limit is 1000.
                if(i % 1000 == 0 || i == categoryList.size()) {
                    pstmt.executeBatch(); // Execute every 1000 items.
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void deleteProduct(Connection conn, String productId) {
        try {
            // create statement.
            Statement smtm = conn.createStatement();

            // order table delete rows.
            List<String> deleteOrderList = new ArrayList<>();
            // shopping_cart table delete rows.
            List<String> deleteCartList = new ArrayList<>();

            // get cart_id where product_id is in it.
            String getCartItemsQuery = "select * from shopping_cart " +
                    "where product_id = '" +productId + "';";
            ResultSet cartId = smtm.executeQuery(getCartItemsQuery);

            // iterate through result set and find deletable (cart_id)s
            // in table `order`, `shopping_cart` and put it in the list.
            while(cartId.next()) {
                if(cartId.getInt("isOrdered") == 1) {
                    deleteOrderList.add(cartId.getString("cart_id"));
                }

                deleteCartList.add(cartId.getString("cart_id"));
            }
            cartId.close();

            // deleting rows from orders.
            for(int i = 0; i < deleteOrderList.size(); i++) {
                smtm.executeUpdate("delete from orders " +
                        "where cart_id = '" + deleteOrderList.get(i) + "';");
                System.out.println("Row from orders where cart_id '"
                        + deleteOrderList.get(i) + "' is deleted.");
            }

            // deleting rows from shopping_cart.
            for(int i = 0; i < deleteCartList.size(); i++) {
                smtm.executeUpdate("delete from shopping_cart " +
                        "where cart_id = '" + deleteCartList.get(i)
                        + "';");
                System.out.println("Row from shopping_cart where cart_id '"
                        + deleteCartList.get(i) + "' is deleted.");
            }

            // deleting row from product_branch.
            smtm.executeUpdate("delete from product_branch where product_id = '"
                    + productId + "';");
            System.out.println("Row from product_branch where product_id '"
                    + productId + " is deleted.");

            // deleting row from products.
            smtm.executeUpdate("delete from products where product_id = '"
                    + productId + "';");
            System.out.println("Row from products where cart_id '"
                    + productId + "' is deleted.");

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    // create table and from `shopping_cart` and `orders`
    private static void orderCartMerger(Connection conn) {
        if(conn == null) {
            System.out.println("Connection failed.");
            return;
        }

        try {
            // create statement.
            Statement smtm = conn.createStatement();

            String query = "select s.customer_id, s.product_id," +
                    " s.quantity, o.payment_type, o.order_date, o.total_price" +
                    " from orders o inner join shopping_cart s on s.cart_id = o.cart_id;";

            String dropTable = "drop table if exists order_check;";
            String createTable =    "create table order_check(" +
                                    "customer_id varchar(255) NOT NULL,"+
                                    "product_id varchar(255) NOT NULL," +
                                    "quantity int(5) NOT NULL," +
                                    "payment_type int(2) NOT NULL," +
                                    "order_date DATETIME NOT NULL," +
                                    "total_price int(10) NOT NULL);";


            String insertSql = "insert into order_check(" +
                    "customer_id," +
                    "product_id," +
                    "quantity," +
                    "payment_type," +
                    "order_date," +
                    "total_price) " +
                    "values(?,?,?,?,?,?);";



            System.out.println("Created table in given database...");

            smtm.executeUpdate(dropTable);
            smtm.executeUpdate(createTable);

            PreparedStatement pstmt =
                    conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);

            // get items
            ResultSet rs = smtm.executeQuery(query);

            int i = 0;
            while(rs.next()) {
                pstmt.setString(1, rs.getString(1));
                pstmt.setString(2, rs.getString(2));
                pstmt.setInt(3, rs.getInt(3));
                pstmt.setInt(4, rs.getInt(4));
                pstmt.setDate(5, rs.getDate(5));
                pstmt.setInt(6, rs.getInt(6));
                pstmt.addBatch();

                // batch size limit is 1000.
                if(i % 1000 == 0) {
                    pstmt.executeBatch(); // Execute every 1000 items.
                }
            }
            pstmt.executeBatch();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
