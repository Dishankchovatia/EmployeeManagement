<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="./base.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <title>My Leaves</title>
    <!-- Add your CSS links here -->
</head>
<body>
    <div class="container mt-5">
        <h2>My Leave Applications</h2>
        
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        
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
    </div>
</body>
</html>