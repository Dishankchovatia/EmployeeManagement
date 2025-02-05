<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Employee Dashboard</title>
  <%@include file="./base.jsp"%>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
  <!-- FontAwesome for Icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    /* Global Styles */
    body {
      margin: 0;
      padding: 0;
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #667eea, #764ba2);
      color: #333;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    a {
      text-decoration: none;
    }
    
    /* Dashboard Container */
    .dashboard-container {
      background: #fff;
      border-radius: 15px;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
      padding: 40px;
      max-width: 600px;
      width: 100%;
      position: relative;
      text-align: center;
    }
    
    /* Header */
    .dashboard-header {
      margin-bottom: 30px;
    }
    .dashboard-header h1 {
      font-size: 2.5rem;
      margin: 0;
      color: #764ba2;
    }
    .dashboard-header h2 {
      font-size: 1.4rem;
      font-weight: 400;
      color: #555;
      margin-top: 10px;
    }
    
    /* Employee Details */
    .employee-details {
      text-align: left;
      margin-bottom: 30px;
    }
    .employee-details p {
      font-size: 1.1rem;
      margin: 12px 0;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .employee-details p span.label {
      font-weight: 600;
      color: #764ba2;
    }
    
    /* Update Button */
    .btn-update {
      background-color: #667eea;
      color: #fff;
      padding: 12px 30px;
      border: none;
      border-radius: 8px;
      font-size: 1.1rem;
      font-weight: 600;
      transition: background 0.3s, transform 0.3s;
    }
    .btn-update:hover {
      background-color: #556cd6;
      transform: translateY(-2px);
    }
    
    /* Logout Button */
    .btn-logout {
      position: fixed;
      top: 20px;
      right: 20px;
      background-color: #dc3545;
      color: #fff;
      padding: 10px 20px;
      border: none;
      border-radius: 8px;
      font-size: 0.9rem;
      font-weight: 600;
      transition: background 0.3s, transform 0.3s;
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .btn-logout:hover {
      background-color: #c82333;
      transform: translateY(-2px);
    }
    
    /* Responsive */
    @media (max-width: 480px) {
      .dashboard-container {
        padding: 20px;
      }
      .dashboard-header h1 {
        font-size: 2rem;
      }
      .employee-details p {
        font-size: 1rem;
      }
      .btn-update {
        padding: 10px 20px;
        font-size: 1rem;
      }
      .btn-logout {
        top: 10px;
        right: 10px;
        padding: 8px 16px;
        font-size: 0.8rem;
      }
    }
  </style>
</head>
<body>
  <!-- Logout Button -->
  <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
    <i class="fas fa-sign-out-alt"></i> Logout
  </a>
  
  <!-- Dashboard Container -->
  <div class="dashboard-container">
    <div class="dashboard-header">
      <h1>Employee Dashboard</h1>
      <h2>Welcome, ${employee.empName}!</h2>
    </div>
    <div class="employee-details">
      <p><span class="label">Name:</span> ${employee.empName}</p>
      <p><span class="label">EmpID:</span> ${employee.employeeId}</p>
      <p><span class="label">Mobile:</span> ${employee.empNumber}</p>
      <p><span class="label">Email:</span> ${employee.emailId}</p>
      <p><span class="label">Gender:</span> ${employee.gender}</p>
      <p><span class="label">DOB:</span> ${employee.dob}</p>
      <p><span class="label">DOJ:</span> ${employee.doj}</p>
    </div>
    <a href="eupdate/${employee.id}" class="btn-update">Update Details</a>
  </div>
</body>
</html>
