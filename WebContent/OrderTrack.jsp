<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, Implementor.OrderImpl" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Tracking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .order-header {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }
        .status-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px;
            border-left: 4px solid #ddd;
            background-color: #f9f9f9;
            border-radius: 4px;
        }
        .status-item.active {
            border-left-color: #28a745;
            background-color: #e8f5e9;
        }
        .status-icon {
            font-size: 20px;
            margin-right: 15px;
            color: #ddd;
        }
        .status-item.active .status-icon {
            color: #28a745;
        }
        .status-content {
            flex: 1;
        }
        .status-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }
        .status-date {
            font-size: 14px;
            color: #666;
        }
        .status-description {
            font-size: 14px;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="order-header">Order Confirmed</div>

        <%
            String orderIdParam = request.getParameter("orderid");
    
            String date = request.getParameter("date");
            if (orderIdParam != null && !orderIdParam.isEmpty()) {
                try {
                    int orderId = Integer.parseInt(orderIdParam);
                    Date orderDate = Date.valueOf(date);
                    ResultSet rs = OrderImpl.trackorder(orderId);

                    if (rs != null && rs.next()) {
                        boolean orderPlaced = rs.getBoolean("order_placed");
                        boolean shipped = rs.getBoolean("shipped");
                        boolean outForDelivery = rs.getBoolean("out_for_delivery");
                        boolean delivered = rs.getBoolean("delivered");

                        out.println("<div class='status-item " + (orderPlaced ? "active" : "") + "'>");
                        out.println("<div class='status-icon'>✔</div>");
                        out.println("<div class='status-content'>");
                        out.println("<div class='status-title'>Order Placed</div>");
                        out.println("<div class='status-date'>" + orderDate + " - 4:22pm</div>");
                        out.println("<div class='status-description'>Your order has been placed.</div>");
                        out.println("</div></div>");

                        out.println("<div class='status-item " + (shipped ? "active" : "") + "'>");
                        out.println("<div class='status-icon'>✔</div>");
                        out.println("<div class='status-content'>");
                        out.println("<div class='status-title'>Shipped</div>");
                        out.println("<div class='status-date'>" + orderDate + " - 3:15am</div>");
                        out.println("<div class='status-description'>Your item has been shipped.</div>");
                        out.println("</div></div>");

                        out.println("<div class='status-item " + (outForDelivery ? "active" : "") + "'>");
                        out.println("<div class='status-icon'>✔</div>");
                        out.println("<div class='status-content'>");
                        out.println("<div class='status-title'>Out for Delivery</div>");
                        out.println("<div class='status-date'>" + orderDate + " - 12:38pm</div>");
                        out.println("<div class='status-description'>Your item is out for delivery.</div>");
                        out.println("</div></div>");

                        out.println("<div class='status-item " + (delivered ? "active" : "") + "'>");
                        out.println("<div class='status-icon'>✔</div>");
                        out.println("<div class='status-content'>");
                        out.println("<div class='status-title'>Delivered</div>");
                        out.println("<div class='status-date'>" + orderDate + " - 8:42pm</div>");
                        out.println("<div class='status-description'>Your item has been delivered.</div>");
                        out.println("</div></div>");
                    } else {
                        out.println("<p class='text-danger'>No order found with ID: " + orderId + "</p>");
                    }

                    if (rs != null) {
                        rs.close();
                    }
                } catch (NumberFormatException e) {
                    out.println("<p class='text-danger'>Invalid Order ID. Please enter a valid number.</p>");
                } catch (Exception e) {
                    out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p class='text-danger'>Order ID is missing. Please provide an Order ID.</p>");
            }
        %>
    </div>
</body>
</html>