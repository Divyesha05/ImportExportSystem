<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, Pojo.ReportPojo" %>
<%
    // Fetch the reports from the request attribute
    List<ReportPojo> reports = (List<ReportPojo>) request.getAttribute("reports");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Reported Issues</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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

/* Table Styling */
table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #1d3557;
	color: white;
}

tr:hover {
	background-color: #f5f5f5;
}

.status-pending {
	color: #e63946;
	font-weight: bold;
}

.status-resolved {
	color: #2a9d8f;
	font-weight: bold;
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
        <span class="close-btn" onclick="toggleSidebar()">&times;</span>
        <a href="home.jsp">Home</a>
        <a href="viewProducts">Products</a>
        <a href="cart.jsp">My Cart</a>
        <a href="order_confirmation.jsp">My Orders</a>
        <a href="SellerReportController">Reported products</a>
        <a href="Profile.jsp">My Profile</a>
    </div>

    <div class="container">
        <h2>Your Reported Issues</h2>
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>Report ID</th>
                    <th>Product Name</th>
                    <th>Issue Type</th>
                    <th>Report Date</th>
                    <th>Status</th>
                    <th>Solution</th>
                </tr>
            </thead>
            <tbody>
                <% for (ReportPojo report : reports) { %>
                <tr>
                    <td><%=report.getReportId()%></td>
                    <td><%=report.getProductName()%></td>
                    <td><%=report.getIssueType()%></td>
                    <td><%=report.getReportDate()%></td>
                    <td><%="pending".equalsIgnoreCase(report.getSolution()) ? "<span class='status-pending'>Pending</span>" : "<span class='status-resolved'>Resolved</span>"%></td>
                    <td><%=report.getSolution()%></td>
                </tr>
                <% } %>
            </tbody>
        </table>
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
