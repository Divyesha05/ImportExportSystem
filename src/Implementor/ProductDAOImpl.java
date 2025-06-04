package Implementor;

import Interface.ProductDAO;
import Pojo.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Db.GetConnection;

public class ProductDAOImpl implements ProductDAO {
	@Override
	public List<Product> getAvailableProducts(int portId) {
		List<Product> productList = new ArrayList<>();

		String sql = "{CALL ViewAvailableProducts(?)}"; // Stored Procedure Call

		try (Connection conn = GetConnection.getConnection(); CallableStatement stmt = conn.prepareCall(sql)) {

			stmt.setInt(1, portId); // Set input parameter
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Product product = new Product();
				product.setProductId(rs.getInt("product_id"));
				product.setProductName(rs.getString("product_name"));
				product.setQuantity(rs.getInt("quantity"));
				product.setPrice(rs.getDouble("price"));
				productList.add(product);
			}

			System.out.println("✅ Products fetched: " + productList.size());
			for (Product p : productList) {
				System.out.println("Product: " + p.getProductId() + " - " + p.getProductName());
			}

		} catch (SQLException e) {
			System.out.println("❌ Error Fetching Products!");
			e.printStackTrace();
		}

		return productList;
	}
}