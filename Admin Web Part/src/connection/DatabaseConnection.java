package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.PreparedStatement;



public class DatabaseConnection {
	
	   static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	   static final String DB_URL = "jdbc:mysql://localhost:3306/inclass01";

	   //  Database credentials
	   static final String USER = "root";
	   static final String PASS = "password";
	   static Connection conn = null;
	   
	   public static Connection createConnection() {
		   
		   try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("conenction success" + conn);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		   return conn;
	   }

	   public static void closeConnection() {
		   
		   if (conn!=null) {
			   try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		   }
	   }
	   
	   public static void closePreparedStatement(PreparedStatement ps) {
		   
		   if (ps!=null) {
			   
			   try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		   }
		   
	   }
}
