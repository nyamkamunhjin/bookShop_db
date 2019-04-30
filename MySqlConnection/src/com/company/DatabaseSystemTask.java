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
            boolean test = deleteProduct(stmt, "p0");
//            List<Category> categoryList = RandomGenerator.categoryGenerator(20);
//
//            for(int i = 0; i < 20; i++) {
//                String insertCategory = "insert into category(name, featured) " +
//                        "values(?,?)";
//                PreparedStatement pstmt = conn.prepareStatement(insertCategory, Statement.RETURN_GENERATED_KEYS);
//
//                pstmt.setString(1, categoryList.get(i).name);
//                pstmt.setInt(2, categoryList.get(i).isFeatured);
//
//                int rowId = pstmt.executeUpdate();    // fields
//
//            }

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

    public static boolean deleteProduct(final Statement smtm, String productId) {
        if(conn == null || smtm == null)
            return false;
        try {
            List<String> deleteOrderList = new ArrayList<>();

            // get cart_id where product_id is in it
            String getCartItemsQuery = "select * from shopping_cart where product_id = '" +productId + "';";
            ResultSet cartId = smtm.executeQuery(getCartItemsQuery);

            while(cartId.next()) {
                if(cartId.getInt("isOrdered") == 1) {
                    deleteOrderList.add(cartId.getString("cart_id"));
                    System.out.println("row from orders cart_id " + cartId.getString("cart_id") + " is deleted.");
                }

            }
            cartId.close();

            for(int i = 0; i < deleteOrderList.size(); i++) {
                smtm.executeUpdate("delete from orders where cart_id = '" + deleteOrderList.get(i) + "';");
            }
    //        String deleteCartFromOrder = "delete from orders where cart_id = '" +cartId+ "'";
    //        String deleteFromProduct = "delete from products where product_id = '" + productId + "' ";

    //            stmt.executeUpdate(deleteFromProduct);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
