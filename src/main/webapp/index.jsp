<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@page isELIgnored="false"%>
    <title>Employee Management System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @keyframes gradientAnimation {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

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
            background: linear-gradient(
                rgba(0, 0, 0, 0.6),
                rgba(0, 0, 0, 0.6)
            ),
            linear-gradient(
                -45deg,
                #ee7752,
                #e73c7e,
                #23a6d5,
                #23d5ab
            );
            background-size: 400% 400%;
            animation: gradientAnimation 15s ease infinite;
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
            animation: fadeInUp 1s ease-out, float 3s ease-in-out infinite;
        }

        .subtitle {
            font-size: 1.4rem;
            margin-bottom: 2rem;
            opacity: 0.9;
            animation: fadeInUp 1s ease-out 0.3s backwards;
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
            animation: pulse 2s infinite;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(33, 150, 243, 0.4);
            color: white;
            animation: none;
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
            transition: all 0.3s ease;
            animation: fadeInUp 0.8s ease-out backwards;
        }

        .feature-card:nth-child(1) { animation-delay: 0.4s; }
        .feature-card:nth-child(2) { animation-delay: 0.6s; }
        .feature-card:nth-child(3) { animation-delay: 0.8s; }
        .feature-card:nth-child(4) { animation-delay: 1s; }

        .feature-card:hover {
            transform: translateY(-5px) scale(1.03);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.3);
        }

        .feature-card h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            position: relative;
            display: inline-block;
        }

        .feature-card h3::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -5px;
            width: 0;
            height: 2px;
            background: white;
            transition: width 0.3s ease;
        }

        .feature-card:hover h3::after {
            width: 100%;
        }

        .feature-card p {
            transition: transform 0.3s ease;
        }

        .feature-card:hover p {
            transform: translateY(2px);
        }

        @media (max-width: 768px) {
            .welcome-text {
                font-size: 2.5rem;
            }
            
            .subtitle {
                font-size: 1.2rem;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
            }
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