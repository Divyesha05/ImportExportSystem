<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>PortCommerce</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<style type="text/css">
.carousel-item img {
	height: 500px; /* Adjust the height as needed */
	object-fit: cover;
	/* Ensures the image fits within the defined height */
	width: 100%;
}
</style>
</head>
<body>
	<header>
		<nav class="navbar navbar-expand-sm navbar-dark bg-dark text-light">
			<div class="container">
				<button class="navbar-toggler d-lg-none" type="button"
					data-bs-toggle="collapse" data-bs-target="#collapsibleNavId"
					aria-controls="collapsibleNavId" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="collapsibleNavId">
					<ul class="navbar-nav me-auto mt-2 mt-lg-0">
						<li class="nav-item"><a class="nav-link active"
							href="home.jsp">PortCommerce</a></li>

					</ul>
					<form class="d-flex" action="register.jsp">
						<button class="btn btn-outline-success mx-2" type="submit">Register</button>
					</form>
					<form class="d-flex" action="login.jsp">
						<button class="btn btn-outline-success" type="submit">Login</button>
					</form>
				</div>
			</div>
		</nav>
	</header>

	<main>
		<div>
			<h1 class="text-center mt-5">Welcome to PortCommerce</h1>
		</div>
		<div class="container my-5">
			<div id="carouselId" class="carousel slide" data-bs-ride="carousel">
				<ol class="carousel-indicators">
					<li data-bs-target="#carouselId" data-bs-slide-to="0"
						class="active"></li>
					<li data-bs-target="#carouselId" data-bs-slide-to="1"></li>
					<li data-bs-target="#carouselId" data-bs-slide-to="2"></li>
				</ol>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<img
							src="https://cdn.pixabay.com/photo/2021/09/30/17/54/port-6670684_1280.jpg"
							alt="First slide">
					</div>
					<div class="carousel-item">
						<img
							src="https://cdn.pixabay.com/photo/2017/08/01/21/54/container-2568197_640.jpg"
							class="w-100 d-block" alt="Second slide">
					</div>
					<div class="carousel-item">
						<img
							src="https://cdn.pixabay.com/photo/2021/09/30/17/53/port-6670683_640.jpg"
							class="w-100 d-block" alt="Third slide">
					</div>
				</div>
				<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselId" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#carouselId" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
		</div>

		<div class="container my-5">
			<h1 class="text-center">Features</h1>
			<div
				class="row justify-content-center align-items-center g-2 text-center">
				<div class="col-md-4 my-3">
					<div class="card">
						<div class="card-body">
							<h4 class="card-title">Consumers Can Order</h4>
							<p class="card-text">Consumers can browse and place orders
								for products seamlessly.</p>
						</div>
					</div>
				</div>
				<div class="col-md-4 my-3">
					<div class="card">
						<div class="card-body">
							<h4 class="card-title">Consumers Can Track Their Order</h4>
							<p class="card-text">Real-time tracking of orders for better
								transparency and convenience.</p>
						</div>
					</div>
				</div>
				<div class="col-md-4 my-3">
					<div class="card">
						<div class="card-body">
							<h4 class="card-title">Consumers Can Report Issues</h4>
							<p class="card-text">A streamlined process for consumers to
								report any issues with their orders.</p>
						</div>
					</div>
				</div>
				<div class="col-md-4 my-3">
					<div class="card">
						<div class="card-body">
							<h4 class="card-title">Consumers Can Edit Their Profile</h4>
							<p class="card-text">Users can update personal details and
								manage their account settings.</p>
						</div>
					</div>
				</div>
				<div class="col-md-4 my-3">
					<div class="card">
						<div class="card-body">
							<h4 class="card-title">Sellers Can List Their Products</h4>
							<p class="card-text">A feature for sellers to add, manage,
								and showcase their products.</p>
						</div>
					</div>
				</div>
				<div class="col-md-4 my-3">
					<div class="card">
						<div class="card-body">
							<h4 class="card-title">Sellers Can Address Reported Issues</h4>
							<p class="card-text">Sellers can respond to consumer concerns
								and resolve disputes efficiently.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="container my-5">
			<h1 class="text-center">About Us</h1>
			<p class="text-center">We are Group One, comprising Amulya Ambre,
				Avnish Alves, Aditya Stuar, Amit Mishra, Deeksha Kharvi, Shubhangi
				Mohite, and Divyesha Bari. We created PortCommerce as our project,
				aiming to bridge the gap between consumers and sellers through an
				efficient online marketplace.</p>
		</div>

		<div class="container my-5">
			<h1 class="text-center">Contact Us</h1>
			<table class="table text-center">
				<tr>
					<th>Email</th>
					<td>info@portcommerce.com</td>
				</tr>
				<tr>
					<th>Phone</th>
					<td>+91 98765 43210</td>
				</tr>
				<tr>
					<th>Address</th>
					<td>123, Business Street, Mumbai, India</td>
				</tr>
			</table>
		</div>
	</main>

	<footer class="text-light text-center bg-dark ">
		<h3 class="py-2">&copy; All rights Reserved.</h3>
	</footer>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>