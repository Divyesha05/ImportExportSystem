package Db;

import java.sql.*;

public class GetConnection {
	public static Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/importexportsystem", "root", "");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}
}