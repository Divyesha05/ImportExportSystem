<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="product.css">
    <script>
        let cart = JSON.parse(localStorage.getItem("cart")) || [];

        function addToCart(id, name, price) {
            let product = cart.find(item => item.id === id);
            if (product) {
                product.quantity += 1;
            } else {
                cart.push({ id, name, price, quantity: 1 });
            }
            localStorage.setItem("cart", JSON.stringify(cart));
            alert("Product added to cart");
        }
    
    function setProductName(productName) {
      document.getElementById("product-name").textContent = "You are reporting: " + productName;
    }
  </script>
  <style>
body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    background-color: #ffffff;
    font-family: 'Arial', sans-serif;
    color: #000000;
}

.container h1 {
    text-align: center;
    margin-bottom: 30px;
}

.card {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    border-radius: 12px;
    overflow: hidden;
    background: #ffffff;
    border: none;
}

.card-header {
    background: #343a40; /* Changed to #343a40 */
    color: white;
    text-align: center;
    padding: 25px;
    font-size: 1.5rem;
    font-weight: bold;
}

.profile-section {
    text-align: center;
    padding: 20px;
}

.profile-image {
    width: 140px;
    height: 140px;
    border-radius: 50%;
    object-fit: cover;
    border: 5px solid #dee2e6;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.profile-info h5 {
    font-size: 1.3rem;
    color: #000000;
}

.account-settings {
    padding: 20px;
}

.account-settings ul {
    list-style: none;
    padding: 0;
    margin-bottom: 20px;
}

.account-settings li {
    margin-bottom: 10px;
    font-size: 1.1rem;
}

.account-settings a {
    color: #343a40;
    text-decoration: none;
    font-weight: bold;
    display: flex;
    align-items: center;
    transition: color 0.3s;
}

.account-settings a:hover {
    color: #495057;
}

.account-settings a i {
    margin-right: 10px;
}

.edit-profile-btn {
    display: block;
    width: 150px;
    padding: 10px;
    font-size: 1rem;
    font-weight: bold;
    background: #007bff;
    border: none;
    border-radius: 8px;
    color: white;
    text-align: center;
    transition: 0.3s;
    margin: 0 auto; /* Centers the button */
}

.edit-profile-btn:hover {
    background: #0056b3;
}

/* Navbar styling */
.navbar {
    background-color: #131921; /* Changed to #343a40 */
    color: white;
}

.navbar .navbar-brand, .navbar .nav-link {
    color: white;
}

.navbar .navbar-collapse {
    display: flex;
    justify-content: space-between; /* Ensures space between nav items and search/cart buttons */
    align-items: center; /* Aligns items vertically */
    width: 100%; /* Take up full width */
}

.navbar .search-box {
    padding: 10px;
    margin-left: 20px;
}

.navbar .search-box input {
    border-radius: 5px;
}

.navbar button {
    display: flex;
    align-items: center;
}

.navbar .cart-button {
    margin-left: auto; /* Pushes cart button to the right */
    margin-right: 10px; /* Adds space between the cart button and right edge */
    padding: 10px 15px;
    display: flex;
    align-items: center;
    background-color: #ffc107; /* Cart button color */
    border: none;
    color: white;
    font-size: 16px;
}

.navbar .cart-button .badge {
    margin-left: 5px; /* Adds some space between cart label and count */
}

/* Main content padding */
.main-content {
    flex: 1;
    padding: 50px;
}

.card-body {
    padding: 20px;
    display: flex;
    flex-direction: column;
}

.card-title {
    margin-bottom: 10px;
}

.card-text {
    margin-bottom: 20px;
}

.card .btn {
    align-self: flex-start;
}

.card .cart-icon {
    position: absolute;
    bottom: 20px;
    right: 20px;
    font-size: 1.5rem;
    color: #343a40;
}

.search-box {
    margin-bottom: 20px;
}

.search-box input {
    border-radius: 5px;
}

/* Footer Styling */
footer {
    background-color: #131921; /* Changed to #343a40 */
    color: white;
    padding: 20px;
    text-align: center;
    margin-top: auto;
}

footer a {
    color: white;
    margin: 0 10px;
    text-decoration: none;
}

footer p {
    margin-top: 20px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .navbar {
        flex-direction: column;
        align-items: flex-start;
    }

    .navbar .search-box {
        width: 100%;
        margin-bottom: 10px;
    }

    .navbar .cart-button {
        margin-right: 0; /* Remove right margin for smaller screens */
    }

    .main-content {
        padding: 20px;
    }

    .profile-image {
        width: 120px;
        height: 120px;
    }

    .card-header {
        font-size: 1.3rem;
    }
}
</style>
</head>
<body>
    <nav class="navbar navbar-expand-lg p-2">
        <div class="container-fluid">
            <a class="navbar-brand" href="#" style="color:white;">PortCommerce</a> <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-home me-2"></i>Home</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            <i class="fas fa-th-large me-2"></i>Products
                        </a>
                        <ul class="dropdown-menu ">
                            <li><a class="dropdown-item" href="product.html">Electronics</a></li>
                            <li><a class="dropdown-item" href="product.html">Clothing</a></li>
                            <li><a class="dropdown-item" href="product.html">Books</a></li>
                            <li><a class="dropdown-item" href="product.html">Home Decor</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cart.html"><i class="fas fa-shopping-cart me-2"></i>My Cart</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="order.html"><i class="fas fa-box me-2"></i>My Orders</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="orderhistory.html"><i class="fas fa-history me-2"></i>Order History</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="profile.html"><i class="fas fa-user me-2"></i>User Profile</a>
                    </li>
                </ul>
                <div class="search-box ms-auto pt-4 ">
                    <input type="text" class="form-control" placeholder="Search...">
                </div>
            </div>
        </div>
    </nav>

<main class="container mt-5">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    <h2 class="mb-4">Products</h2>
    <h2 class="">Electronics</h2>
    <div class="row">
        <div class="col-md-4 my-5">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Product 1</h5>
                    <p class="card-text">Price: $10</p>
                    <div class="d-flex justify-content-between">
                        <button class="btn btn-primary" onclick="addToCart(1, 'Product 1', 10)">Add to Cart</button>
                        <button class="btn btn-success" onclick="buyNow(1, 'Product 1', 10)">Buy Now</button>
                    </div>
                    <button class="btn btn-danger btn-sm mt-2 report-btn" data-bs-toggle="modal" data-bs-target="#reportModal" onclick="setProductName('Product 1')">View Product Details</button>
                </div>
            </div>
        </div>
        <div class="col-md-4 my-5">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Product 2</h5>
                    <p class="card-text">Price: $20</p>
                    <div class="d-flex justify-content-between">
                        <button class="btn btn-primary" onclick="addToCart(2, 'Product 2', 20)">Add to Cart</button>
                        <button class="btn btn-success" onclick="buyNow(2, 'Product 2', 20)">Buy Now</button>
                    </div>
                    <button class="btn btn-danger btn-sm mt-2 report-btn" data-bs-toggle="modal" data-bs-target="#reportModal" onclick="setProductName('Product 2')">View Product Details</button>
                </div>
            </div>
        </div>
            <div class="col-md-4 my-5">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Product 3</h5>
                        <p class="card-text">Price: $30</p>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-primary" onclick="addToCart(3, 'Product 3', 30)">Add to Cart</button>
                            <button class="btn btn-success" onclick="buyNow(3, 'Product 3', 30)">Buy Now</button>
                        </div>
                        <button class="btn btn-danger btn-sm mt-2 report-btn" data-bs-toggle="modal" data-bs-target="#reportModal" onclick="setProductName('Product 3')">View Product Details</button>
                    </div>
                </div>
            </div>
                    <div class="col-md-4 my-5">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Product 4</h5>
                        <p class="card-text">Price: $40</p>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-primary" onclick="addToCart(4, 'Product 4', 40)">Add to Cart</button>
                            <button class="btn btn-success" onclick="buyNow(4, 'Product 4', 40)">Buy Now</button>
                        </div>
                        <button class="btn btn-danger btn-sm mt-2 report-btn" data-bs-toggle="modal" data-bs-target="#reportModal" onclick="setProductName('Product 4')">View Product Details</button>
                    </div>
                </div>
            </div>
                    <div class="col-md-4 my-5">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Product 5</h5>
                        <p class="card-text">Price: $50</p>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-primary" onclick="addToCart(5, 'Product 5', 50)">Add to Cart</button>
                            <button class="btn btn-success" onclick="buyNow(5, 'Product 5', 50)">Buy Now</button>
                        </div>
                        <button class="btn btn-danger btn-sm mt-2 report-btn" data-bs-toggle="modal" data-bs-target="#reportModal" onclick="setProductName('Product 5')">View Product Details</button>
                    </div>
                </div>
            </div>
                    <div class="col-md-4 my-5">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Product 6</h5>
                        <p class="card-text">Price: $60</p>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-primary" onclick="addToCart(6, 'Product 6', 60)">Add to Cart</button>
                            <button class="btn btn-success" onclick="buyNow(6, 'Product 6', 60)">Buy Now</button>
                        </div>
                        <button class="btn btn-danger btn-sm mt-2 report-btn" data-bs-toggle="modal" data-bs-target="#reportModal" onclick="setProductName('Product 6')">View Product Details</button>
                    </div>
                </div>
            </div>
                    <div class="col-md-4 my-5">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Product 7</h5>
                        <p class="card-text">Price: $70</p>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-primary" onclick="addToCart(7, 'Product 7', 70)">Add to Cart</button>
                            <button class="btn btn-success" onclick="buyNow(7, 'Product 7', 70)">Buy Now</button>
                        </div>
                        <button class="btn btn-danger btn-sm mt-2 report-btn" data-bs-toggle="modal" data-bs-target="#reportModal" onclick="setProductName('Product 7')">View Product Details</button>
                    </div>
                </div>
            </div>
                    <div class="col-md-4 my-5">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Product 8</h5>
                        <p class="card-text">Price: $80</p>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-primary" onclick="addToCart(8, 'Product 8', 80)">Add to Cart</button>
                            <button class="btn btn-success" onclick="buyNow(8, 'Product 8', 80)">Buy Now</button>
                        </div>
                        <button class="btn btn-danger btn-sm mt-2 report-btn" data-bs-toggle="modal" data-bs-target="#reportModal" onclick="setProductName('Product 8')">View Product Details</button>
                    </div>
                </div>
            </div>
    
    
    </div>
    <main class="container mt-5">
        <div class="col-md-4 my-5">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Product 1</h5>
                    <p class="card-text">Price: $10</p>
                    <div class="d-flex justify-content-between">
                        <button class="btn btn-primary" onclick="addToCart(1, 'Product 1', 10)">Add to Cart</button>
                        <button class="btn btn-success" onclick="buyNow(1, 'Product 1', 10)">Buy Now</button>
                    </div>
                   <button class="btn btn-danger btn-sm mt-2 report-btn" data-bs-toggle="modal" data-bs-target="#reportModal" onclick="showProductDetails('Product 1', 'This is the description for Product 1.  It is a wonderful product.')">View Product Details</button>

                </div>
            </div>
        </div>
        <div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="reportModalLabel">Product Description</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p id="product-name"></p>
                        <p id="product-description">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quidem aperiam eum distinctio, velit alias cum ut cupiditate culpa, nesciunt inventore explicabo iste repellat itaque sapiente natus cumque repellendus veritatis. Repudiandae minima iste cupiditate officiis eveniet eum ratione inventore fuga quibusdam dicta distinctio, ipsa ex odit commodi quaerat deserunt est voluptas!</p>  </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button class="btn btn-primary" onclick="addToCart(1, 'Product 1', 10)">Add to Cart</button>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script>
        function showProductDetails(productName, productDescription) {
            document.getElementById("product-name").textContent = productName;
            document.getElementById("product-description").textContent = productDescription; // Set the description
        }
        function buyNow(id, name, price) {
            addToCart(id, name, price); // Add to cart first
            window.location.href = "cart.html"; // Redirect to cart
        }
    </script>

</main>
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <h5>Product Categories</h5>
                    <ul class="list-unstyled">
                        <li><a href="#">Category 1</a></li>
                        <li><a href="#">Category 2</a></li>
                        <li><a href="#">Category 3</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5>About Us</h5>
                    <ul class="list-unstyled">
                        <li><a href="#">Our Story</a></li>
                        <li><a href="#">Our Team</a></li>
                        <li><a href="#">Careers</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5>Contact Us</h5>
                    <ul class="list-unstyled">
                        <li><a href="#">Contact Information</a></li>
                        <li><a href="#">FAQ</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <p>&copy; 2025 PortCommerce. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

</body>
</html>