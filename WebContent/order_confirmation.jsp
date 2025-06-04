<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, Db.GetConnection, Implementor.OrderImpl" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            background-color: #f4f7fc;
            font-family: 'Arial', sans-serif;
        }

        .order-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .order-table th {
            background-color: #1d3557;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 16px;
        }

        .order-table td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            font-size: 14px;
        }

        .order-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .order-table tbody tr:hover {
            background-color: #eef5ff;
        }

        /* Report Button Styling */
        .btn-report {
            background: linear-gradient(45deg, #ff6b6b, #d43f3f);
            color: white;
            padding: 8px 15px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            box-shadow: 2px 3px 5px rgba(0, 0, 0, 0.2);
            transition: 0.3s;
        }

        .btn-report:hover {
            background: linear-gradient(45deg, #d43f3f, #b32d2d);
            transform: scale(1.05);
        }

        footer {
            background-color: #1d3557;
            color: white;
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

        @media (max-width: 768px) {
            .order-table {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #1d3557;">
        <a class="navbar-brand ms-5" href="dashboard.jsp">PortCommerce</a>
        <a href="logout.jsp" class="btn btn-danger btn-sm ms-auto">Logout</a>
    </nav>

    <div class="container text-center mt-4">
        <h2 class="mb-4">🎉 Order Placed Successfully!</h2>

        <div class="order-container">
            <table class="order-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Product Name</th>
                        <th>Consumer ID</th>
                        <th>Order Date</th>
                        <th>Order Status</th>
                        <th>Shipped</th>
                        <th>Out for Delivery</th>
                        <th>Delivered</th>
                        <th>Product ID</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        ResultSet rs = null;

                        try {
                            conn = GetConnection.getConnection();
                            Integer consumerId = (Integer) session.getAttribute("port_id");

                            if (consumerId == null) {
                                response.sendRedirect("login.jsp");
                                return;
                            }

                            if (consumerId <= 0) {
                                out.println("<tr><td colspan='11' class='text-danger text-center'>Invalid Consumer ID.</td></tr>");
                                return;
                            }

                            rs = OrderImpl.view(consumerId);

                            if (rs == null) {
                                out.println("<tr><td colspan='11' class='text-danger text-center'>Failed to fetch orders. Please try again later.</td></tr>");
                            } else {
                                if (!rs.isBeforeFirst()) {
                                    out.println("<tr><td colspan='11' class='text-center'>No orders found.</td></tr>");
                                } else {
                                    while (rs.next()) {
                                        int orderId = rs.getInt("order_id");
                                        String productName = rs.getString("product_name");
                                        int custId = rs.getInt("consumer_port_id");
                                        Date orderDate = rs.getDate("order_date");
                                        boolean placed = rs.getBoolean("order_placed");
                                        boolean shipped = rs.getBoolean("shipped");
                                        boolean outForDelivery = rs.getBoolean("out_for_delivery");
                                        boolean delivered = rs.getBoolean("delivered");
                                        int productId = rs.getInt("product_id");
                                        double price = rs.getDouble("price");
                                        int quantity = rs.getInt("quantity");
                    %>
                    <tr>
                        <td><%= orderId %></td>
                        <td><%= productName %></td>
                        <td><%= custId %></td>
                        <td><%= orderDate %></td>
                        <td><%= placed ? "✅ Placed" : "❌ Not Placed" %></td>
                        <td><%= shipped ? "✅ Shipped" : "❌ Not Shipped" %></td>
                        <td><%= outForDelivery ? "✅ Out for Delivery" : "❌ Not Yet" %></td>
                        <td><%= delivered ? "✅ Delivered" : "❌ Not Delivered" %></td>
                        <td><%= productId %></td>
                        <td>₹<%= price %></td>
                        <td><%= quantity %></td>
                        <td>
                            <a href="ReportController?product_id=<%= productId %>" class="btn btn-report">🚨 Report</a>
                        </td>
                    </tr>
                    <%
                                    }
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<tr><td colspan='11' class='text-danger text-center'>An error occurred while processing your request.</td></tr>");
                        } finally {
                            if (rs != null) rs.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </tbody>
            </table>
        </div>

        <p class="mt-3">Your order has been placed and will be processed soon.</p>
        <a href="viewProducts" class="btn btn-primary">🛒 Continue Shopping</a>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 PortCommerce. All rights reserved.</p>
    </footer>

</body>
</html>
