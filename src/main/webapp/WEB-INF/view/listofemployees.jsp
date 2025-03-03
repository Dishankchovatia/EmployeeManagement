<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@include file="./base.jsp"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    
    <!-- CSS Dependencies -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #6366f1;
            --secondary-color: #818cf8;
            --background-dark: #f1f5f9;
            --header-gradient: linear-gradient(135deg, #f0f7ff, #e0e7ff);
            --box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        body {
            background-color: var(--background-dark);
            font-family: 'Inter', sans-serif;
        }

        /* Navbar Styling */
        .navbar {
            background-color: #343a40; /* dark background */
        }
        .navbar-brand, .nav-link {
            color: #ffffff !important;
        }
        .nav-link:hover {
            color: var(--secondary-color) !important;
        }

        .dashboard-container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 2rem;
            background: #ffffff;
            border-radius: 20px;
            box-shadow: var(--box-shadow);
        }

        .dashboard-header {
            position: relative;
            margin-bottom: 1rem;
            padding: 1.5rem;
            background: var(--header-gradient);
            border-radius: 15px;
        }

        .dashboard-title {
            color: #1e293b;
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            margin: 0;
        }

        .search-section {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
            background: #f8fafc;
            padding: 1.5rem;
            border-radius: 15px;
        }

        .search-box {
            position: relative;
            flex-grow: 1;
        }

        .search-box input {
            padding-left: 2.5rem;
            border-radius: 10px;
            border: 2px solid #e2e8f0;
            height: 45px;
            background: white;
        }

        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
        }

        .btn-custom {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1.25rem;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-download {
            background-color: #10b981;
            color: white;
        }

        .btn-add {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-back {
            background-color: #64748b;
            color: white;
        }

        .table-container {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--box-shadow);
            margin-bottom: 2rem;
            border: 1px solid #e2e8f0;
        }

        .custom-table {
            margin: 0;
        }

        .custom-table thead {
            background: #f1f5f9;
        }

        .custom-table th {
            color: #1e293b;
            font-weight: 600;
            text-transform: uppercase;
            padding: 1.25rem 1rem;
            border: none;
        }

        .custom-table th i {
            color: var(--primary-color);
        }

        .custom-table td {
            padding: 1rem;
            vertical-align: middle;
            border-color: #e2e8f0;
        }

        .custom-table tbody tr:hover {
            background-color: #f8fafc;
        }

        .employee-id {
            font-weight: 600;
            color: var(--primary-color);
        }

        .action-icon {
            color: var(--primary-color);
            font-size: 1.1rem;
            transition: transform 0.2s ease;
        }

        .action-icon:hover {
            transform: scale(1.2);
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 2rem;
        }

        .page-link {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            color: var(--primary-color);
            font-weight: 500;
            transition: all 0.3s ease;
            background: white;
            border: 1px solid #e2e8f0;
        }

        .page-link:hover {
            background: #f8fafc;
            color: var(--primary-color);
        }

        .page-link.active {
            background-color: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .table-row {
            animation: fadeIn 0.3s ease forwards;
        }

        /* Button hover effects */
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .btn-download:hover {
            background-color: #059669;
        }

        .btn-add:hover {
            background-color: #4f46e5;
        }

        .btn-back:hover {
            background-color: #475569;
        }

        /* Horizontal Action Icons */
        .action-btns {
            display: flex;
            align-items: center;
            gap: 10px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                <i class="fas fa-users-gear me-2"></i>Admin Dashboard
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <!-- Import Link triggers hidden file input -->
                        <a class="nav-link" href="#" id="importLink">
                            <i class="fas fa-file-upload me-2"></i> Import
                        </a>
                    </li>
                    <li class="nav-item">
                        <form action="${pageContext.request.contextPath}/export" method="get">
                            <button type="submit" class="btn btn-success ms-2">
                                <i class="fas fa-file-excel me-2"></i>Export
                            </button>
                        </form>
                    </li>
                    <li class="nav-item">
                        <a href="add-employee" class="btn btn-primary ms-2">
                            <i class="fas fa-user-plus me-2"></i>Add Employee
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary ms-2">
                            <i class="fas fa-arrow-left me-2"></i>Back
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hidden Import Form -->
    <form id="importForm" action="${pageContext.request.contextPath}/importEmployees" method="POST" enctype="multipart/form-data" style="display:none;">
        <input type="file" name="file" id="hiddenFile" accept=".xls, .xlsx" required />
    </form>

    <div class="dashboard-container">
        <header class="dashboard-header">
            <h1 class="dashboard-title">
                <i class="fas fa-users-gear me-2"></i>Employee List
            </h1>
        </header>
       
        <!-- Display Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-info">
                ${message}
            </div>
        </c:if>

        <div class="search-section">
            <form action="${pageContext.request.contextPath}/listofemployees" method="GET" class="search-box">
                <i class="fas fa-search search-icon"></i>
                <input type="text" name="searchName" class="form-control" placeholder="Search by name..." value="${param.searchName}" />
            </form>
        </div>

        <div class="table-container">
            <c:choose>
                <c:when test="${empty employees}">
                    <div class="text-center py-5">
                        <i class="fas fa-search fa-3x text-muted mb-3"></i>
                        <h3 class="text-muted">No Employees Found</h3>
                        <p class="text-muted">Try adjusting your search criteria</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="table custom-table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag me-2"></i>S.No.</th>
                                <!-- <th><i class="fas fa-id-card me-2"></i>ID</th> -->
                                <th><i class="fas fa-id-card me-2"></i>EMPID</th>
                                <th><i class="fas fa-user me-2"></i>Name</th>
                                <th><i class="fas fa-cogs me-2"></i>Salary</th>
                                <th><i class="fas fa-phone me-2"></i>Mobile No.</th>
                                <th><i class="fas fa-envelope me-2"></i>Email Id</th>
                                <th><i class="fas fa-venus-mars me-2"></i>Gender</th>
                                <th><i class="fas fa-calendar-day me-2"></i>DOB</th>
                                <th><i class="fas fa-calendar-plus me-2"></i>DOJ</th>
                                <th><i class="fas fa-cogs me-2"></i>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${employees}" var="e" varStatus="status">
                                <tr class="table-row">
                                    <td>${(currentPage - 1) * size + status.index + 1}</td>
                                    <%-- <td class="employee-id">${e.id}</td> --%>
                                    <td>${e.employeeId}</td>
                                    <td>${e.empName}</td>
                                    <td>${e.salary}</td>
                                    <td>${e.empNumber}</td>
                                    <td>${e.emailId}</td>
                                    <td>${e.gender}</td>
                                    <td>${e.dob}</td>
                                    <td>${e.doj}</td>
                                    <td>
                                        <div class="action-btns">
                                            <a href="update/${e.id}" class="action-icon" title="Edit Employee">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            
                                            <c:choose>
                                                <c:when test="${e.role == 'ADMIN'}">
                                                    <span class="badge bg-info" title="Admin">
                                                        <i class="fas fa-user-shield"></i>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="${pageContext.request.contextPath}/toggle-employee-status/${e.id}" method="post" style="display:inline;">
                                                        <input type="hidden" name="status" value="${!e.active}"/>
                                                        <button type="submit" class="btn btn-${e.active ? 'danger' : 'success'}" title="${e.active ? 'Deactivate' : 'Activate'}">
                                                            <i class="fas fa-power-off"></i>
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <c:if test="${e.role != 'ADMIN' && e.active}">
                                                <form action="${pageContext.request.contextPath}/promote-to-admin/${e.id}" method="post" style="display:inline;">
                                                    <button type="submit" class="btn btn-warning" title="Promote to Admin">
                                                        <i class="fas fa-user-shield"></i>
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="listofemployees?page=${currentPage - 1}&size=${size}&searchName=${param.searchName}" 
                   class="page-link">
                    <i class="fas fa-chevron-left me-1"></i> Previous
                </a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="listofemployees?page=${i}&size=${size}&searchName=${param.searchName}" 
                   class="page-link ${i == currentPage ? 'active' : ''}">
                    ${i}
                </a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="listofemployees?page=${currentPage + 1}&size=${size}&searchName=${param.searchName}" 
                   class="page-link">
                    Next <i class="fas fa-chevron-right ms-1"></i>
                </a>
            </c:if>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('importLink').addEventListener('click', function(e) {
            e.preventDefault();
            document.getElementById('hiddenFile').click();
        });

        document.getElementById('hiddenFile').addEventListener('change', function() {
            document.getElementById('importForm').submit();
        });
    </script>
</body>
</html>
