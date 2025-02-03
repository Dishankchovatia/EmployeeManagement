<!DOCTYPE html>
<html>
<head>
<title>Employee Login</title>
<%@include file="./base.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
.login-container {
	max-width: 400px;
	margin: 100px auto;
	padding: 20px;
	background: #f9f9f9;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

.form-group input {
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.btn-login {
	background-color: #007bff;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.btn-login:hover {
	background-color: #0056b3;
}

.password-wrapper {
    position: relative;
}

.password-wrapper input {
    width: 100%;
    padding: 10px 40px 10px 10px; 
    border: 1px solid #ccc;
    border-radius: 5px;
}

.password-wrapper i {
    position: absolute;
    right: 10px; 
    top: 50%;
    transform: translateY(-50%); 
    color: #888;
    font-size: 18px;
}
</style>
<script>
window.onload = function () {
    document.getElementById("togglePassword").addEventListener("click", function () {
        var passwordField = document.getElementById("password");
        var icon = document.getElementById("togglePassword");
        if (passwordField.type === "password") {
            passwordField.type = "text"; 
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            passwordField.type = "password"; 
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    });
};
</script>
</head>
<body>
	<div class="login-container">
		<h2>Employee Login</h2>
		<form action="handle-signin" method="POST">
			<div class="form-group">
				<label for="emailId">EmailID:</label> <input type="text"
					id="emailId" name="emailId" required>
			</div>

			<div class="form-group">
				<label for="password">Password:</label>
				<div class="password-wrapper">
					<input type="password" id="password" name="password" required>
					<i class="fa fa-eye" id="togglePassword" style="cursor: pointer;"></i>
				</div>
			</div>
			
			<button type="submit" class="btn-login">Login</button>
			<a href="${pageContext.request.contextPath}/"
				class="btn btn-outline-danger">Back</a>
		</form>
		<c:if test="${fn:contains(param.error, 'invalid')}">
			<p style="color: red;">Invalid email ID or password.</p>
		</c:if>
		<c:if test="${fn:contains(param.error, 'deactivated')}">
			<p style="color: red;">Your account is deactivated.</p>
		</c:if>
		<!-- Add this near the top of your login form -->
		<c:if test="${param.logout == 'true'}">
			<div class="alert alert-success">You have been successfully
				logged out.</div>
		</c:if>
	</div>
</body>
</html>