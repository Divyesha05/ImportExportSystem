<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, Db.GetConnection, Implementor.OrderImpl" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Order Status</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* General Styling */
        body {
            background-color: #f4f7fc;
            font-family: 'Arial', sans-serif;
        }

        .container {
            margin-top: 30px;
        }

        /* Navbar */
        .navbar {
            background-color: #1d3557;
            padding: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .navbar-brand {
            font-size: 20px;
            color: white;
            font-weight: bold;
        }

        /* Table Styling */
        .order-table {
            width: 100%;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            background: white;
        }

        .order-table th {
            background-color: #1d3557;
            color: white;
            padding: 15px;
            text-align: center;
        }

        .order-table td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        .order-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .order-table tbody tr:hover {
            background-color: #eef5ff;
        }

        /* Status Indicators */
        .status-placed { color: green; font-weight: bold; }
        .status-pending { color: red; font-weight: bold; }

        /* Buttons */
        .btn-update {
            background: #1d3557;
            color: white;
            padding: 6px 12px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
        }

        .btn-update:hover {
            background: #457b9d;
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
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand ms-5" href="dashboard.jsp">PortCommerce</a>
        <a href="logout.jsp" class="btn btn-danger btn-sm ms-auto">Logout</a>
    </nav>

    <div class="container">
        <h2 class="text-center mb-4">📦 Manage & Update Orders</h2>

        <!-- Order Status Update Form -->
        <div class="card p-4 shadow-sm">
            <h4 class="text-center">Update Order Status</h4>
            <form method="post" class="row g-3">
                <div class="col-md-4">
                    <label for="order_id" class="form-label">Order ID:</label>
                    <input type="number" id="order_id" name="order_id" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <label for="status" class="form-label">Select Status:</label>
                    <select id="status" name="status" class="form-select" required>
                        <option value="order_placed">Order Placed</option>
                        <option value="shipped">Shipped</option>
                        <option value="out_for_delivery">Out for Delivery</option>
                        <option value="delivered">Delivered</option>
                    </select>
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <input type="submit" value="Update Status" class="btn btn-update w-100">
                </div>
            </form>
        </div>

        <!-- Orders Table -->
        <h2 class="mt-4 text-center">Orders List</h2>
        <div class="table-responsive">
            <table class="table order-table mt-3">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Order Placed</th>
                        <th>Shipped</th>
                        <th>Out for Delivery</th>
                        <th>Delivered</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Fetch seller_id from session
                        Integer sellerId = (Integer) session.getAttribute("seller_id");
                        if (sellerId == null || sellerId <= 0) {
                            response.sendRedirect("login.jsp"); // Redirect to login if not logged in
                            return;
                        }

                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                            conn = GetConnection.getConnection();

                            // If form is submitted, update the status
                            if (request.getMethod().equalsIgnoreCase("post")) {
                                int orderId = Integer.parseInt(request.getParameter("order_id"));
                                String status = request.getParameter("status");

                                String sql = "SELECT UpdateOrderStatusFunction(?, ?) AS update_successful;";
                                pstmt = conn.prepareStatement(sql);
                                pstmt.setInt(1, orderId);
                                pstmt.setString(2, status);
                                rs = pstmt.executeQuery();

                                if (rs.next() && rs.getBoolean("update_successful")) {
                                    out.println("<p class='text-success text-center'>✔ Status updated successfully for Order ID: " + orderId + "</p>");
                                } else {
                                    out.println("<p class='text-danger text-center'>✖ Failed to update status. Invalid Order ID.</p>");
                                }
                            }

                            // Fetch updated orders
                            rs = OrderImpl.vupdorder(sellerId);
                            if (rs == null || !rs.isBeforeFirst()) {
                                out.println("<tr><td colspan='5' class='text-center text-danger'>No orders found.</td></tr>");
                            } else {
                                while (rs.next()) {
                                    out.println("<tr>");
                                    out.println("<td>" + rs.getInt("order_id") + "</td>");
                                    out.println("<td class='" + (rs.getBoolean("order_placed") ? "status-placed" : "status-pending") + "'>" + (rs.getBoolean("order_placed") ? "✅ Yes" : "❌ No") + "</td>");
                                    out.println("<td class='" + (rs.getBoolean("shipped") ? "status-placed" : "status-pending") + "'>" + (rs.getBoolean("shipped") ? "✅ Yes" : "❌ No") + "</td>");
                                    out.println("<td class='" + (rs.getBoolean("out_for_delivery") ? "status-placed" : "status-pending") + "'>" + (rs.getBoolean("out_for_delivery") ? "✅ Yes" : "❌ No") + "</td>");
                                    out.println("<td class='" + (rs.getBoolean("delivered") ? "status-placed" : "status-pending") + "'>" + (rs.getBoolean("delivered") ? "✅ Yes" : "❌ No") + "</td>");
                                    out.println("</tr>");
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) rs.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 PortCommerce. All rights reserved.</p>
    </footer>

</body>
</html>
