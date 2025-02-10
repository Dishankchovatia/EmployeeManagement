<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Salary Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header">
                <h3>Monthly Salary Details</h3>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <table class="table table-bordered">
                            <tr>
                                <th>Base Salary:</th>
                                <td>₹<fmt:formatNumber value="${salaryDetails.baseSalary}" pattern="#,##0.00"/></td>
                            </tr>
                            <tr>
                                <th>Total Leaves This Month:</th>
                                <td>${salaryDetails.totalLeaves}</td>
                            </tr>
                            <tr>
                                <th>Deduction Amount:</th>
                                <td class="text-danger">₹<fmt:formatNumber value="${salaryDetails.deduction}" pattern="#,##0.00"/></td>
                            </tr>
                            <tr class="table-primary">
                                <th>Final Salary:</th>
                                <td>₹<fmt:formatNumber value="${salaryDetails.finalSalary}" pattern="#,##0.00"/></td>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <div class="alert alert-info mt-3">
                    <strong>Note:</strong> A 40% deduction of daily salary is applied for each leave taken beyond 2 leaves per month.
                </div>
                
                <a href="/my-leaves" class="btn btn-primary">Back to Leave History</a>
            </div>
        </div>
    </div>
</body>
</html>