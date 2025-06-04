package Implementor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Db.GetConnection;

public class UserDAO extends GetConnection {
	public boolean doesConsumerExist(int consumerId) {
		String sql = "SELECT port_id FROM consumer_port WHERE port_id = ?";
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, consumerId);
			ResultSet rs = stmt.executeQuery();
			return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}
