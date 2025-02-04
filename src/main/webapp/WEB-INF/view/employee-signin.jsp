<!DOCTYPE html>
<html>
<head>
<title>Employee Login</title>
<%@include file="./base.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
/* General Reset */
body {
    margin: 0;
    padding: 0;
    font-family: 'Arial', sans-serif;
    background-color: #f0f2f5;
    color: #333;
}

/* Login Container */
.login-container {
    max-width: 400px;
    margin: 100px auto;
    padding: 30px;
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    text-align: center;
}

.login-container h2 {
    margin-bottom: 20px;
    font-size: 24px;
    color: #007bff;
}

/* Form Group */
.form-group {
    margin-bottom: 20px;
    text-align: left;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: #555;
}

.form-group input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    color: #333;
    transition: border-color 0.3s ease;
}

.form-group input:focus {
    border-color: #007bff;
    outline: none;
}

/* Password Wrapper */
.password-wrapper {
    position: relative;
}

.password-wrapper input {
    padding-right: 40px;
}

.password-wrapper i {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    color: #888;
    font-size: 18px;
    cursor: pointer;
    transition: color 0.3s ease;
}

.password-wrapper i:hover {
    color: #007bff;
}

/* Buttons */
.btn-login {
    width: 100%;
    background-color: #007bff;
    color: white;
    padding: 12px;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.btn-login:hover {
    background-color: #0056b3;
}

.btn-back {
    display: inline-block;
    margin-top: 15px;
    color: #007bff;
    text-decoration: none;
    font-size: 14px;
    transition: color 0.3s ease;
}

.btn-back:hover {
    color: #0056b3;
}

/* Error Messages */
.error-message {
    margin-top: 15px;
    font-size: 14px;
    color: #dc3545;
}

.success-message {
    margin-top: 15px;
    font-size: 14px;
    color: #28a745;
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
				<label for="emailId">Email ID:</label> 
				<input type="text" id="emailId" name="emailId" required>
			</div>

			<div class="form-group">
				<label for="password">Password:</label>
				<div class="password-wrapper">
					<input type="password" id="password" name="password" required>
					<i class="fa fa-eye" id="togglePassword"></i>
				</div>
			</div>
			
			<button type="submit" class="btn-login">Login</button>
			<a href="${pageContext.request.contextPath}/" class="btn-back">Back</a>
		</form>

		<!-- Error Messages -->
		<c:if test="${fn:contains(param.error, 'invalid')}">
			<p class="error-message">Invalid email ID or password.</p>
		</c:if>
		<c:if test="${fn:contains(param.error, 'deactivated')}">
			<p class="error-message">Your account is deactivated.</p>
		</c:if>

		<!-- Success Message -->
		<c:if test="${param.logout == 'true'}">
			<div class="success-message">You have been successfully logged out.</div>
		</c:if>
	</div>
</body>
</html>