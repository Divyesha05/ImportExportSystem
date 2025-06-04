<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List, Pojo.ReportPojo"%>
<%
	List<ReportPojo> reports = (List<ReportPojo>) request.getAttribute("reports");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Seller Reported Issues</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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

.table {
	background: white;
	border-collapse: separate;
	border-spacing: 0;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.table th, .table td {
	padding: 15px;
	text-align: center;
}

.table th {
	background-color: #1d3557;
	color: white;
	font-weight: bold;
}

.table tbody tr {
	transition: background-color 0.3s ease;
}

.table tbody tr:hover {
	background-color: #f1f1f1;
}

.table tbody tr:nth-child(even) {
	background-color: #f9f9f9;
}

.table tbody tr:nth-child(even):hover {
	background-color: #f1f1f1;
}

.solved-btn {
	cursor: not-allowed;
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
		<button class="toggle-btn" onclick="toggleSidebar()">
			<i class="fas fa-bars"></i>
		</button>
		<a class="navbar-brand ms-5" href="SellerInsUpDel.jsp">PortCommerce</a>
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
		<div class="container mt-5">
			<h2 class="text-center text-primary mb-4">Reported Issues from
				Consumers</h2>
			<div class="table-responsive">
				<table class="table table-bordered table-striped">
					<thead class="table-dark">
						<tr>
							<th>Report ID</th>
							<th>Product Name</th>
							<th>Issue Type</th>
							<th>Report Date</th>
							<th>Status</th>
							<th>Solution</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody id="issueTable">
						<%
							for (ReportPojo report : reports) {
						%>
						<tr id="row-<%=report.getReportId()%>">
							<td><%=report.getReportId()%></td>
							<td><%=report.getProductName()%></td>
							<td><%=report.getIssueType()%></td>
							<td><%=report.getReportDate()%></td>
							<td id="status-<%=report.getReportId()%>">
								<%
									if ("pending".equalsIgnoreCase(report.getSolution())) {
								%> <span
								class="text-warning">⚠️ Pending</span> <%
 	} else {
 %> <span
								class="text-success">✅ Solved</span> <%
 	}
 %>
							</td>
							<td id="solution-<%=report.getReportId()%>"><%=report.getSolution()%></td>
							<td id="action-<%=report.getReportId()%>">
								<%
									if ("pending".equalsIgnoreCase(report.getSolution())) {
								%>
								<form action="SellerReportController" method="POST"
									style="display: inline;">
									<input type="hidden" name="report_id"
										value="<%=report.getReportId()%>">
									<button type="submit" class="btn btn-success">✔ Mark
										as Solved</button>
								</form> <%
 	} else {
 %>
								<button class="btn btn-secondary solved-btn" disabled>✔
									Already Solved</button> <%
 	}
 %>
							</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="fixed-bottom">
		<p>&copy; 2025 PortCommerce. All rights reserved.</p>
	</footer>

	<script>
		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("active");
			document.getElementById("main-content").classList.toggle("shifted");
		}
	</script>
</body>
</html>