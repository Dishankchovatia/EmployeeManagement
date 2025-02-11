<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    java.util.Date currentDate = new java.util.Date();
    pageContext.setAttribute("currentDate", currentDate);
%>

<%@ include file="./base.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: #f0f2f5;
        }
        .dashboard-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
        }
        .card-title {
            font-size: 1rem;
            letter-spacing: 0.5px;
            opacity: 0.9;
        }
        .card-value {
            font-size: 2rem;
            font-weight: 600;
            margin: 10px 0;
        }
        .attendance-header {
            background: #fff;
            border-radius: 15px;
            padding: 1.5rem;
            margin: 2rem 0 1rem;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .table-hover tbody tr:hover {
            background-color: #f8f9fa;
        }
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
        }
        .table thead th {
            border-bottom: 2px solid #e9ecef;
            font-weight: 600;
        }
        .icon-wrapper {
            width: 45px;
            height: 45px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
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
	    .btn-check-records {
	      background-color: var(--primary-light);
	      color:black;
	      border: none;
	      padding: 0.5rem 1.5rem;
	      border-radius: 0.5rem;
	      cursor: pointer;
	      transition: background-color 0.3s ease, transform 0.3s ease;
	  }
	  
	  .btn-check-records:hover {
	      background-color: var(--primary);
	      transform: translateY(-2px);
	  }
	  .date-input {
	    width: 200px;
	    padding: 0.75rem 1rem;
	    border: 2px solid var(--input-border);
	    border-radius: 8px;
	    font-size: 1rem;
	    transition: border-color 0.3s ease, box-shadow 0.3s ease;
	  }
	  
	  .date-input:focus {
	    border-color: var(--primary);
	    outline: none;
	    box-shadow: 0 0 0 2px rgba(79, 70, 229, 0.2);
	  }
        
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <div class="container">
            <h2 class="mb-4 fw-bold text-primary">Attendance Dashboard</h2>
            
            <!-- Statistics Cards -->
            <div class="row g-4 mb-4">
                <div class="col-lg-4 col-md-6">
                    <div class="dashboard-card card bg-white">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="icon-wrapper bg-primary">
                                    <i class="fas fa-users text-white fs-5"></i>
                                </div>
                                <div class="ms-3">
                                    <h5 class="card-title mb-0">TOTAL EMPLOYEES</h5>
                                    <div class="card-value text-dark">${stats.totalEmployees}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="dashboard-card card bg-white">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="icon-wrapper bg-success">
                                    <i class="fas fa-check-circle text-white fs-5"></i>
                                </div>
                                <div class="ms-3">
                                    <h5 class="card-title mb-0">PRESENT TODAY</h5>
                                    <div class="card-value text-dark">${stats.presentEmployees}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="dashboard-card card bg-white">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="icon-wrapper bg-danger">
                                    <i class="fas fa-times-circle text-white fs-5"></i>
                                </div>
                                <div class="ms-3">
                                    <h5 class="card-title mb-0">ABSENT TODAY</h5>
                                    <div class="card-value text-dark">${stats.absentEmployees}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

			<form
				action="${pageContext.request.contextPath}/attendance-dashboard"
				method="get">
				<input type="date" name="date" value="${selectedDate}"
					class="date-input" />
				<button type="submit" class="btn btn-check-records">
					<i class="fas fa-search me-2"></i> Check Records
				</button>
			</form>



			<!-- Attendance List -->
            <div class="attendance-header d-flex justify-content-between align-items-center">
                <h4 class="mb-0 fw-bold">Today's Attendance</h4>
				<div class="status-badge bg-light text-dark">
					<i class="fas fa-calendar-day me-2"></i>
					<c:choose>
						<c:when test="${not empty selectedDate}">
							<fmt:parseDate var="selectedDateParsed" value="${selectedDate}"
								pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${selectedDateParsed}"
								pattern="EEEE, MMMM d" />
						</c:when>
						<c:otherwise>
							<fmt:formatDate value="${currentDate}" pattern="EEEE, MMMM d" />
						</c:otherwise>
					</c:choose>
				</div>
			</div>

            <div class="card border-0 shadow">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th class="py-3 px-4">Employee ID</th>
                                    <th class="py-3 px-4">Name</th>
                                    <th class="py-3 px-4">Check-in</th>
                                    <th class="py-3 px-4">Check-out</th>
                                    <th class="py-3 px-4 text-end">Total Hours</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${stats.attendanceList}" var="attendance">
                                    <tr>
                                        <td class="px-4 fw-medium">${attendance.employee.employeeId}</td>
                                        <td class="px-4">${attendance.employee.empName}</td>
                                        <td class="px-4">
                                            <span class="text-success">
                                                <fmt:formatDate value="${attendance.checkInTimeAsDate}" pattern="HH:mm" />
                                            </span>
                                        </td>
                                        <td class="px-4">
                                            <c:choose>
                                                <c:when test="${attendance.checkOutTime != null}">
                                                    <span class="text-danger">
                                                        <fmt:formatDate value="${attendance.checkOutTimeAsDate}" pattern="HH:mm" />
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-warning">Still Working</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-4 text-end fw-medium">
                                            <c:choose>
                                                <c:when test="${attendance.totalHours != null}">
                                                    <span class="text-primary">
                                                        <fmt:formatNumber value="${attendance.totalHours}" pattern="##0.00" />h
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">-</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="mt-4">
                <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/dashboard'">
                    <i class="fas fa-arrow-left mr-2"></i>Back to Dashboard
                </button>
            </div>
        </div>
    </div>
</body>
</html>