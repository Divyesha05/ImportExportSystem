	package Implementor;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import Db.GetConnection;
import Pojo.RegisterPojo;

public class RegisterImplementor {
	public boolean registerUser(RegisterPojo pojo) {
		boolean isRegistered = false;
		Connection conn = null;
		CallableStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = GetConnection.getConnection();
			if (conn == null) {
				System.out.println("Database connection failed!");
				return false;
			}

			String sql = "{CALL register_user(?, ?, ?, ?, ?)}";
			stmt = conn.prepareCall(sql);
			stmt.setInt(1, pojo.getPort_id());
			stmt.setString(2, pojo.getPassword());
			stmt.setString(3, pojo.getConfirm_password());
			stmt.setString(4, pojo.getRole());
			stmt.setString(5, pojo.getLocation());

			boolean hasResults = stmt.execute();
			if (hasResults) {
				rs = stmt.getResultSet();
				if (rs.next() && rs.getString("Message").contains("successful")) {
					isRegistered = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return isRegistered;
	}

	public String loginUser(int portId, String password, String role) {
		String message = "Invalid Credentials";
		Connection connection = null;
		CallableStatement stmt = null;
		ResultSet rs = null;

		try {
			connection = GetConnection.getConnection();
			if (connection == null) {
				return "Database Connection Failed!";
			}

			String sql = "{CALL login_user(?, ?, ?)}";
			stmt = connection.prepareCall(sql);
			stmt.setInt(1, portId);
			stmt.setString(2, password);
			stmt.setString(3, role);

			rs = stmt.executeQuery();
			if (rs.next()) {
				message = rs.getString("Message");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			message = "Database Error: " + e.getMessage();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (connection != null)
					connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return message;
	}
}
