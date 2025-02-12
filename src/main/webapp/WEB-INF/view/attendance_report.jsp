<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<meta charset="UTF-8">
<%@include file="./base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
     <style>
        :root {
            --primary-color: #4f46e5;
            --primary-dark: #4338ca;
            --success-color: #16a34a;
            --danger-color: #dc2626;
            --warning-color: #eab308;
            --gray-light: #f3f4f6;
            --gray-medium: #9ca3af;
            --text-dark: #1f2937;
        }

        body {
            background-color: #f8fafc;
            padding: 2rem 0;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .header-section {
            background: linear-gradient(to right, #ffffff, #f8fafc);
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            padding: 2rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(229, 231, 235, 0.5);
        }

        .header-title {
            color: var(--text-dark);
            font-size: 1.875rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .header-title i {
            color: var(--primary-color);
        }

        .employee-info {
            background-color: var(--gray-light);
            border-radius: 12px;
            padding: 1.25rem;
            border: 1px solid rgba(229, 231, 235, 0.8);
        }

        .employee-info p {
            margin-bottom: 0.75rem;
            color: var(--text-dark);
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .employee-info p:last-child {
            margin-bottom: 0;
        }

        .employee-info i {
            color: var(--primary-color);
            width: 20px;
        }

        .form-control {
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            padding: 0.625rem;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            padding: 0.625rem 1.25rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-1px);
        }

        .stats-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            height: 100%;
            border: 1px solid rgba(229, 231, 235, 0.5);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .stats-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        .card-body {
            padding: 1.5rem;
        }

        .card-title {
            color: var(--gray-medium);
            font-size: 0.95rem;
            font-weight: 600;
            margin-bottom: 1.25rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .icon-circle {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 12px;
            background-color: var(--gray-light);
        }

        .card-text {
            font-size: 2rem;
            font-weight: 700;
            margin: 0;
        }

        .text-primary { color: var(--primary-color) !important; }
        .text-success { color: var(--success-color) !important; }
        .text-danger { color: var(--danger-color) !important; }
        .text-warning { color: var(--warning-color) !important; }

        .time-display {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-dark);
            display: flex;
            align-items: baseline;
            gap: 0.25rem;
        }

        .time-unit {
            font-size: 0.875rem;
            color: var(--gray-medium);
            font-weight: 500;
        }

        .attendance-issues {
            margin-top: 0.5rem;
        }

        .attendance-issues .col-6 {
            padding: 0.75rem;
        }

        .attendance-issues small {
            color: var(--gray-medium);
            font-size: 0.875rem;
            font-weight: 500;
            display: block;
            margin-bottom: 0.5rem;
        }

        .attendance-issues h3 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text-dark);
            margin: 0;
        }

        .row.g-3 {
            margin-left: -0.75rem;
            margin-right: -0.75rem;
        }

        .row.g-3 > [class*="col-"] {
            padding-left: 0.75rem;
            padding-right: 0.75rem;
        }

        @media (max-width: 768px) {
            .header-section {
                padding: 1.5rem;
            }

            .header-title {
                font-size: 1.5rem;
            }

            .card-text {
                font-size: 1.5rem;
            }

            .time-display {
                font-size: 1.25rem;
            }

            .attendance-issues h3 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header-section">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h2 class="header-title">
                        <i class="fas fa-clipboard-list me-2"></i>Attendance Report
                    </h2>
                    <div class="employee-info">
                        <p><i class="fas fa-user me-2"></i><strong>Name:</strong> ${employee.empName}</p>
                        <p><i class="fas fa-id-card me-2"></i><strong>ID:</strong> ${employee.employeeId}</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <form action="" method="get">
                        <div class="row g-2">
                            <div class="col-sm-5">
                                <input type="date" name="startDate" value="${startDate}" class="form-control" required>
                            </div>
                            <div class="col-sm-5">
                                <input type="date" name="endDate" value="${endDate}" class="form-control" required>
                            </div>
                            <div class="col-sm-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="row g-3">
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="card-body">
                        <h6 class="card-title">
                            <div class="icon-circle">
                                <i class="fas fa-calendar-alt text-primary"></i>
                            </div>
                            Working Days
                        </h6>
                        <p class="card-text">${record.totalDays}</p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stats-card">
                    <div class="card-body">
                        <h6 class="card-title">
                            <div class="icon-circle">
                                <i class="fas fa-check text-success"></i>
                            </div>
                            Present Days
                        </h6>
                        <p class="card-text text-success">${record.presentDays}</p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stats-card">
                    <div class="card-body">
                        <h6 class="card-title">
                            <div class="icon-circle">
                                <i class="fas fa-times text-danger"></i>
                            </div>
                            Absent Days
                        </h6>
                        <p class="card-text text-danger">${record.absentDays}</p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stats-card">
                    <div class="card-body">
                        <h6 class="card-title">
                            <div class="icon-circle">
                                <i class="fas fa-umbrella-beach text-warning"></i>
                            </div>
                            Leave Days
                        </h6>
                        <p class="card-text text-warning">${record.leaveDays}</p>
                    </div>
                </div>
            </div>

            <c:set var="avgDecimal" value="${record.averageWorkingHours}" />
            <c:set var="avgHours" value="${avgDecimal - (avgDecimal mod 1)}" />
            <c:set var="avgMinutes" value="${(avgDecimal mod 1) * 60}" />
            <div class="col-md-4">
                <div class="stats-card">
                    <div class="card-body">
                        <h6 class="card-title">
                            <div class="icon-circle">
                                <i class="fas fa-clock text-primary"></i>
                            </div>
                            Average Hours
                        </h6>
                        <div class="time-display">
                            <fmt:formatNumber value="${avgHours}" pattern="0"/>
                            <span class="time-unit">h</span>
                            <fmt:formatNumber value="${avgMinutes}" pattern="0"/>
                            <span class="time-unit">m</span>
                        </div>
                    </div>
                </div>
            </div>

            <c:set var="totalDecimal" value="${record.totalWorkingHours}" />
            <c:set var="totalHours" value="${totalDecimal - (totalDecimal mod 1)}" />
            <c:set var="totalMinutes" value="${(totalDecimal mod 1) * 60}" />
            <div class="col-md-4">
                <div class="stats-card">
                    <div class="card-body">
                        <h6 class="card-title">
                            <div class="icon-circle">
                                <i class="fas fa-hourglass-half text-primary"></i>
                            </div>
                            Total Hours
                        </h6>
                        <div class="time-display">
                            <fmt:formatNumber value="${totalHours}" pattern="0"/>
                            <span class="time-unit">h</span>
                            <fmt:formatNumber value="${totalMinutes}" pattern="0"/>
                            <span class="time-unit">m</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stats-card">
                    <div class="card-body">
                        <h6 class="card-title">
                            <div class="icon-circle">
                                <i class="fas fa-exclamation-triangle text-warning"></i>
                            </div>
                            Attendance Issues
                        </h6>
                        <div class="row text-center attendance-issues">
                            <div class="col-6">
                                <small><i class="fas fa-clock me-1"></i>Late Arrivals</small>
                                <h3>${record.lateArrivals}</h3>
                            </div>
                            <div class="col-6">
                                <small><i class="fas fa-sign-out-alt me-1"></i>Early Departures</small>
                                <h3>${record.earlyDepartures}</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>