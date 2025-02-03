<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@page isELIgnored="false"%>
<title>Employee Management System</title>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.hero-section {
	min-height: 100vh;
	background-color: #f8f9fa;
	background-image:
		url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%239C92AC' fill-opacity='0.1'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
	padding: 2rem;
	position: relative;
	overflow: hidden;
}

.hero-section::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: linear-gradient(135deg, rgba(147, 206, 222, 0.8) 0%,
		rgba(117, 189, 209, 0.8) 41%, rgba(73, 165, 191, 0.8) 100%);
	z-index: 1;
}

.container {
	position: relative;
	z-index: 2;
}

.card-container {
	margin-top: 3rem;
	display: flex;
	gap: 2rem;
	justify-content: center;
	flex-wrap: wrap;
}

.action-card {
	width: 340px;
	transition: all 0.3s ease;
	background: rgba(255, 255, 255, 0.95);
	border-radius: 15px;
	padding: 2rem;
	text-align: center;
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
	border: 1px solid rgba(255, 255, 255, 0.2);
	backdrop-filter: blur(10px);
}

.action-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
}

.welcome-text {
	color: #1a237e;
	font-size: 3rem;
	margin-bottom: 1.5rem;
	font-weight: 700;
	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
}

.subtitle {
	color: #283593;
	font-size: 1.4rem;
	margin-bottom: 3rem;
	font-weight: 400;
	max-width: 800px;
	margin-left: auto;
	margin-right: auto;
}

.action-card h3 {
	color: #1a237e;
	font-size: 1.8rem;
	margin-bottom: 1rem;
	font-weight: 600;
}

.action-card p {
	color: #455a64;
	font-size: 1.1rem;
	margin-bottom: 1.5rem;
	line-height: 1.6;
}

.btn-custom {
	padding: 1rem 2rem;
	font-size: 1.1rem;
	border-radius: 50px;
	text-decoration: none;
	transition: all 0.3s ease;
	display: inline-block;
	font-weight: 500;
	text-transform: uppercase;
	letter-spacing: 1px;
}

.btn-add {
	background: linear-gradient(45deg, #2ecc71, #27ae60);
	color: white;
	border: none;
}

.btn-list {
	background: linear-gradient(45deg, #3498db, #2980b9);
	color: white;
	border: none;
}

.btn-custom:hover {
	transform: scale(1.05);
	color: white;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

/* Added icon styles */
.action-card::before {
	content: '';
	display: block;
	width: 60px;
	height: 60px;
	margin: 0 auto 1.5rem;
	background-size: contain;
	background-repeat: no-repeat;
	background-position: center;
}

.action-card:nth-child(1)::before {
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%232ecc71'%3E%3Cpath d='M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z'/%3E%3C/svg%3E");
}

.action-card:nth-child(2)::before {
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%233498db'%3E%3Cpath d='M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z'/%3E%3C/svg%3E");
}

.action-card:nth-child(3)::before {
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23d32f2f'%3E%3Cpath d='M12 2C6.48 2 2 4.48 2 7v6c0 2.52 3.06 4.69 7 4.95V22h6v-4.05c3.94-.26 7-2.43 7-4.95V7c0-2.52-4.48-5-10-5zm0 2c4.97 0 8 2.15 8 3s-3.03 3-8 3-8-2.15-8-3 3.03-3 8-3zm0 12c-3.86 0-7-1.13-7-2.5S8.14 11 12 11s7 1.13 7 2.5-3.14 2.5-7 2.5zm0 2c4.97 0 8-2.15 8-3s-3.03-3-8-3-8 2.15-8 3 3.03 3 8 3z'/%3E%3C/svg%3E");
}
</style>

</head>
<body>
	<div
		class="hero-section d-flex align-items-center justify-content-center">
		<div class="container">
			<h1 class="welcome-text text-center">Welcome to Employee
				Management</h1>
			<p class="subtitle text-center">Streamline your workforce
				management with our intuitive system</p>

			<div class="card-container">
				<div class="action-card">
					<h3>New Employee</h3>

					<a href="${pageContext.request.contextPath}/signup" class="btn btn-custom btn-add">Signup</a>
				</div>

				<div class="action-card">
					<h3>Existing Employee</h3>

					<a href="${pageContext.request.contextPath}/signin"
						class="btn btn-custom btn-list">Signin</a>
				</div>
				<div class="action-card">
					<h3>Admin Login</h3>

					<a href="${pageContext.request.contextPath}/login"
						class="btn btn-custom btn-list">Login</a>
				</div>

			</div>
		</div>
	</div>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>