<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>Apply Leave</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .text-danger {
            color: #dc3545;
            font-size: 0.875em;
        }
        .btn-primary {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: #fff;
            font-size: 1em;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Apply for Leave</h2>
        <form:form action="submit-leave" method="post" modelAttribute="leave">
            <!-- Leave Type -->
            <div class="form-group">
                <label for="leaveType">Leave Type:</label>
                <form:select path="leaveType" class="form-control" id="leaveType">
                    <form:option value="Sick Leave">Sick Leave</form:option>
                    <form:option value="Casual Leave">Casual Leave</form:option>
                    <form:option value="Paid Leave">Paid Leave</form:option>
                    <form:option value="Earned Leave">Earned Leave</form:option>
                </form:select>
                <form:errors path="leaveType" class="text-danger"/>
            </div>

            <!-- Start Date -->
            <div class="form-group">
                <label for="startDate">Start Date:</label>
                <c:set var="startDateStr">
                    <fmt:formatDate value="${leave.startDate}" pattern="yyyy-MM-dd"/>
                </c:set>
                <form:input type="date" path="startDate" class="form-control" id="startDate" value="${startDateStr}"/>
                <form:errors path="startDate" class="text-danger"/>
            </div>

            <!-- End Date -->
            <div class="form-group">
                <label for="endDate">End Date:</label>
                <c:set var="endDateStr">
                    <fmt:formatDate value="${leave.endDate}" pattern="yyyy-MM-dd"/>
                </c:set>
                <form:input type="date" path="endDate" class="form-control" id="endDate" value="${endDateStr}"/>
                <form:errors path="endDate" class="text-danger"/>
            </div>

            <!-- Reason -->
            <div class="form-group">
                <label for="reason">Reason:</label>
                <form:textarea path="reason" class="form-control" id="reason" rows="3"/>
                <form:errors path="reason" class="text-danger"/>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary">Submit</button>
        </form:form>
    </div>

    <!-- JavaScript for Date Validation -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var startDate = document.getElementById('startDate');
            var endDate = document.getElementById('endDate');
            
            var today = new Date().toISOString().split('T')[0];
            startDate.setAttribute('min', today);
            endDate.setAttribute('min', today);
            
            startDate.addEventListener('change', function() {
                endDate.setAttribute('min', this.value);
                if(endDate.value && endDate.value < this.value) {
                    endDate.value = this.value;
                }
            });
        });
    </script>
</body>
</html>