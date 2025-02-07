<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@page isELIgnored="false"%>
    <title>Employee Management System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background-color: #f8f9fa;
        }

        .nav-container {
            position: fixed;
            top: 0;
            right: 0;
            padding: 1rem 2rem;
            z-index: 1000;
        }

        .hero-section {
            min-height: 100vh;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                        url('/api/placeholder/1920/1080') center/cover no-repeat;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .content-container {
            text-align: center;
            color: white;
            padding: 2rem;
            max-width: 800px;
            margin: 0 auto;
        }

        .welcome-text {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .subtitle {
            font-size: 1.4rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }

        .btn-login {
            background: linear-gradient(45deg, #2196F3, #1976D2);
            color: white;
            padding: 0.75rem 2.5rem;
            border-radius: 50px;
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            border: none;
            text-decoration: none;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(33, 150, 243, 0.4);
            color: white;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 1.5rem;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .feature-card h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="nav-container">
        <a href="${pageContext.request.contextPath}/login" class="btn btn-login">Login</a>
    </div>
    
    <div class="hero-section">
        <div class="content-container">
            <h1 class="welcome-text">Employee Management System</h1>
            <p class="subtitle">Streamline your workforce management with our comprehensive solution</p>
            
            <div class="features-grid">
                <div class="feature-card">
                    <h3>Employee Records</h3>
                    <p>Efficiently manage and organize all employee information in one place</p>
                </div>
                <div class="feature-card">
                    <h3>Performance Tracking</h3>
                    <p>Monitor and evaluate employee performance with intuitive tools</p>
                </div>
                <div class="feature-card">
                    <h3>Resource Planning</h3>
                    <p>Optimize resource allocation and workforce scheduling</p>
                </div>
                <div class="feature-card">
                    <h3>Leave Master</h3>
                    <p>Approve and Reject leaves of employees and track reacords</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>