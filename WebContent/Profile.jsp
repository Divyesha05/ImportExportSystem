<%@ page import="java.sql.*"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.util.Base64"%>
<%@ page session="true"%>

<%
	// Start session & get logged-in user info
Integer portId = (Integer) session.getAttribute("port_id");
String role = (String) session.getAttribute("role");

if (portId == null) {
	out.println("<p style='color:red;'>Error: Port ID is required. Please log in again.</p>");
	return;
}

// Database connection details
String jdbcURL = "jdbc:mysql://localhost:3306/importexportsystem";
String dbUser = "root";
String dbPassword = "";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String userLocation = "";

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

	// Fetch user info from the database
	String query = (role.equals("Consumer")) ? "SELECT location FROM consumer_port WHERE port_id = ?"
	: "SELECT location FROM seller_port WHERE port_id = ?";

	pstmt = conn.prepareStatement(query);
	pstmt.setInt(1, portId);
	rs = pstmt.executeQuery();

	if (rs.next()) {
		userLocation = rs.getString("location");
	} else {
		out.println("<p style='color:red;'>Error: User not found.</p>");
		return;
	}

} catch (Exception e) {
	out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
	e.printStackTrace();
} finally {
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Profile Update - PortCommerce</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	background: linear-gradient(to right, #141e30, #243b55);
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	margin: 0;
	font-family: 'Poppins', sans-serif;
}

.profile-card {
	background: rgba(255, 255, 255, 0.1);
	backdrop-filter: blur(15px);
	padding: 40px;
	border-radius: 15px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
	max-width: 420px;
	width: 100%;
	text-align: center;
	transition: 0.3s ease-in-out;
	color: #fff;
}

.profile-card:hover {
	transform: scale(1.03);
}

.form-control, .form-select {
	border-radius: 12px;
	background: rgba(255, 255, 255, 0.2);
	color: #fff;
	border: none;
}

.form-control::placeholder {
	color: rgba(255, 255, 255, 0.7);
}

.form-select option {
	color: black;
}

.btn-update {
	background: linear-gradient(to right, #007bff, #0056b3);
	color: white;
	font-weight: bold;
	border-radius: 30px;
	padding: 12px 30px;
	transition: 0.3s ease-in-out;
	border: none;
	width: 100%;
}

.btn-update:hover {
	background: linear-gradient(to right, #0056b3, #007bff);
	transform: scale(1.07);
}
</style>
</head>
<body>

	<div class="profile-card my-5">
		<h3 class="text-center">Update Your Profile</h3>

		<%
			String errorMessage = (String) request.getAttribute("errorMessage");
		%>
		<%
			if (errorMessage != null) {
		%>
		<div class="alert alert-danger text-center"><%=errorMessage%></div>
		<%
			}
		%>

		<!-- Display current info -->
		<p>
			<b>Port ID:</b>
			<%=portId%></p>
		<p>
			<b>Role:</b>
			<%=role%></p>
		<p>
			<b>Current Location:</b>
			<%=userLocation%></p>

		<!-- Update Form -->
		<form action="Profile.jsp" method="post">
			<input type="hidden" name="port_id" value="<%=portId%>"> <input
				type="hidden" name="role" value="<%=role%>">

			<div class="mb-3">
				<label>Old Password:</label> <input type="password"
					name="old_password" class="form-control"><br>
			</div>

			<div class="mb-3">
				<label>New Password:</label> <input type="password"
					name="new_password" class="form-control"><br>
			</div>

			<div class="mb-3">
				<label>Confirm New Password:</label> <input type="password"
					name="confirm_password" class="form-control"><br>
			</div>

			<div class="mb-3">
				<label>New Location:</label> <input type="text" name="new_location"
					value="<%=userLocation%>" class="form-control"><br>
			</div>

			<button type="submit" class="btn btn-update">Update</button>
		</form>

		<%
			// Handle form submission
		String oldPassword = request.getParameter("old_password");
		String newPassword = request.getParameter("new_password");
		String confirmPassword = request.getParameter("confirm_password");
		String newLocation = request.getParameter("new_location");

		if (request.getMethod().equals("POST")) {
			Connection conn2 = null;
			CallableStatement cstmt = null;

			try {
				conn2 = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
				cstmt = conn2.prepareCall("{CALL UpdateUserInfo(?, ?, ?, ?, ?, ?)}");

				cstmt.setInt(1, portId);
				cstmt.setString(2, role);
				cstmt.setString(3, oldPassword);
				cstmt.setString(4, newPassword);
				cstmt.setString(5, confirmPassword);
				cstmt.setString(6, newLocation);

				cstmt.execute();

				out.println("<p style='color:green;'>User information updated successfully!</p>");
			} catch (Exception e) {
				out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
				e.printStackTrace();
			} finally {
				if (cstmt != null)
			cstmt.close();
				if (conn2 != null)
			conn2.close();
			}
		}
		%>
	</div>

</body>
</html>