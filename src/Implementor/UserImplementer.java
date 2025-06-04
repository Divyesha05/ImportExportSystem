// implementer/UserImplementer.java
package Implementor;

import Db.GetConnection;
import Pojo.User;
import Interface.productinterface;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserImplementer implements productinterface {

	@Override
	public User getUserByIdAndRole(int portId, String role) throws SQLException, ClassNotFoundException {
		try (Connection con = GetConnection.getConnection()) {
			String query = "";
			if (role.equals("Consumer")) {
				query = "SELECT name, email, location, phone FROM consumer_port WHERE port_id = ?";
			} else if (role.equals("Seller")) {
				query = "SELECT name, email, location, phone FROM seller_port WHERE port_id = ?";
			}

			try (PreparedStatement pstmt = con.prepareStatement(query)) {
				pstmt.setInt(1, portId);
				try (ResultSet rs = pstmt.executeQuery()) {
					if (rs.next()) {
						User user = new User();
						user.setName(rs.getString("name"));
						user.setEmail(rs.getString("email"));
						user.setLocation(rs.getString("location"));
						user.setPhone(rs.getString("phone"));
						return user;
					}
				}
			}
		}
		return null;
	}
}