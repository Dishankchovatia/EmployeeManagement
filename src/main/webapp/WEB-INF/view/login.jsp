<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Management - Login</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2563eb;
            --primary-hover: #1d4ed8;
            --danger-color: #ef4444;
            --danger-hover: #dc2626;
            --text-primary: #1f2937;
            --text-secondary: #4b5563;
            --border-color: #e5e7eb;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #eff6ff 0%, #eef2ff 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
            color: var(--text-primary);
        }

        .container {
            width: 100%;
            max-width: 28rem;
            background: white;
            padding: 2.5rem;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .header h1 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.75rem;
        }

        .header p {
            color: var(--text-secondary);
            font-size: 0.95rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .form-group label {
            display: block;
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .input-wrapper {
            position: relative;
        }

        .form-control {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 0.5rem;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
        }

        .password-toggle {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            cursor: pointer;
            padding: 0.25rem;
            background: none;
            border: none;
        }

        .btn {
            width: 100%;
            padding: 0.875rem 1rem;
            border-radius: 0.5rem;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.2s ease;
            cursor: pointer;
            border: none;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
            margin-bottom: 1rem;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
        }

        .error-message, .success-message {
            padding: 0.875rem 1rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            margin-top: 1rem;
            text-align: center;
        }

        .error-message {
            background-color: #fef2f2;
            border: 1px solid #fee2e2;
            color: var(--danger-color);
        }

        .success-message {
            background-color: #f0fdf4;
            border: 1px solid #dcfce7;
            color: #15803d;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Welcome Back</h1>
            <p>Please enter your credentials to access your account</p>
        </div>

        <form action="${pageContext.request.contextPath}/handle-login" method="post">
            <div class="form-group">
                <label for="userId">Employee ID / Email / Admin ID</label>
                <input type="text" class="form-control" id="userId" name="userId" 
                       placeholder="Enter your ID or email" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <input type="password" class="form-control" id="password" 
                           name="password" placeholder="Enter your password" required>
                    <i class="fa fa-eye password-toggle" id="togglePassword"></i>
                </div>
            </div>

            <button type="submit" class="btn btn-primary">Sign In</button>
        </form>

        <!-- Error Messages -->
        <c:if test="${fn:contains(param.error, 'invalid')}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                Invalid email ID or password.
            </div>
        </c:if>
        <c:if test="${fn:contains(param.error, 'deactivated')}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                Your account is deactivated.
            </div>
        </c:if>

        <!-- Success Message -->
        <c:if test="${param.logout == 'true'}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i>
                You have been successfully logged out.
            </div>
        </c:if>
    </div>

    <script>
        document.getElementById("togglePassword").addEventListener("click", function() {
            const passwordField = document.getElementById("password");
            const icon = this;
            
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
    </script>
</body>
</html>