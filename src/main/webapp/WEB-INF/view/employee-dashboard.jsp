<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>
    <%@include file="./base.jsp"%>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #4f46e5;
            --secondary-color: #818cf8;
            --text-primary: #1f2937;
            --text-secondary: #4b5563;
            --bg-gradient: linear-gradient(135deg, #4f46e5, #818cf8);
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-gradient);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            color: var(--text-primary);
        }

        .dashboard-container {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 800px;
            position: relative;
            overflow: hidden;
        }

        .dashboard-header {
            padding: 2rem;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            text-align: center;
        }

        .dashboard-header h1 {
            color: var(--primary-color);
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .dashboard-header h2 {
            color: var(--text-secondary);
            font-size: 1.25rem;
            font-weight: 500;
        }

        .employee-details {
            padding: 2rem;
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .detail-item {
            padding: 1rem;
            background: #f8fafc;
            border-radius: 0.5rem;
            border: 1px solid #e2e8f0;
        }

        .detail-label {
            color: var(--text-secondary);
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 0.25rem;
        }

        .detail-value {
            color: var(--text-primary);
            font-size: 1rem;
            font-weight: 600;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 500;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background: #4338ca;
            transform: translateY(-1px);
        }

        .btn-info {
            background: #0ea5e9;
            color: white;
        }

        .btn-info:hover {
            background: #0284c7;
            transform: translateY(-1px);
        }

        .btn-update {
            background: var(--secondary-color);
            color: white;
            width: 100%;
            justify-content: center;
        }

        .btn-update:hover {
            background: #6366f1;
            transform: translateY(-1px);
        }

        .btn-logout {
            position: fixed;
            top: 1rem;
            right: 1rem;
            background: #ef4444;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
        }

        .btn-logout:hover {
            background: #dc2626;
            transform: translateY(-1px);
        }

        @media (max-width: 640px) {
            .dashboard-container {
                margin: 1rem;
            }
            
            .details-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
        
          .text-danger {
        color: #ef4444 !important;
    }
    
    .text-primary {
        color: #4f46e5 !important;
    }
    
    .highlight-deduction {
        background: #fee2e2 !important;
        border-color: #fecaca !important;
    }
    
    .highlight-final {
        background: #e0e7ff !important;
        border-color: #c7d2fe !important;
    }
    
    .detail-item .detail-label {
        margin-bottom: 0.5rem;
    }
    
     .text-muted {
        color: #6b7280;
        font-size: 0.875rem;
    }
    
    .info-tooltip {
        display: inline-block;
        margin-left: 0.5rem;
        color: #6b7280;
        cursor: help;
    }
    
    .time-display {
            font-size: 2.5rem;
            font-weight: bold;
            text-align: center;
            margin: 20px 0;
        }
        .attendance-card {
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .attendance-status {
            font-size: 1.2rem;
            margin-top: 10px;
            text-align: center;
        }
        .timer {
            font-size: 1.8rem;
            text-align: center;
            margin: 15px 0;
        }
    
    </style>
    
    
</head>
<body>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="csrfToken"/>

    <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>

    <div class="dashboard-container">
        <div class="dashboard-header">
            <h1>Employee Dashboard</h1>
            <h2>Welcome, ${employee.empName}!</h2>
        </div>
        <div class="employee-details">
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/apply-leave" class="btn btn-primary">
                    <i class="fas fa-calendar-plus"></i> Apply for Leave
                </a>
                <a href="${pageContext.request.contextPath}/my-leaves" class="btn btn-info">
                    <i class="fas fa-calendar-check"></i> My Leaves
                </a>
            </div>
            
            <div class="details-grid">
                <div class="detail-item">
                    <div class="detail-label">Name</div>
                    <div class="detail-value">${employee.empName}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">EmpID</div>
                    <div class="detail-value">${employee.employeeId}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Mobile</div>
                    <div class="detail-value">${employee.empNumber}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Email</div>
                    <div class="detail-value">${employee.emailId}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Gender</div>
                    <div class="detail-value">${employee.gender}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Date of Birth</div>
                    <div class="detail-value">${employee.dob}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Date of Joining</div>
                    <div class="detail-value">${employee.doj}</div>
                </div>
        
				<div class="detail-item">
					<div class="detail-label">Base Salary Per Month</div>
					<div class="detail-value">
						₹
						<fmt:formatNumber value="${salaryDetails.baseSalary}"
							pattern="#,##0.00" />
					</div>
				</div>

				<div class="detail-item">
					<div class="detail-label">Loss of Pay (LOP) Days</div>
					<div class="detail-value">${salaryDetails.lopDays}</div>
				</div>

				<div class="detail-item">
					<div class="detail-label">Other Leave Days</div>
					<div class="detail-value">${salaryDetails.nonLopDays}</div>
				</div>
				<div
					class="detail-item <c:if test="${salaryDetails.deduction > 0}">highlight-deduction</c:if>">
					<div class="detail-label">Leave Deduction</div>
					<div class="detail-value text-danger">
						-₹
						<fmt:formatNumber value="${salaryDetails.deduction}"
							pattern="#,##0.00" />
					</div>
				</div>

				<c:set var="isPositiveDeduction"
					value="${salaryDetails.deduction > 0}" />

				<div
					class="detail-item ${isPositiveDeduction ? 'highlight-final' : ''}">
					<div class="detail-label">Final Salary</div>
					<div
						class="detail-value ${isPositiveDeduction ? 'text-primary' : ''}">
						₹
						<fmt:formatNumber value="${salaryDetails.finalSalary}"
							pattern="#,##0.00" />
					</div>
				</div>
			</div>
			<a href="eupdate/${employee.id}" class="btn btn-update">
                <i class="fas fa-user-edit"></i> Update Details
            </a>
        </div>

	<!-- Attendance Section -->
		<div class="card mt-4">
			<div
				class="card-header d-flex justify-content-between align-items-center">
				<h4 class="mb-0">Attendance Management</h4>
				<div>
					<a href="attendance/calender/${employee.id}"
						class="btn btn-outline-primary me-2"> <i
						class="fas fa-calendar-alt"></i> Calendar
					</a> <a href="attendance/report/${employee.id}"
						class="btn btn-outline-success"> <i class="fas fa-file-alt"></i>
						Report
					</a>
				</div>
			</div>

			<div class="card-body">
				<div id="attendanceStatus">
					<!-- Status will be displayed here -->
				</div>

				<div id="workingHours" class="alert alert-info mt-3"
					style="display: none;">
					<!-- Working hours will be displayed here -->
				</div>

				<div class="d-flex gap-2 mt-3">
					<button id="checkInBtn" class="btn btn-success">Check In</button>
					<button id="checkOutBtn" class="btn btn-danger"
						style="display: none;">Check Out</button>
				</div>

				<div id="currentTime" class="mt-3">
					<!-- Current time will be displayed here -->
				</div>
			</div>
		</div>

	</div>
	
<script>
//Function to format time
function formatTime(dateTimeString) {
    const date = new Date(dateTimeString);
    return date.toLocaleTimeString();
}

function calculateDuration(checkInTime, endTime = new Date()) {
    const checkInDate = new Date(checkInTime);
    if (isNaN(checkInDate)) {
        console.error("Invalid checkInTime:", checkInTime);
        return "Invalid time";
    }
    const endDate = new Date(endTime);
    const diffMs = endDate - checkInDate;
    const diffHrs = Math.floor(diffMs / 3600000);
    const diffMins = Math.floor((diffMs % 3600000) / 60000);    
    return diffHrs + " hours " + diffMins + " minutes";
}

function updateClock() {
    const now = new Date();
    const timeString = now.toLocaleTimeString();
    document.getElementById('currentTime').textContent = 'Current Time: ' + timeString;
}

function updateAttendanceStatus() {
    const token = document.getElementById('csrfToken').value;
    const statusDiv = document.getElementById('attendanceStatus'); 

    fetch('${pageContext.request.contextPath}/attendance-status', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': token
        },
        credentials: 'same-origin'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        const checkInBtn = document.getElementById('checkInBtn');
        const checkOutBtn = document.getElementById('checkOutBtn');

        if (data.error) {
            statusDiv.innerHTML = '<div class="alert alert-danger">' + data.error + '</div>';
            return;
        }

        if (data.completed) {
            statusDiv.innerHTML = 
                '<div class="alert alert-success">' +
                'Latest session details:<br>' +
                'Check-in: ' + formatTime(data.checkInTime) + '<br>' +
                'Check-out: ' + formatTime(data.checkOutTime) + '<br>' +
                'Total time worked today: ' + data.hours + ' hours ' + data.minutes + ' minutes' +
                '</div>';
            checkInBtn.style.display = 'block';
            checkOutBtn.style.display = 'none';
        } else if (data.checkedIn) {
        	const currentDuration = calculateDuration(data.checkInTime);
        	statusDiv.innerHTML = 
        	    '<div class="alert alert-info">' +
        	    'Current session started at: ' + formatTime(data.checkInTime) + '<br>' +
        	    'Time worked this session: ' + currentDuration + '<br>' +
        	    '</div>';

            checkInBtn.style.display = 'none';
            checkOutBtn.style.display = 'block';
        } else {
            statusDiv.innerHTML = '<div class="alert alert-warning">You haven\'t checked in today</div>';
            checkInBtn.style.display = 'block';
            checkOutBtn.style.display = 'none';
        }
    })
    .catch(error => {
        console.error('Error:', error);
        statusDiv.innerHTML = '<div class="alert alert-danger">Error loading attendance status. Please try again.</div>';
    });
}

document.getElementById('checkInBtn').addEventListener('click', function() {
    const token = document.getElementById('csrfToken').value;
    
    fetch('${pageContext.request.contextPath}/check-in', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': token
        },
        credentials: 'same-origin'
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            updateAttendanceStatus();
        } else {
            alert(data.message || 'Error checking in');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Error checking in. Please try again.');
    });
});

document.getElementById('checkOutBtn').addEventListener('click', function() {
    const token = document.getElementById('csrfToken').value;
    
    fetch('${pageContext.request.contextPath}/check-out', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': token
        },
        credentials: 'same-origin'
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            updateAttendanceStatus();
        } else {
            alert(data.message || 'Error checking out');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Error checking out. Please try again.');
    });
});

setInterval(updateAttendanceStatus, 60000);
setInterval(updateClock, 1000);

updateClock();
updateAttendanceStatus();
</script>
    
</body>
</html>
