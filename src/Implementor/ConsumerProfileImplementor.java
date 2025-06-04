package Implementor;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.CallableStatement;
import Db.GetConnection;
import Pojo.profile;
import Interface.ConsumerProfileOperations;

public class ConsumerProfileImplementor implements ConsumerProfileOperations {

	@Override
	public profile getConsumerByPortId(int portId) {
		profile consumer = null;
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL GetConsumerByPortId(?)}")) {

			stmt.setInt(1, portId);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				consumer = new profile();
				consumer.setPortId(rs.getInt("port_id"));
				consumer.setPassword(rs.getString("password"));
				consumer.setLocation(rs.getString("location"));
				consumer.setRole(rs.getString("role"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return consumer;
	}

	@Override
	public boolean updateConsumer(int portId, String newPassword, String location) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL update_consumer(?, ?, ?)}")) {
			stmt.setInt(1, portId);
			stmt.setString(2, newPassword.isEmpty() ? null : newPassword);
			stmt.setString(3, location.isEmpty() ? null : location);
			return stmt.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean deleteConsumer(int portId, String password) {
		try (Connection conn = GetConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL DeleteConsumer(?, ?)}")) {
			stmt.setInt(1, portId);
			stmt.setString(2, password);
			return stmt.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}