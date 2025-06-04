<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Report Product</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
		<a class="navbar-brand ms-5" href="viewProducts">PortCommerce</a>
		<li class="nav-item"><a class="nav-link" href="logout.jsp"
			style="color: #ff6b6b;"> <i class="fas fa-sign-out-alt"></i>
				Logout
		</a></li>
	</nav>

	<div class="sidebar" id="sidebar">
		<span class="close-btn" onclick="toggleSidebar()">&times;</span> <a
			href="home.jsp">Home</a> <a href="viewProducts">Products</a> <a
			href="cart.jsp">My Cart</a> <a href="order_confirmation.jsp">My
			Orders</a> <a href="consumer_reported_issues.jsp">Reported products</a> <a
			href="Profile.jsp">My Profile</a>
	</div>

	<div class="container">
		<h2>Report a Product</h2>

		<%-- Display errors if any --%>
		<%
			String errorMessage = (String) request.getAttribute("errorMessage");
		%>
		<%
			if (errorMessage != null) {
		%>
		<div class="alert alert-danger">
			<%=errorMessage%>
		</div>
		<%
			}
		%>

		<form action="ReportController" method="post">
			<div class="form-group">
				<label for="product_id">Product ID:</label> <input type="number"
					class="form-control" id="product_id" name="product_id"
					value="${product_id}" readonly required>
			</div>
			<div class="form-group">
				<label for="consumer_port_id">Consumer Port ID:</label> <input
					type="number" class="form-control" id="consumer_port_id"
					name="consumer_port_id"
					value="<%=session.getAttribute("port_id")%>" readonly required>
			</div>
			<div class="form-group">
				<label for="issueType">Issue Type:</label> <select
					class="form-control" id="issueType" name="issueType" required>
					<option value="">-- Select Issue Type --</option>
					<option value="DAMAGE">Damage</option>
					<option value="WRONG_PRODUCT">Wrong Product</option>
					<option value="DELAYED">Delayed</option>
					<option value="STILL_NOT_RECEIVED">Still Not Received</option>
					<option value="MISSING">Missing</option>
					<option value="CUSTOM">Custom</option>
				</select>
			</div>
			<button type="submit" class="btn btn-danger">Report</button>
		</form>
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