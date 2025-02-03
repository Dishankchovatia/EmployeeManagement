<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <%@include file="./base.jsp"%>
    <style>
        .dashboard-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .employee-details {
            margin-bottom: 20px;
        }
        .employee-details h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .employee-details p {
            font-size: 18px;
            margin: 10px 0;
        }
        .btn-update {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
        }
        .btn-update:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="employee-details">
            <h2>Employee Dashboard</h2>
            <h2 style="text-transform: uppercase;">Welcome, ${employee.empName}!</h2>
            <p><strong>Name:</strong> ${employee.empName}</p>
            <p><strong>EmpID:</strong> EMP00${employee.id}</p>
            <p><strong>Mobile Number:</strong> ${employee.empNumber}</p>
            <p><strong>Email:</strong> ${employee.emailId}</p>
            <p><strong>Gender:</strong> ${employee.gender}</p>
            <p><strong>Date of Birth:</strong> ${employee.dob}</p>
            <p><strong>Date of Joining:</strong> ${employee.doj}</p>
        </div>
        <a href="eupdate/${employee.id }" class="btn-update">Update Details</a>
    </div>
    <!-- Add this in your navigation bar or header section -->
<div class="float-right">
    <a href="${pageContext.request.contextPath}/employee-logout" class="btn btn-danger">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>
</div>
</body>
</html>