<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Leaves</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <style>
        :root {
            --primary: #6366f1;
            --primary-light: #818cf8;
            --secondary: #64748b;
            --background: #f1f5f9;
            --surface: #ffffff;
            --text: #334155;
            --text-light: #64748b;
            --border: #e2e8f0;
            --success: #10b981;
            --danger: #ef4444;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background);
            color: var(--text);
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .card {
            background-color: var(--surface);
            border-radius: 1rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        h2 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
            font-weight: 500;
            border-radius: 0.5rem;
            transition: all 0.2s;
            cursor: pointer;
            border: none;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-light);
        }

        .btn-outline {
            background-color: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
        }

        .btn-outline:hover {
            background-color: var(--primary);
            color: white;
        }

        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 0.5rem;
        }

        .table th {
            background-color: var(--background);
            color: var(--text-light);
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
            padding: 1rem;
            text-align: left;
        }

        .table td {
            background-color: var(--surface);
            padding: 1rem;
            transition: all 0.2s;
        }

        .table tr:hover td {
            background-color: var(--background);
        }

        .modal {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s;
        }

        .modal.show {
            opacity: 1;
            visibility: visible;
        }

        .modal-content {
            background-color: var(--surface);
            border-radius: 1rem;
            padding: 2rem;
            width: 90%;
            max-width: 500px;
            transform: scale(0.9);
            transition: all 0.3s;
        }

        .modal.show .modal-content {
            transform: scale(1);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .modal-title {
            font-size: 1.25rem;
            font-weight: 600;
        }

        .close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--text-light);
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid var(--border);
            border-radius: 0.25rem;
            font-size: 1rem;
        }

        .alert {
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
        }

        .alert-success {
            background-color: var(--success);
            color: white;
        }

        @media (max-width: 768px) {
            .card-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .card-header .btn {
                margin-top: 1rem;
            }

            .table thead {
                display: none;
            }

            .table, .table tbody, .table tr, .table td {
                display: block;
                width: 100%;
            }

            .table tr {
                margin-bottom: 1rem;
                border: 1px solid var(--border);
                border-radius: 0.5rem;
                overflow: hidden;
            }

            .table td {
                display: flex;
                justify-content: space-between;
                text-align: right;
                padding: 0.5rem 1rem;
                border-bottom: 1px solid var(--border);
            }

            .table td::before {
                content: attr(data-label);
                font-weight: 600;
                text-align: left;
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .fade-in {
            animation: fadeIn 0.3s ease-in-out;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card fade-in">
            <div class="card-header">
                <h2>Pending Leave Applications</h2>
                <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/admin/leave-report'">
                    <i class="fas fa-file-alt mr-2"></i>Generate Report
                </button>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success fade-in">
                    <i class="fas fa-check-circle mr-2"></i>${message}
                </div>
            </c:if>

            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Employee</th>
                            <th>Leave Type</th>
                            <th>Duration</th>
                            <th>Reason</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${leaves}" var="leave">
                            <tr>
                                <td data-label="Employee">${leave.employee.empName}</td>
                                <td data-label="Leave Type">${leave.leaveType}</td>
                                <td data-label="Duration">
                                    <fmt:formatDate value="${leave.startDate}" pattern="dd MMM"/> - 
                                    <fmt:formatDate value="${leave.endDate}" pattern="dd MMM, yyyy"/>
                                </td>
                                <td data-label="Reason">${leave.reason}</td>
                                <td data-label="Action">
                                    <button class="btn btn-outline" onclick="openProcessModal(${leave.id})">
                                        Process
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="mt-4">
                <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/dashboard'">
                    <i class="fas fa-arrow-left mr-2"></i>Back to Dashboard
                </button>
            </div>
        </div>
    </div>

    <!-- Modal for processing leave -->
    <div id="processModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Process Leave Request</h5>
                <button type="button" class="close" onclick="closeProcessModal()">&times;</button>
            </div>
            <form id="processLeaveForm">
                <div class="form-group">
                    <label for="status">Status:</label>
                    <select id="status" name="status" class="form-control" required>
                        <option value="">Select Status</option>
                        <option value="APPROVED">Approve</option>
                        <option value="REJECTED">Reject</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="remarks">Remarks:</label>
                    <textarea id="remarks" name="remarks" class="form-control" rows="3" required></textarea>
                </div>
                <div class="text-right">
                    <button type="button" class="btn btn-outline" onclick="closeProcessModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function openProcessModal(leaveId) {
            document.getElementById('processModal').classList.add('show');
            document.getElementById('processLeaveForm').setAttribute('data-leave-id', leaveId);
        }

        function closeProcessModal() {
            document.getElementById('processModal').classList.remove('show');
        }

        document.getElementById('processLeaveForm').addEventListener('submit', function(e) {
            e.preventDefault();
            var form = this;
            var leaveId = form.getAttribute('data-leave-id');
            var submitBtn = form.querySelector('button[type="submit"]');
            
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Processing...';
            
            $.ajax({
                url: '${pageContext.request.contextPath}/admin/process-leave/' + leaveId,
                type: 'POST',
                data: $(form).serialize(),
                success: function(response) {
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert('Error processing leave request. Please try again.');
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = 'Submit';
                }
            });
        });
    </script>
</body>
</html>

