<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="./base.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <title>My Leaves</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
<style>
    :root {
        --primary-color: #2c3e50;
        --secondary-color: #3498db;
        --success-color: #27ae60;
        --warning-color: #f1c40f;
        --danger-color: #e74c3c;
        --light-gray: #ecf0f1;
        --dark-gray: #34495e;
    }

    body {
        background: linear-gradient(135deg, #f6f8fa 0%, #e9ecef 100%);
        font-family: 'Segoe UI', Arial, sans-serif;
        line-height: 1.6;
        min-height: 100vh;
    }

    .container {
        max-width: 1200px;
        margin: 30px auto;
        padding: 25px;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .container:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
    }

    h2 {
        text-align: center;
        margin-bottom: 30px;
        color: var(--primary-color);
        font-weight: 600;
        font-size: 2.2rem;
        position: relative;
        padding-bottom: 15px;
    }

    h2::before {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 60px;
        height: 3px;
        background: var(--secondary-color);
        border-radius: 2px;
        transition: width 0.3s ease;
    }

    h2:hover::before {
        width: 120px;
    }

    .alert-success {
        background: linear-gradient(45deg, rgba(39, 174, 96, 0.1), rgba(39, 174, 96, 0.05));
        color: var(--success-color);
        border-left: 4px solid var(--success-color);
        padding: 15px;
        border-radius: 4px;
        margin-bottom: 25px;
        transform-origin: left;
        animation: slideIn 0.5s ease;
    }

    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateX(-20px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }

    .table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        margin-bottom: 25px;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    }

    .table thead {
        background: linear-gradient(135deg, var(--primary-color), var(--dark-gray));
        color: #fff;
    }

    .table th {
        padding: 18px 15px;
        text-align: left;
        font-weight: 600;
        font-size: 0.95rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        position: relative;
        overflow: hidden;
    }

    .table th::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 2px;
        background: var(--secondary-color);
        transform: scaleX(0);
        transition: transform 0.3s ease;
    }

    .table th:hover::after {
        transform: scaleX(1);
    }

    .table td {
        padding: 15px;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        font-size: 0.95rem;
        transition: all 0.3s ease;
    }

    .table tbody tr {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .table tbody tr:hover {
        background: linear-gradient(45deg, rgba(52, 152, 219, 0.05), rgba(52, 152, 219, 0.1));
        transform: scale(1.01);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .badge {
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .badge::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: rgba(255, 255, 255, 0.2);
        transition: transform 0.5s ease;
        transform: skewX(-15deg);
    }

    .badge:hover::before {
        transform: translateX(200%) skewX(-15deg);
    }

    .badge-success {
        background: linear-gradient(45deg, var(--success-color), #2ecc71);
        color: white;
        box-shadow: 0 2px 8px rgba(39, 174, 96, 0.3);
    }

    .badge-danger {
        background: linear-gradient(45deg, var(--danger-color), #c0392b);
        color: white;
        box-shadow: 0 2px 8px rgba(231, 76, 60, 0.3);
    }

    .badge-warning {
        background: linear-gradient(45deg, var(--warning-color), #f39c12);
        color: #fff;
        box-shadow: 0 2px 8px rgba(241, 196, 15, 0.3);
    }

    .no-leaves {
        text-align: center;
        color: var(--dark-gray);
        font-style: italic;
        margin: 40px auto;
        padding: 30px;
        background: linear-gradient(135deg, rgba(52, 152, 219, 0.05), rgba(52, 152, 219, 0.1));
        border-radius: 12px;
        max-width: 600px;
        transform-origin: center;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .no-leaves:hover {
        transform: scale(1.02);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    }

    @media (max-width: 768px) {
        .container {
            margin: 15px;
            padding: 15px;
        }

        .table {
            display: block;
            overflow-x: auto;
            white-space: nowrap;
        }

        h2 {
            font-size: 1.8rem;
        }
    }

    @keyframes shimmer {
        0% {
            background-position: -1000px 0;
        }
        100% {
            background-position: 1000px 0;
        }
    }
</style>

</head>
<body>
    <div class="container">
        <h2>My Leave Applications</h2>
        
        <!-- Success Message -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        
        <!-- Leave Applications Table -->
        <c:choose>
            <c:when test="${not empty leaves}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Leave Type</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th>Admin Remarks</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${leaves}" var="leave">
                            <tr>
                                <td>${leave.leaveType}</td>
                                <td><fmt:formatDate value="${leave.startDate}" pattern="dd-MM-yyyy"/></td>
                                <td><fmt:formatDate value="${leave.endDate}" pattern="dd-MM-yyyy"/></td>
                                <td>${leave.reason}</td>
                                <td>
                                    <span class="badge ${leave.status == 'APPROVED' ? 'badge-success' : 
                                                       leave.status == 'REJECTED' ? 'badge-danger' : 
                                                       'badge-warning'}">
                                        ${leave.status}
                                    </span>
                                </td>
                                <td>${leave.adminRemarks}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p class="no-leaves">No leave applications found.</p>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>