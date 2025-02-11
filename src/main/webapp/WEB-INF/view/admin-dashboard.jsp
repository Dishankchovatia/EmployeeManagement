<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-dark: #4338ca;
            --success: #059669;
            --success-dark: #047857;
            --danger: #dc2626;
            --danger-dark: #b91c1c;
            --transition: all 0.3s ease;
        }

        body {
            min-height: 100vh;
            background: #f8fafc;
            font-family: system-ui, -apple-system, sans-serif;
            margin: 0;
            padding: 0;
        }

        .dashboard-container {
            min-height: 100vh;
            background: 
                radial-gradient(circle at top right, rgba(79, 70, 229, 0.15) 0%, transparent 40%),
                radial-gradient(circle at bottom left, rgba(5, 150, 105, 0.15) 0%, transparent 40%);
            padding: 2rem 1rem;
        }

        .header {
            position: relative;
            padding: 2.5rem;
            background: white;
            border-radius: 1rem;
            box-shadow: 
                0 4px 6px -1px rgba(0, 0, 0, 0.1),
                0 2px 4px -1px rgba(0, 0, 0, 0.06);
            margin-bottom: 2rem;
        }

        .welcome-text {
            font-size: 2.25rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 0.75rem;
            background: linear-gradient(to right, var(--primary), var(--success));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .subtitle {
            color: #64748b;
            font-size: 1.1rem;
            max-width: 600px;
            line-height: 1.6;
        }

        .card-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 2rem;
            padding: 1rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .action-card {
            background: white;
            border-radius: 1rem;
            padding: 2rem;
            transition: var(--transition);
            border: 1px solid #e2e8f0;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(to right, var(--primary), var(--success));
            transform: scaleX(0);
            transform-origin: left;
            transition: var(--transition);
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 
                0 10px 15px -3px rgba(0, 0, 0, 0.1),
                0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        .action-card:hover::before {
            transform: scaleX(1);
        }

        .card-icon {
            width: 48px;
            height: 48px;
            margin-bottom: 1.5rem;
            color: var(--primary);
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 1rem;
        }

        .card-description {
            color: #64748b;
            margin-bottom: 1.5rem;
            line-height: 1.6;
            flex-grow: 1;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 500;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            cursor: pointer;
        }

        .btn svg {
            width: 16px;
            height: 16px;
            stroke-width: 2;
        }

        .btn-add, .btn-list, .btn-manage {
            color: white;
            border: none;
            width: 100%;
        }

        .btn-add {
            background: var(--success);
        }

        .btn-add:hover {
            background: var(--success-dark);
        }

        .btn-list, .btn-manage {
            background: var(--primary);
        }

        .btn-list:hover, .btn-manage:hover {
            background: var(--primary-dark);
        }

        .btn-logout {
            position: absolute;
            top: 2rem;
            right: 2rem;
            background: white;
            color: var(--danger);
            border: 1px solid var(--danger);
            padding: 0.5rem 1rem;
        }

        .btn-logout:hover {
            background: var(--danger);
            color: white;
        }

        @media (max-width: 1024px) {
            .card-grid {
                gap: 1.5rem;
                padding: 0.5rem;
            }
        }

        @media (max-width: 768px) {
            .header {
                text-align: center;
                padding: 1.5rem;
            }

            .welcome-text {
                font-size: 1.875rem;
            }

            .btn-logout {
                position: static;
                margin-top: 1rem;
                width: 100%;
            }

            .card-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .container {
                padding: 0;
            }
        }

        .btn:focus {
            outline: 2px solid var(--primary);
            outline-offset: 2px;
        }

        html {
            scroll-behavior: smooth;
        }

        * {
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="container">
            <div class="header">
                <h1 class="welcome-text">Welcome ${empName}!</h1>
                <p class="subtitle">Streamline your workforce management with our intuitive system</p>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                        <polyline points="16 17 21 12 16 7"></polyline>
                        <line x1="21" y1="12" x2="9" y2="12"></line>
                    </svg>
                    Logout
                </a>
            </div>

            <div class="card-grid">
                <div class="action-card">
                    <svg class="card-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                    </svg>
                    <h3 class="card-title">Add Employee</h3>
                    <p class="card-description">Register new employees to the system with their details and credentials</p>
                    <a href="add-employee" class="btn btn-add">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"></path>
                            <circle cx="9" cy="7" r="4"></circle>
                            <line x1="19" y1="8" x2="19" y2="14"></line>
                            <line x1="22" y1="11" x2="16" y2="11"></line>
                        </svg>
                        Add New Employee
                    </a>
                </div>

                <div class="action-card">
                    <svg class="card-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                    <h3 class="card-title">View Employees</h3>
                    <p class="card-description">Access and manage your complete employee database with advanced filtering options</p>
                    <a href="listofemployees" class="btn btn-list">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                            <circle cx="9" cy="7" r="4"></circle>
                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                            <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                        </svg>
                        View All Employees
                    </a>
                </div>

                <div class="action-card">
                    <svg class="card-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M4 6h16M4 12h16m-7 6h7"/>
                    </svg>
                    <h3 class="card-title">Leave Master</h3>
                    <p class="card-description">Manage and track employee leave records, approvals, and balances efficiently.</p>
                    <a href="admin/pending-leaves" class="btn btn-manage">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 6h16M4 12h16m-7 6h7"/>
                        </svg>
                        Manage Leaves
                    </a>
                </div>

                <div class="action-card">
                    <svg class="card-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M5 12h14M12 5v14M16 4h3a2 2 0 0 1 2 2v3M4 16H2v-3a2 2 0 0 1 2-2h3M16 20h3a2 2 0 0 0 2-2v-3M4 8H2V5a2 2 0 0 1 2-2h3"/>
                    </svg>
                    <h3 class="card-title">Attendance Dashboard</h3>
                    <p class="card-description">Monitor and manage attendance records with advanced tracking and real-time reporting.</p>
                    <a href="attendance-dashboard" class="btn btn-list">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M8 6h13M8 12h13M8 18h13M3 6h.01M3 12h.01M3 18h.01"/>
                        </svg>
                        Check Attendance
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>