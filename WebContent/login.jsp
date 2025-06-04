<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - PortCommerce</title>
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

.login-card {
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

.login-card:hover {
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

.btn-login {
	background: linear-gradient(to right, #007bff, #0056b3);
	color: white;
	font-weight: bold;
	border-radius: 30px;
	padding: 12px 30px;
	transition: 0.3s ease-in-out;
	border: none;
	width: 100%;
}

.btn-login:hover {
	background: linear-gradient(to right, #0056b3, #007bff);
	transform: scale(1.07);
}

.register-link {
	color: #00c6ff;
	text-decoration: none;
	font-weight: bold;
}

.register-link:hover {
	text-decoration: underline;
}
</style>
</head>
<body>

	<div class="login-card my-5">
		<h3 class="text-center">Welcome Back to PortCommerce!!!</h3>

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

		<form action="LoginController" method="post">
			<div class="mb-3">
				<input type="text" class="form-control" name="port_id"
					placeholder="Port ID" required>
			</div>
			<div class="mb-3">
				<input type="password" class="form-control" name="password"
					placeholder="Password" required>
			</div>
			<div class="mb-3">
				<select class="form-select" name="role" required>
					<option selected disabled>Select Role</option>
					<option value="Consumer">Consumer</option>
					<option value="Seller">Seller</option>
				</select>
			</div>
			<button type="submit" class="btn btn-login">Login</button>
			<p class="mt-3">
				New here? <a href="register.jsp" class="register-link">Register</a>
			</p>
		</form>
	</div>

</body>
</html>