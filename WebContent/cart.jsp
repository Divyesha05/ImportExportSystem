<%@page import="Implementor.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.Connection, java.sql.CallableStatement, java.sql.ResultSet, Db.GetConnection"%>

<%
	Connection conn = GetConnection.getConnection();
Integer consumerId = (Integer) session.getAttribute("port_id");

if (consumerId == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shopping Cart</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
body {
	background-color: #ffffff;
	font-family: 'Poppins', sans-serif;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

.container {
	margin-top: 30px;
	flex-grow: 1;
}

.navbar {
	background-color: #1d3557;
	padding: 15px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.navbar-brand, .navbar-nav .nav-link {
	color: white;
	font-weight: bold;
}

.sidebar {
	height: 100vh;
	width: 270px;
	position: fixed;
	top: 0;
	left: -270px;
	background-color: #457b9d;
	padding-top: 20px;
	transition: 0.4s;
	z-index: 1000;
}

.sidebar.active {
	left: 0;
}

.sidebar a {
	padding: 15px;
	display: block;
	color: white;
	text-decoration: none;
	font-size: 18px;
	transition: 0.3s;
}

.sidebar a:hover {
	background-color: #a8dadc;
}

.close-btn {
	position: absolute;
	top: 10px;
	right: 15px;
	font-size: 24px;
	cursor: pointer;
	color: white;
}

.card {
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease;
	background: #fff;
}

.card:hover {
	transform: scale(1.05);
}

.btn-primary {
	background-color: #e63946;
	border: none;
}

.btn-primary:hover {
	background-color: #d62828;
}

footer {
	background-color: #1d3557;
	color: white;
	padding: 20px;
	text-align: center;
	margin-top: auto;
}

.toggle-btn {
	border: none;
	background: none;
	color: white;
	font-size: 24px;
	cursor: pointer;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark">
		<button class="toggle-btn" onclick="toggleSidebar()">
			<i class="fas fa-bars"></i>
		</button>
		<a class="navbar-brand ms-5" href="home.jsp">PortCommerce</a>
	</nav>

	<div class="sidebar" id="sidebar">
		<span class="close-btn" onclick="toggleSidebar()">&times;</span> <a
			href="home.jsp">Home</a> <a href="viewProducts">Products</a> <a
			href="cart.jsp">My Cart</a> <a href="order_confirmation.jsp">My
			Orders</a> <a href="SellerReportController">Reported Products</a> <a
			href="Profile.jsp">My Profile</a>
	</div>
	<div class="container">
		<h2 class="text-center my-4">Shopping Cart</h2>
		<table class="table">
			<thead>
				<tr>
					<th>Product</th>
					<th>Quantity</th>
					<th>Price</th>
					<th>Subtotal</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
					CartDAO cd = new CartDAO();
				ResultSet rs = cd.list(consumerId);
				double totalPrice = 0;

				while (rs.next()) {
					int productId = rs.getInt("product_id");
					String productName = rs.getString("product_name");
					int quantity = rs.getInt("quantity");
					double price = rs.getDouble("price");
					double subtotal = rs.getDouble("subtotal");
					totalPrice += subtotal;
				%>
				<tr>
					<td><%=productName%></td>
					<td>
						<form action="CartController" method="post"
							style="display: inline;">
							<input type="hidden" name="product_id" value="<%=productId%>">
							<input type="hidden" name="action" value="decrease">
							<button type="submit" class="btn btn-sm btn-secondary">-</button>
						</form> <%=quantity%>
						<form action="CartController" method="post"
							style="display: inline;">
							<input type="hidden" name="product_id" value="<%=productId%>">
							<input type="hidden" name="action" value="increase">
							<button type="submit" class="btn btn-sm btn-secondary">+</button>
						</form>
					</td>
					<td>$<%=price%></td>
					<td>$<%=subtotal%></td>
					<td>
						<form action="CartController" method="post">
							<input type="hidden" name="product_id" value="<%=productId%>">
							<button type="submit" class="btn btn-danger" name="action"
								value="remove">Remove</button>
						</form>
					</td>
				</tr>
				<%
					}
				rs.close();
				%>
			</tbody>
		</table>
		<h4>
			Total Price: $<%=totalPrice%></h4>

		<!-- Checkout Button (Triggers Order Placement) -->
		<form action="CheckoutController" method="post">
			<input type="hidden" name="consumer_id" value="<%=consumerId%>">
			<button type="submit" class="btn btn-success">Checkout</button>
		</form>
		<div>
			<a href="viewProducts" class="btn btn-success">CONTINUE BUYING</a>
		</div>
	</div>

	<script>
		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("active");
		}
	</script>

	<footer class="fixed-bottom">
		<p>&copy; 2025 PortCommerce. All rights reserved.</p>
	</footer>
</body>
</html>