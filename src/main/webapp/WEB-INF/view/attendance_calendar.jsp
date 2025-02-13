<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Calendar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
     .calendar {
    width: 100%;
    border-collapse: collapse;
    table-layout: fixed; /* Forces equal column widths */
}

.calendar th {
    background-color: #f8f9fa;
    text-align: center;
    padding: 8px;
    border: 1px solid #dee2e6;
    width: 14.28%; /* Equal width for all 7 days (100% ÷ 7) */
}

.calendar td {
    border: 1px solid #dee2e6;
    height: 100px; /* Reduced fixed height to fit full month */
    vertical-align: top;
    padding: 5px;
    position: relative;
    overflow: hidden;
}

.date-number {
    font-weight: bold;
    margin-bottom: 5px;
    font-size: 13px;
}

.attendance-status {
    padding: 3px 6px;
    border-radius: 4px;
    font-size: 11px;
    color: white;
    display: inline-block;
    width: auto;
    min-width: 60px;
    text-align: center;
}

.present {
    background-color: #28a745;
}

.absent {
    background-color: #dc3545;
}

.leave {
    background-color: #ffc107;
    color: black;
}

.outside-month {
    background-color: #f8f9fa;
    opacity: 0.7;
}

/* Stats section styles */
.mt-4 .d-flex {
    gap: 1rem;
}

.d-flex.align-items-center {
    background: #f8f9fa;
    padding: 6px 12px;
    border-radius: 4px;
}

/* Container styles */
.container {
    max-width: 1200px;
    margin: 0 auto;
}

/* Stats section styles */
.mt-4 .d-flex {
    flex-wrap: wrap;
    gap: 1rem;
}

.d-flex.align-items-center {
    background: #f8f9fa;
    padding: 8px 16px;
    border-radius: 6px;
    min-width: 150px;
}
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="card shadow-sm">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3>Attendance Calendar - ${monthYear}</h3>
                    <div class="col ml-5">
								<p class="mb-1">
									<strong>Name:</strong> ${employee.empName}
								</p>
								<p class="mb-1">
									<strong>ID:</strong> ${employee.employeeId}
								</p>
							</div>
                    <div>
                        <form action="" method="get" class="d-flex gap-2">
                            <select name="month" class="form-select">
                                <option value="1" ${currentMonth == 1 ? 'selected' : ''}>January</option>
                                <option value="2" ${currentMonth == 2 ? 'selected' : ''}>February</option>
                                <option value="3" ${currentMonth == 3 ? 'selected' : ''}>March</option>
                                <option value="4" ${currentMonth == 4 ? 'selected' : ''}>April</option>
                                <option value="5" ${currentMonth == 5 ? 'selected' : ''}>May</option>
                                <option value="6" ${currentMonth == 6 ? 'selected' : ''}>June</option>
                                <option value="7" ${currentMonth == 7 ? 'selected' : ''}>July</option>
                                <option value="8" ${currentMonth == 8 ? 'selected' : ''}>August</option>
                                <option value="9" ${currentMonth == 9 ? 'selected' : ''}>September</option>
                                <option value="10" ${currentMonth == 10 ? 'selected' : ''}>October</option>
                                <option value="11" ${currentMonth == 11 ? 'selected' : ''}>November</option>
                                <option value="12" ${currentMonth == 12 ? 'selected' : ''}>December</option>
                            </select> 
                            <select name="year" class="form-select">
								<c:forEach items="${yearRange}" var="yearOption">
									<option value="${yearOption}"
										${currentYear == yearOption ? 'selected' : ''}>${yearOption}</option>
								</c:forEach>
							</select>
							<button type="submit" class="btn btn-primary">Go</button>
                        </form>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="calendar">
                        <thead>
                            <tr>
                                <th>Sunday</th>
                                <th>Monday</th>
                                <th>Tuesday</th>
                                <th>Wednesday</th>
                                <th>Thursday</th>
                                <th>Friday</th>
                                <th>Saturday</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${calendarData}" var="week">
                                <tr>
                                    <c:forEach items="${week}" var="day">
                                        <td class="${day.outsideMonth ? 'outside-month' : ''}">
                                            <c:if test="${not empty day.date}">
                                                <div class="date-number">${day.date}</div>
                                                <c:if test="${not empty day.status}">
                                                    <div class="attendance-status ${day.status.toLowerCase()}">
                                                        ${day.status}
                                                    </div>
                                                </c:if>
                                            </c:if>
                                        </td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="mt-4">
                    <div class="d-flex gap-3">
                        <div class="d-flex align-items-center">
                            <span class="attendance-status present me-2">Present</span>
                            <span>${monthStats.presentDays} days</span>
                        </div>
                        <div class="d-flex align-items-center">
                            <span class="attendance-status absent me-2">Absent</span>
                            <span>${monthStats.absentDays} days</span>
                        </div>
                        <div class="d-flex align-items-center">
                            <span class="attendance-status leave me-2">Leave</span>
                            <span>${monthStats.leaveDays} days</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>