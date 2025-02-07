<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%@include file="./base.jsp"%>
    <%@ taglib  prefix="form" uri="http://www.springframework.org/tags/form"  %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <style>
   
        :root {
            --primary: #2dd4bf;
            --primary-dark: #0d9488;
            --secondary: #475569;
            --background: #f8fafc;
            --surface: #ffffff;
            --error: #ef4444;
            --success: #22c55e;
            --text: #334155;
        }

        body {
            background: linear-gradient(120deg, #e0f2fe 0%, #f0fdf4 100%);
            min-height: 100vh;
            color: var(--text);
            font-family: 'Outfit', sans-serif;
        }

        .update-form-wrapper {
            background: var(--surface);
            border-radius: 20px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
            padding: 2.5rem;
            position: relative;
            margin-top: 2rem;
            overflow: hidden;
        }

        .update-form-wrapper::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, rgba(45, 212, 191, 0.1), rgba(13, 148, 136, 0.1));
            pointer-events: none;
        }

        h2 {
            color: var(--primary-dark);
            font-size: 2rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 2.5rem;
            position: relative;
            display: inline-block;
            left: 50%;
            transform: translateX(-50%);
        }

        h2::after {
            
            position: absolute;
            right: -2rem;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.8rem;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            font-weight: 500;
            color: var(--secondary);
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control {
            background: #f8fafc;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 0.875rem 1.25rem;
            transition: all 0.3s ease;
            font-size: 1rem;
            width: 100%;
            color: var(--text);
        }

        .form-control:focus {
            border-color: var(--primary);
            background: white;
            box-shadow: 0 0 0 4px rgba(45, 212, 191, 0.1);
            outline: none;
        }

        .form-control:hover {
            border-color: var(--primary-dark);
        }

        .gender-section {
            background: #f1f5f9;
            padding: 1.25rem;
            border-radius: 12px;
            margin-bottom: 1.8rem;
        }

        .gender-section span {
            font-weight: 500;
            color: var(--secondary);
            display: block;
            margin-bottom: 1rem;
        }

        .form-check {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1.25rem;
            background: white;
            border-radius: 8px;
            margin-right: 1rem;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .form-check:hover {
            border-color: var(--primary);
            transform: translateY(-2px);
        }

        .form-check-input {
            width: 1.25rem;
            height: 1.25rem;
            margin-right: 0.5rem;
            cursor: pointer;
            border: 2px solid #cbd5e1;
        }

        .form-check-input:checked {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .form-check-label {
            cursor: pointer;
            font-weight: 500;
            color: var(--text);
        }

        .date-input-group {
            position: relative;
        }

        .date-input-group::after {
            content: '📅';
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
            opacity: 0.5;
        }

        .btn {
            padding: 0.875rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(45deg, var(--primary), var(--primary-dark));
            border: none;
            color: white;
            box-shadow: 0 4px 15px rgba(45, 212, 191, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(45, 212, 191, 0.4);
        }

        .btn-outline-danger {
            border: 2px solid var(--error);
            color: var(--error);
            background: transparent;
            margin-right: 1rem;
        }

        .btn-outline-danger:hover {
            background: var(--error);
            color: white;
            transform: translateY(-2px);
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2.5rem;
        }

        /* Animation for form elements */
        @keyframes slideUp {
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .form-group {
            animation: slideUp 0.4s ease forwards;
            opacity: 0;
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .form-group:nth-child(4) { animation-delay: 0.4s; }
        .form-group:nth-child(5) { animation-delay: 0.5s; }
        .form-group:nth-child(6) { animation-delay: 0.6s; }

        /* Success message animation */
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .update-success {
            color: var(--success);
            text-align: center;
            margin-top: 1rem;
            animation: pulse 1s ease infinite;
        }

        @media (max-width: 768px) {
            .update-form-wrapper {
                padding: 1.5rem;
                margin: 1rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                margin: 0.5rem 0;
            }

            h2 {
                font-size: 1.75rem;
            }
        }
    </style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
 </script>
 

</head>
<body>
    <div class="container mt-3">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="update-form-wrapper">
                    <h2>Update Employee Details</h2>
                    <form:form action="${pageContext.request.contextPath}/update-employee" method="post" modelAttribute="employee">
                        <input type="hidden" name="id" value="${employee.id}" />
                        
                        <div class="form-group">
                            <label for="empName">Employee Name</label>
                            <input type="text" class="form-control" id="empName"
                                   name="empName" placeholder="Enter employee name"
                                   value="${employee.empName}" required />
                                   <form:errors path="empName" cssClass="error text-danger" />
                        </div>
                        <div class="form-group">
                            <label for="employeeId">Employee ID</label>
                            <input type="text" class="form-control" id="employeeId"
                                   name="employeeId" placeholder="Enter employee ID"
                                   value="${employee.employeeId}" required />
                                   <form:errors path="employeeId" cssClass="error text-danger" />
                        </div>
                        
                        <div class="form-group">
                            <label for="salary">Salary</label>
                            <input type="text" class="form-control" id="salary"
                                   name="salary" placeholder="Enter salary "
                                   value="${employee.salary}" required />
                                   <form:errors path="salary" cssClass="error text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="empNumber">Mobile Number</label>
                            <input type="number" class="form-control" id="empNumber"
                                   name="empNumber" placeholder="Enter mobile number"
                                   value="${employee.empNumber}" required />
                                   <form:errors path="empNumber" cssClass="error text-danger" /> 
                                   <small id="errorMobile" class="text-danger">${errorMobile != null ? errorMobile : "" }</small>
                        </div>

                        <div class="form-group">
                            <label for="emailId">Email Address</label>
                            <input type="email" class="form-control" id="emailId"
                                   name="emailId" placeholder="Enter email address"
                                   value="${employee.emailId}" required />
                                    <form:errors path="emailId" cssClass="error text-danger" /> 
                                   <small id="errorEmail" class="text-danger">${errorEmail != null ? errorEmail : "" }</small>
                        </div>
                      
						<input type="hidden" name="password" value="${employee.password}" />
                        <div class="gender-section">
                            <span>Gender</span>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="gender"
                                       id="inlineRadio1" value="male" ${employee.gender == 'male' ? 'checked' : ''}>
                                <label class="form-check-label" for="inlineRadio1">Male</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="gender"
                                       id="inlineRadio2" value="female" ${employee.gender == 'female' ? 'checked' : ''}>
                                <label class="form-check-label" for="inlineRadio2">Female</label>
                            </div>
                        </div>

                        <div class="form-group date-input-group">
                            <label for="dob">Date of Birth</label>
                            <input type="date" class="form-control" id="dob"
                                   name="dob" value="${employee.dob}" required />
                        </div>

                        <div class="form-group date-input-group">
                            <label for="doj">Date of Joining</label>
                            <input type="date" class="form-control" id="doj"
                                   name="doj" value="${employee.doj}" required />
                        </div>

                        <div class="action-buttons">
                        <button type="submit" class="btn btn-primary">
                                Update Details
                            </button>
                            <a href="${pageContext.request.contextPath}/listofemployees"
                               class="btn btn-outline-danger">Cancel</a>
                            
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
    <script>
    $(document).ready(function () {
        let emailValid = true;
        let mobileValid = true;
        const originalEmail = $("#emailId").val(); 
        const originalMobile = $("#empNumber").val(); 
        
        function toggleSubmitButton() {
            if (emailValid && mobileValid) {
                $("button[type='submit']").prop("disabled", false);
            } else {
                $("button[type='submit']").prop("disabled", true);
            }
        }
        toggleSubmitButton();

        // Validate Email
        $("#emailId").on("input", function () {
            const email = $(this).val();
            if (email) {
                if (email === originalEmail) {
                  
                    $('#errorEmail').text('').hide();
                    $('#emailId').removeClass('is-invalid').addClass('is-valid');
                    emailValid = true;
                    toggleSubmitButton();
                    return;
                }

                $.get('${pageContext.request.contextPath}/checkEmail', { email: email }, function (response) {
                    if (response.exists) {
                        $('#errorEmail').text('This email is already in use.').show();
                        $('#emailId').addClass('is-invalid').removeClass('is-valid');
                        emailValid = false;
                    } else {
                        $('#errorEmail').text('').hide();
                        $('#emailId').addClass('is-valid').removeClass('is-invalid');
                        emailValid = true;
                    }
                    toggleSubmitButton();
                }).fail(function (jqXHR, textStatus, errorThrown) {
                    console.error("Request failed: " + textStatus + ", " + errorThrown);
                });
            } else {
                $('#errorEmail').text('Email cannot be empty.').show();
                $('#emailId').addClass('is-invalid').removeClass('is-valid');
                emailValid = false;
                toggleSubmitButton();
            }
        });

        // Validate Mobile Number
        $("#empNumber").on("input", function () {
            const mobile = $(this).val();
            if (mobile) {
                if (mobile === originalMobile) {
                    
                    $('#errorMobile').text('').hide();
                    $('#empNumber').removeClass('is-invalid').addClass('is-valid');
                    mobileValid = true;
                    toggleSubmitButton();
                    return;
                }

                $.get('${pageContext.request.contextPath}/checkMobile', { mobile: mobile }, function (response) {
                    if (response.exists) {
                        $('#errorMobile').text('This mobile number is already in use.').show();
                        $('#empNumber').addClass('is-invalid').removeClass('is-valid');
                        mobileValid = false;
                    } else {
                        $('#errorMobile').text('').hide();
                        $('#empNumber').addClass('is-valid').removeClass('is-invalid');
                        mobileValid = true;
                    }
                    toggleSubmitButton();
                }).fail(function (jqXHR, textStatus, errorThrown) {
                    console.error("Request failed: " + textStatus + ", " + errorThrown);
                });
            } else {
                $('#errorMobile').text('Mobile number cannot be empty.').show();
                $('#empNumber').addClass('is-invalid').removeClass('is-valid');
                mobileValid = false;
                toggleSubmitButton();
            }
        });
    });

    
    </script>
</body>
</html>