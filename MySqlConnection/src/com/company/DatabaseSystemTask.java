package com.company;


import java.sql.*;
import java.util.Scanner;

/*
 * In this task, you would implement the embedded sqls in Java using the below code.
 * Every student has their own database and system. So that, on your database, you should develop the four
 * basic sql commands: insert, select, delete, and update. Print the information about
 * sql transactions into Java command line.
 */
public class DatabaseSystemTask{

    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://10.3.132.98:3306/test";

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
            String voc_sql = "select `name`, `taste` from fruits";
            System.out.println("SQL: ");
            Scanner scanner = new Scanner(System.in);
            String userSql = scanner.nextLine();
            System.out.println(userSql);
            ResultSet voc_rs = stmt.executeQuery(voc_sql);
//            String userSql = "delete from fruits where name = 'pineapple'";
            if(userSql != null)
                stmt.executeUpdate(userSql);
//            for(int i = 0; i < 100; i++) {
//                String insertSql = "insert into fruits(name, taste) " +
//                        "values('pineapple',"+ i +")";
//                stmt.executeUpdate(insertSql);
//            }

//            voc_rs.close();


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
}
