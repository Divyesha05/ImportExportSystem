package Implementor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.jdbc.CallableStatement;

import Db.GetConnection;
import Pojo.Order;
import Interface.OrderOperations;

public class OrderImpl implements OrderOperations {

    @Override
    public List<Order> getOrdersByConsumer(int consumerId) {
        System.out.println("Fetching orders for consumer ID: " + consumerId);

        List<Order> orders = new ArrayList<>();
        String query = "SELECT o.order_id, o.order_date, o.quantity, o.product_id, o.consumer_port_id, "
                     + "o.order_placed, o.shipped, o.out_for_delivery, o.delivered, p.product_name, p.price "
                     + "FROM orders o "
                     + "JOIN products p ON o.product_id = p.product_id "
                     + "WHERE o.consumer_port_id = ?"; // ✅ Use dynamic consumer ID

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, consumerId); // ✅ Correctly setting consumer ID
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.isBeforeFirst()) {
                    System.out.println("No orders found in DB!");
                }

                while (rs.next()) {
                    Order order = new Order(
                        rs.getInt("order_id"),
                        rs.getDate("order_date"),
                        rs.getInt("quantity"),
                        rs.getInt("product_id"),
                        rs.getInt("consumer_port_id"),
                        rs.getBoolean("order_placed"),
                        rs.getBoolean("shipped"),
                        rs.getBoolean("out_for_delivery"),
                        rs.getBoolean("delivered"),
                        rs.getString("product_name"),
                        rs.getDouble("price")
                    );

                    orders.add(order);
                    System.out.println("Fetched Order: ID=" + order.getOrderId() + ", Product=" + order.getProductName());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        System.out.println("Total orders retrieved: " + orders.size());
        return orders;
    }

    public static ResultSet vupdorder(int sellerId) {
        Connection conn = GetConnection.getConnection();
        ResultSet rs = null;
        String query = "SELECT o.order_id, o.order_placed, o.shipped, o.out_for_delivery, o.delivered "
                     + "FROM orders o "
                     + "JOIN products p ON o.product_id = p.product_id "
                     + "WHERE p.seller_id = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, sellerId);
            rs = pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static boolean updateOrderStatus(int orderId, String status) {
        Connection conn = GetConnection.getConnection();
        String sql = "{ ? = call UpdateOrderStatusFunction(?, ?) }";
        boolean updateSuccess = false;

        try (CallableStatement cstmt = (CallableStatement) conn.prepareCall(sql)) {
            cstmt.registerOutParameter(1, Types.BOOLEAN);
            cstmt.setInt(2, orderId);
            cstmt.setString(3, status);

            cstmt.execute();
            updateSuccess = cstmt.getBoolean(1); // ✅ Ensure return value is retrieved
            System.out.println("Order Status Update Success: " + updateSuccess);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updateSuccess;
    }

    public static ResultSet view(int consumerId) {
        Connection conn = GetConnection.getConnection();
        ResultSet rs = null;
        String sql = "SELECT o.order_id, o.consumer_port_id, o.order_date, o.order_placed, o.shipped, "
                   + "o.out_for_delivery, o.delivered, p.product_id, p.product_name, p.price, o.quantity "
                   + "FROM orders o INNER JOIN products p ON o.product_id = p.product_id "
                   + "WHERE o.consumer_port_id = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, consumerId);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static ResultSet trackorder(int orderId) {
        Connection conn = GetConnection.getConnection();
        ResultSet rs = null;
        String query = "SELECT order_placed, shipped, out_for_delivery, delivered FROM orders WHERE order_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, orderId);
            rs = pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
}
