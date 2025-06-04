<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Pojo.InsUpDel_Pojo, java.util.List"%>

<%
	// Fetch seller_id from session
Integer sellerId = (Integer) session.getAttribute("seller_id");
if (sellerId == null) {
	response.sendRedirect("login.jsp"); // Redirect to login if not logged in
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Seller Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
body {
	background-color: #f4f7fc;
	font-family: 'Arial', sans-serif;
}

.container {
	margin-top: 20px;
}
/* Navbar Styling */
.navbar {
	background-color: #1d3557;
	padding: 15px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.navbar-brand, .navbar-nav .nav-link {
	color: white;
	font-weight: bold;
	margin: 0 15px;
}

.navbar-toggler {
	background-color: white;
}
/* Sidebar Styling */
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
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
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

.sidebar.active {
	left: 0;
}

.close-btn {
	position: absolute;
	top: 10px;
	right: 15px;
	font-size: 24px;
	cursor: pointer;
	color: white;
}
/* Content Styling */
.content {
	margin-left: 0;
	padding: 20px;
	transition: 0.4s;
}

.content.shifted {
	margin-left: 270px;
}
/* Card Styling */
.card {
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 600px;
	margin: 0 auto;
}

.card-header {
	font-size: 18px;
	font-weight: bold;
	padding: 15px;
	text-align: center;
}

.card-body {
	padding: 20px;
}

.form-control {
	border-radius: 8px;
}

.btn {
	padding: 10px;
	font-size: 16px;
	border-radius: 8px;
	width: 100%;
}

/* Updated Toggle Button Styling */
.toggle-btn {
	border: none;
	background: none; /* Remove background */
	color: white; /* Set icon color to white */
	font-size: 24px;
	cursor: pointer;
	padding: 0; /* Remove padding */
	margin: 0; /* Remove margin */
}

.toggle-btn:focus {
	outline: none; /* Remove outline on focus */
	box-shadow: none; /* Remove box shadow */
}
/* Footer Styling */
footer {
	background-color: #1d3557;
	color: white;
	text-align: center;
	padding: 10px 0;
	position: fixed;
	bottom: 0;
	width: 100%;
	z-index: 1000;
	box-shadow: 0 -4px 10px rgba(0, 0, 0, 0.1);
}

/* Adjust content padding to avoid footer overlap */
.content {
	margin-left: 0;
	padding: 20px;
	padding-bottom: 60px;
	/* Add padding to prevent content from being hidden behind the footer */
	transition: 0.4s;
}

.content.shifted {
	margin-left: 270px;
}
</style>
</head>
<body>

	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark">
		<button class="toggle-btn" onclick="toggleSidebar()">
			<i class="fas fa-bars"></i>
		</button>
		<a class="navbar-brand ms-5" href="#">PortCommerce</a>
		<li class="nav-item"><a class="nav-link" href="logout.jsp"
			style="color: #ff6b6b;"> <i class="fas fa-sign-out-alt"></i>
				Logout
		</a></li>
	</nav>

	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<span class="close-btn" onclick="toggleSidebar()">&times;</span> <a
			href="SellerReportController">Report</a> <a
			href="ConsumerViewOrder.jsp">Orders</a>
	</div>

	<!-- Main Content -->
	<div class="content" id="main-content">
		<div class="container mt-4">
			<h2 class="text-center">Seller Product Management</h2>

			<!-- View Products Section -->
			<div class="card mt-4">
				<div class="card-header bg-info text-white">View Products</div>
				<div class="card-body">
					<form action="InsUpDel_Controller" method="post">
						<input type="hidden" name="action" value="view"> <input
							type="hidden" name="sellerID" value="<%=sellerId%>">
						<button type="submit" class="btn btn-info">View My
							Products</button>
					</form>

					<!-- Display Products -->
					<%
						List<InsUpDel_Pojo> products = (List<InsUpDel_Pojo>) request.getAttribute("products");
					if (products != null && !products.isEmpty()) {
					%>
					<table class="table table-hover table-striped table-bordered mt-3">
						<thead>
							<tr>
								<th>Product ID</th>
								<th>Product Name</th>
								<th>Price</th>
								<th>Quantity</th>
							</tr>
						</thead>
						<tbody>
							<%
								for (InsUpDel_Pojo product : products) {
							%>
							<tr>
								<td><%=product.getProductId()%></td>
								<td><%=product.getProductName()%></td>
								<td>$<%=product.getPrice()%></td>
								<td><%=product.getQuantity()%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
					<%
						}
					%>
				</div>
			</div>

			<!-- Add Product Form -->
			<div class="card mt-4">
				<div class="card-header bg-success text-white">Add Product</div>
				<div class="card-body">
					<form action="InsUpDel_Controller" method="post">
						<input type="hidden" name="action" value="add"> <input
							type="hidden" name="sellerID" value="<%=sellerId%>"> <input
							type="text" name="productName" class="form-control mb-2"
							placeholder="Product Name" required> <input type="number"
							name="price" class="form-control mb-2" placeholder="Price"
							required> <input type="number" name="quantity"
							class="form-control mb-2" placeholder="Quantity" required>
						<button type="submit" class="btn btn-success">Add Product</button>
					</form>
				</div>
			</div>

			<!-- Update Product Form -->
			<div class="card mt-4">
				<div class="card-header bg-warning text-dark">Update Product</div>
				<div class="card-body">
					<form action="InsUpDel_Controller" method="post">
						<input type="hidden" name="action" value="update"> <input
							type="hidden" name="sellerID" value="<%=sellerId%>"> <input
							type="number" name="productID" class="form-control mb-2"
							placeholder="Product ID" required> <input type="text"
							name="newName" class="form-control mb-2"
							placeholder="New Product Name"> <input type="number"
							name="newPrice" class="form-control mb-2" placeholder="New Price">
						<input type="number" name="newQuantity" class="form-control mb-2"
							placeholder="New Quantity">
						<button type="submit" class="btn btn-primary">Update
							Product</button>
					</form>
				</div>
			</div>

			<!-- Delete Product Form -->
			<div class="card mt-4">
				<div class="card-header bg-danger text-white">Delete Product</div>
				<div class="card-body">
					<form action="InsUpDel_Controller" method="post">
						<input type="hidden" name="action" value="delete"> <input
							type="hidden" name="sellerID" value="<%=sellerId%>"> <input
							type="number" name="productID" class="form-control mb-2"
							placeholder="Product ID" required>
						<button type="submit" class="btn btn-danger">Delete
							Product</button>
					</form>
				</div>
			</div>

		</div>
	</div>

	<script>
		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("active");
			document.getElementById("main-content").classList.toggle("shifted");
		}
	</script>
	<script>
		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("active");
		}
	</script>

	<footer>
		<p>&copy; 2025 PortCommerce. All rights reserved.</p>
	</footer>
</body>
</html>