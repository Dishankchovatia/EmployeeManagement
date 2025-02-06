<!-- apply_leave.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>Apply Leave</title>
    <!-- Add your CSS links here -->
</head>
<body>
    <div class="container mt-5">
        <h2>Apply for Leave</h2>
        <form:form action="submit-leave" method="post" modelAttribute="leave">
            <div class="form-group">
                <label>Leave Type:</label>
                <form:select path="leaveType" class="form-control">
                    <form:option value="Sick Leave">Sick Leave</form:option>
                    <form:option value="Casual Leave">Casual Leave</form:option>
                    <form:option value="Personal Leave">Personal Leave</form:option>
                </form:select>
                <form:errors path="leaveType" class="text-danger"/>
            </div>
            
            <div class="form-group">
                <label>Start Date:</label>
                <c:set var="startDateStr">
                    <fmt:formatDate value="${leave.startDate}" pattern="yyyy-MM-dd"/>
                </c:set>
                <form:input type="date" path="startDate" class="form-control" value="${startDateStr}"/>
                <form:errors path="startDate" class="text-danger"/>
            </div>
            
            <div class="form-group">
                <label>End Date:</label>
                <c:set var="endDateStr">
                    <fmt:formatDate value="${leave.endDate}" pattern="yyyy-MM-dd"/>
                </c:set>
                <form:input type="date" path="endDate" class="form-control" value="${endDateStr}"/>
                <form:errors path="endDate" class="text-danger"/>
            </div>
            
            <div class="form-group">
                <label>Reason:</label>
                <form:textarea path="reason" class="form-control" rows="3"/>
                <form:errors path="reason" class="text-danger"/>
            </div>
            
            <button type="submit" class="btn btn-primary">Submit</button>
        </form:form>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var startDate = document.querySelector('input[type="date"][name="startDate"]');
            var endDate = document.querySelector('input[type="date"][name="endDate"]');
            
            // Set min date to today
            var today = new Date().toISOString().split('T')[0];
            startDate.setAttribute('min', today);
            endDate.setAttribute('min', today);
            
            // Update end date min value when start date changes
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