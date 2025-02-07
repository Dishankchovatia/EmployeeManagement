<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Leave Report - ${employee.empName}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        :root {
            --primary-color: #4f46e5;
            --success-color: #059669;
            --danger-color: #dc2626;
            --warning-color: #d97706;
            --background-color: #f3f4f6;
        }

        body {
            background-color: var(--background-color);
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            color: #1f2937;
        }

        .container {
            max-width: 1200px;
            padding: 2rem 1rem;
        }

        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary-color), #818cf8);
            color: white;
            padding: 1.5rem;
            border-radius: 1rem 1rem 0 0 !important;
        }

        .card-body {
            padding: 2rem;
        }

        .btn-secondary {
            background-color: white;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            padding: 0.5rem 1.5rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .btn-secondary:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-1px);
        }

        /* Summary Cards */
        .summary-card {
            padding: 1.5rem;
            border-radius: 1rem;
            height: 100%;
            transition: transform 0.2s ease;
        }

        .summary-card:hover {
            transform: translateY(-5px);
        }

        .summary-card h5 {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .summary-card h3 {
            font-size: 2rem;
            font-weight: 700;
            margin: 0;
        }

        /* Table Styling */
        .table {
            margin-bottom: 0;
        }

        .table-borderless td {
            padding: 0.5rem 0;
        }

        .table-striped > tbody > tr:nth-of-type(odd) {
            background-color: rgba(79, 70, 229, 0.05);
        }

        .table th {
            background-color: #f8fafc;
            color: #4b5563;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.875rem;
            letter-spacing: 0.05em;
        }

        .table td {
            vertical-align: middle;
            color: #4b5563;
        }

        .badge {
            padding: 0.5rem 1rem;
            font-weight: 500;
            border-radius: 9999px;
        }

        .bg-success {
            background-color: var(--success-color) !important;
        }

        .bg-danger {
            background-color: var(--danger-color) !important;
        }

        .bg-warning {
            background-color: var(--warning-color) !important;
        }

        /* Print Styles */
        @media print {
            body {
                background-color: white;
            }

            .card {
                box-shadow: none;
            }

            .btn-secondary {
                display: none;
            }

            .summary-card {
                break-inside: avoid;
            }

            .table {
                break-inside: auto;
            }

            tr {
                break-inside: avoid;
            }
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card {
            animation: fadeIn 0.5s ease-out;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .card-body {
                padding: 1.5rem;
            }

            .summary-card {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                    <h3 class="mb-0">Leave Report</h3>
                    <button onclick="window.print()" class="btn btn-secondary">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-printer me-2" viewBox="0 0 16 16">
                            <path d="M2.5 8a.5.5 0 1 0 0-1 .5.5 0 0 0 0 1z"/>
                            <path d="M5 1a2 2 0 0 0-2 2v2H2a2 2 0 0 0-2 2v3a2 2 0 0 0 2 2h1v1a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2v-1h1a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-1V3a2 2 0 0 0-2-2H5zM4 3a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1v2H4V3zm1 5a2 2 0 0 0-2 2v1H2a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-1v-1a2 2 0 0 0-2-2H5zm7 2v3a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-3a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1z"/>
                        </svg>
                        Print Report
                    </button>
                </div>
            </div>
            <div class="card-body">
                <!-- Employee Details -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h4 class="mb-3">Employee Details</h4>
                        <table class="table table-borderless">
                            <tr>
                                <td style="width: 40%"><strong>Name:</strong></td>
                                <td>${employee.empName}</td>
                            </tr>
                            <tr>
                                <td><strong>Employee ID:</strong></td>
                                <td>${employee.employeeId}</td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <h4 class="mb-3">Leave Summary</h4>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="summary-card bg-success text-white">
                                    <h5>Approved</h5>
                                    <h3>${approvedLeaves}</h3>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="summary-card bg-danger text-white">
                                    <h5>Rejected</h5>
                                    <h3>${rejectedLeaves}</h3>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="summary-card bg-warning text-white">
                                    <h5>Pending</h5>
                                    <h3>${pendingLeaves}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Leave Details Table -->
                <h4 class="mb-3">Leave Details</h4>
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Days</th>
                                <th>Type</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Admin Remarks</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${leaves}" var="leave">
                                <tr>
                                    <td><fmt:formatDate value="${leave.startDate}" pattern="dd-MM-yyyy"/></td>
                                    <td><fmt:formatDate value="${leave.endDate}" pattern="dd-MM-yyyy"/></td>
                                    <td>
                                        ${(leave.endDate.time - leave.startDate.time) / (1000*60*60*24) + 1}
                                    </td>
                                    <td>${leave.leaveType}</td>
                                    <td>${leave.reason}</td>
                                    <td>
                                        <span class="badge bg-${leave.status == 'APPROVED' ? 'success' : leave.status == 'REJECTED' ? 'danger' : 'warning'}">
                                            ${leave.status}
                                        </span>
                                    </td>
                                    <td>${leave.adminRemarks}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
