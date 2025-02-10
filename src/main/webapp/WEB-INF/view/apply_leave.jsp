<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>Apply Leave</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
:root { -
	-primary-color: #4f46e5; -
	-hover-color: #4338ca; -
	-background-color: #f9fafb; -
	-card-background: #ffffff; -
	-text-color: #1f2937;
}

body {
	background-color: var(- -background-color);
	font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
	color: var(- -text-color);
	min-height: 100vh;
	display: flex;
	align-items: center;
}

.container {
	max-width: 700px;
	margin: 2rem auto;
	padding: 2rem;
	background: var(- -card-background);
	border-radius: 16px;
	box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px
		rgba(0, 0, 0, 0.06);
	animation: fadeIn 0.5s ease-out;
}

.form-header {
	text-align: center;
	margin-bottom: 2rem;
	padding-bottom: 1rem;
	border-bottom: 2px solid #e5e7eb;
}

.form-header h2 {
	color: var(- -primary-color);
	font-weight: 600;
	font-size: 2rem;
	margin-bottom: 0.5rem;
}

.form-header p {
	color: #6b7280;
	font-size: 0.95rem;
}

.form-group {
	margin-bottom: 1.5rem;
}

.form-group label {
	font-weight: 500;
	margin-bottom: 0.5rem;
	display: block;
	color: #374151;
}

/* Input & Select Styling */
.form-control, .form-select {
	color: #111827 !important;
	background-color: white !important;
	font-size: 16px;
	height: auto;
	padding: 10px;
	border: 1px solid #d1d5db;
	border-radius: 8px;
	width: 100%;
}

#leaveType.form-control {
	padding: 7px;
}

.form-control:focus, .form-select:focus {
	border-color: var(- -primary-color);
	box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
	outline: none;
}

/* Dropdown Styling */
.input-icon {
	position: relative;
}

.input-icon select {
	appearance: none;
	padding-right: 2.5rem;
}

.input-icon i {
	position: absolute;
	right: 12px;
	top: 50%;
	transform: translateY(-50%);
	color: #9ca3af;
	pointer-events: none;
}

/* Fix for Date Inputs */
.input-icon input[type="date"] {
	padding-right: 2.5rem;
}

.input-icon i.fas.fa-calendar {
	color: #6b7280;
}

/* Button Styling */
.btn-primary {
	background-color: var(- -primary-color);
	border: none;
	padding: 0.75rem 1.5rem;
	font-weight: 500;
	border-radius: 8px;
	width: 100%;
	transition: all 0.3s ease;
}

.btn-primary:hover {
	background-color: var(- -hover-color);
	transform: translateY(-1px);
}

/* Error Message Styling */
.text-danger {
	color: #dc2626;
	font-size: 0.85rem;
	margin-top: 0.25rem;
}

/* Animation */
@
keyframes fadeIn {from { opacity:0;
	transform: translateY(10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}
</style>
</head>
<body>
    <div class="container">
        <div class="form-header">
            <h2>Leave Application</h2>
            <p>Submit your leave request for approval</p>
        </div>
        
        <form:form action="submit-leave" method="post" modelAttribute="leave">
            <div class="form-group">
                <label for="leaveType">Leave Type</label>
                <div class="input-icon">
                    <form:select path="leaveType" class="form-control" id="leaveType">
                        <form:option value="Sick Leave">Sick Leave</form:option>
                        <form:option value="Casual Leave">Casual Leave</form:option>
                        <form:option value="Paid Leave">Paid Leave</form:option>
                        <form:option value="Loss of Pay">Loss Of Pay</form:option>
                    </form:select>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <form:errors path="leaveType" class="text-danger"/>
            </div>

            <div class="date-group">
                <div class="form-group">
                    <label for="startDate">Start Date</label>
                    <div class="input-icon">
                        <c:set var="startDateStr">
                            <fmt:formatDate value="${leave.startDate}" pattern="yyyy-MM-dd"/>
                        </c:set>
                        <form:input type="date" path="startDate" class="form-control" id="startDate" value="${startDateStr}"/>
                        <i class="fas fa-calendar"></i>
                    </div>
                    <form:errors path="startDate" class="text-danger"/>
                </div>

                <div class="form-group">
                    <label for="endDate">End Date</label>
                    <div class="input-icon">
                        <c:set var="endDateStr">
                            <fmt:formatDate value="${leave.endDate}" pattern="yyyy-MM-dd"/>
                        </c:set>
                        <form:input type="date" path="endDate" class="form-control" id="endDate" value="${endDateStr}"/>
                        <i class="fas fa-calendar"></i>
                    </div>
                    <form:errors path="endDate" class="text-danger"/>
                </div>
            </div>

            <div class="form-group">
                <label for="reason">Reason for Leave</label>
                <form:textarea path="reason" class="form-control" id="reason" rows="3" 
                    placeholder="Please provide a brief explanation for your leave request"/>
                <form:errors path="reason" class="text-danger"/>
            </div>

            <button type="submit" class="btn btn-primary">
                <i class="fas fa-paper-plane me-2"></i>Submit Request
            </button>
        </form:form>
    </div>

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

            // Add floating label behavior
            document.querySelectorAll('.form-control').forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('focused');
                });
                input.addEventListener('blur', function() {
                    if (!this.value) {
                        this.parentElement.classList.remove('focused');
                    }
                });
            });
        });
    </script>
</body>
</html>