package Implementor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Db.GetConnection;
import Pojo.InsUpDel_Pojo;
import Interface.InsUpDel_interface;

public class InsUpDel_implementor implements InsUpDel_interface {

	@Override
	public void add_products(InsUpDel_Pojo pojo) {
		String sql = "INSERT INTO products (seller_id, product_name, price, quantity) VALUES (?, ?, ?, ?)";
		try (Connection connection = GetConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
			preparedStatement.setInt(1, pojo.getSellerId());
			preparedStatement.setString(2, pojo.getProductName());
			preparedStatement.setDouble(3, pojo.getPrice());
			preparedStatement.setInt(4, pojo.getQuantity());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void update_products(InsUpDel_Pojo pojo) {
		String sql = "UPDATE products SET product_name = ?, price = ?, quantity = ? WHERE product_id = ?";
		try (Connection connection = GetConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
			preparedStatement.setString(1, pojo.getProductName());
			preparedStatement.setDouble(2, pojo.getPrice());
			preparedStatement.setInt(3, pojo.getQuantity());
			preparedStatement.setInt(4, pojo.getProductId());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void delete_products(InsUpDel_Pojo pojo) {
		String sql = "DELETE FROM products WHERE product_id = ?";
		try (Connection connection = GetConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
			preparedStatement.setInt(1, pojo.getProductId());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<InsUpDel_Pojo> getProductsBySeller(int sellerID) {
		List<InsUpDel_Pojo> productList = new ArrayList<>();
		String query = "SELECT product_id, product_name, price, quantity FROM products WHERE seller_id = ?";
		try (Connection conn = GetConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

			ps.setInt(1, sellerID);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				InsUpDel_Pojo product = new InsUpDel_Pojo();
				product.setProductId(rs.getInt("product_id"));
				product.setProductName(rs.getString("product_name"));
				product.setPrice(rs.getDouble("price"));
				product.setQuantity(rs.getInt("quantity"));
				productList.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return productList;
	}
}
