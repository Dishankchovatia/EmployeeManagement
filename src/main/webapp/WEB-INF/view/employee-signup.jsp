<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="./base.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>
:root { -
	-primary-color: #6366f1; -
	-primary-dark: #4f46e5; -
	-surface-color: #ffffff; -
	-background-color: #f3f4f6; -
	-text-color: #1f2937; -
	-error-color: #ef4444; -
	-success-color: #10b981;
}

body {
	background: linear-gradient(135deg, #f0f3ff 0%, #e8eaff 100%);
	min-height: 100vh;
	color: var(- -text-color);
	font-family: 'Plus Jakarta Sans', sans-serif;
}

.container {
	padding-top: 2rem;
	padding-bottom: 2rem;
}

.form-container {
	background: var(- -surface-color);
	border-radius: 24px;
	box-shadow: 0 20px 40px rgba(99, 102, 241, 0.1);
	padding: 2.5rem;
	position: relative;
	overflow: hidden;
}

.form-container::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	height: 4px;
	background: linear-gradient(to right, var(- -primary-color),
		var(- -primary-dark));
}

h2 {
	color: var(- -primary-dark);
	font-weight: 700;
	margin-bottom: 2rem;
	position: relative;
	padding-bottom: 1rem;
	text-align: center;
}

h2::after {
	content: '';
	position: absolute;
	bottom: 0;
	left: 50%;
	transform: translateX(-50%);
	width: 60px;
	height: 3px;
	background: var(- -primary-color);
	border-radius: 2px;
}

.form-group {
	margin-bottom: 1.5rem;
	position: relative;
}

.form-group label {
	display: block;
	margin-bottom: 0.5rem;
	font-weight: 600;
	color: var(- -text-color);
	font-size: 0.95rem;
}

.form-control {
	border: 2px solid #e5e7eb;
	border-radius: 12px;
	padding: 0.75rem 1rem;
	transition: all 0.3s ease;
	font-size: 1rem;
}

.form-control:focus {
	border-color: var(- -primary-color);
	box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
	outline: none;
}

.form-control::placeholder {
	color: #9ca3af;
}

.gender-section {
	background: #f8f9fa;
	padding: 1rem;
	border-radius: 12px;
	margin-bottom: 1.5rem;
}

.gender-section span {
	font-weight: 600;
	display: block;
	margin-bottom: 0.75rem;
}

.form-check {
	padding: 0.5rem 1rem;
	transition: all 0.3s ease;
}

.form-check-input {
	width: 1.2em;
	height: 1.2em;
	margin-top: 0.25em;
	cursor: pointer;
}

.form-check-input:checked {
	background-color: var(- -primary-color);
	border-color: var(- -primary-color);
}

.form-check-label {
	margin-left: 0.5rem;
	cursor: pointer;
}

.date-input {
	position: relative;
}

.date-input .form-control {
	padding-right: 2.5rem;
}

.date-input::after {
	content: '📅';
	position: absolute;
	right: 1rem;
	top: 50%;
	transform: translateY(-50%);
	pointer-events: none;
}

.btn {
	padding: 0.75rem 1.5rem;
	border-radius: 12px;
	font-weight: 600;
	letter-spacing: 0.5px;
	transition: all 0.3s ease;
}

.btn-primary {
	background: linear-gradient(45deg, var(- -primary-color),
		var(- -primary-dark));
	border: none;
	color: white;
	box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
}

.btn-primary:hover {
	transform: translateY(-2px);
	box-shadow: 0 8px 25px rgba(99, 102, 241, 0.4);
	background: linear-gradient(45deg, var(- -primary-dark),
		var(- -primary-color));
}

.btn-outline-danger {
	border: 2px solid var(- -error-color);
	color: var(- -error-color);
	background: transparent;
}

.btn-outline-danger:hover {
	background: var(- -error-color);
	color: white;
	transform: translateY(-2px);
	box-shadow: 0 4px 15px rgba(239, 68, 68, 0.2);
}

.form-actions {
	display: flex;
	gap: 1rem;
	justify-content: center;
	margin-top: 2rem;
}

/* Custom animation for form inputs */
@
keyframes float-label {from { transform:translateY(0);
	opacity: 0;
}

to {
	transform: translateY(-10px);
	opacity: 1;
}

}
.form-group:focus-within label {
	color: var(- -primary-color);
	animation: float-label 0.3s ease forwards;
}

/* Responsive adjustments */
@media ( max-width : 768px) {
	.form-container {
		padding: 1.5rem;
	}
	.col-md-6 {
		padding: 0 1rem;
	}
	.btn {
		width: 100%;
		margin: 0.5rem 0;
	}
	.form-actions {
		flex-direction: column;
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
				<div class="form-container">
					<h2>Employee Information</h2>
					<%-- <form:errors path="employee.*" /> --%>
					<form:form action="signup-employee" method="post"
						modelAttribute="employee">
						<div class="form-group">
							<label for="empName">Employee Name</label> <input type="text"
								class="form-control" id="empName" name="empName"
								placeholder="Enter your full name" required value="${employee.empName }"/>
							<form:errors path="empName" cssClass="error text-danger" />
							
						</div>

						<div class="form-group">
							<label for="empNumber">Mobile Number</label> <input type="tel"
								class="form-control" name="empNumber" id="empNumber"
								placeholder="Enter your mobile number" required  value="${employee.empNumber }"/>
							 <form:errors path="empNumber" cssClass="error text-danger" /> 
							<small id="errorMobile" class="text-danger">${errorMobile != null ? errorMobile : "" }</small>
							
						</div>

						<div class="form-group">
							<label for="emailId">Email Address</label> <input type="email"
								class="form-control" id="emailId" name="emailId"
								placeholder="Enter your email address" required value="${employee.emailId }"/>
							 <form:errors path="emailId" cssClass="error text-danger" /> 
							
						<small id="errorEmail" class="text-danger">${errorEmail != null ? errorEmail : "" }</small>

						</div>
						<div class="form-group" style="position: relative;">
							<label for="password">Password:</label> <input type="password"
								placeholder="Enter your password" id="password" name="password"
								class="form-control" required> <i class="fa fa-eye"
								id="togglePassword"
								style="position: absolute; right: 18px; top: 70%; transform: translateY(-50%); cursor: pointer;"></i>
						<form:errors path="password" cssClass="error text-danger" />
						</div>

						<div class="gender-section">
							<span>Gender</span>
							<div class="form-check">
								<input class="form-check-input" type="radio" name="gender"
									id="inlineRadio1" value="male" required ${employee.gender == 'male' ? 'checked' : ''}> <label
									class="form-check-label" for="inlineRadio1">Male</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="radio" name="gender"
									id="inlineRadio2" value="female" required ${employee.gender == 'Female' ? 'checked' : ''}> <label
									class="form-check-label" for="inlineRadio2">Female</label>
							</div>

						</div>

						<div class="form-group date-input">
							<label for="dob">Date of Birth</label> <input type="date"
								class="form-control" id="dob" name="dob" required value="${employee.dob }"/>
						</div>

						<div class="form-group date-input">
							<label for="doj">Date of Joining</label> <input type="date"
								class="form-control" id="doj" name="doj" required value="${employee.doj }"/>
							<form:errors path="doj" cssClass="text-danger" />
						</div>
						

						<div class="form-actions">
							<button type="submit" class="btn btn-primary">Signup</button>
							<a href="${pageContext.request.contextPath}/"
								class="btn btn-outline-danger">Cancel</a>

						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	
	<script>

	$(document).ready(function () {
	    let emailValid = false;
	    let mobileValid = false;

	    function toggleSubmitButton() {
	        if (emailValid && mobileValid) {
	            $("button[type='submit']").prop("disabled", false);
	        } else {
	            $("button[type='submit']").prop("disabled", true);
	        }
	    }
	    toggleSubmitButton();

	   
	    $("#emailId").on('input', function () {
	        var email = $(this).val();
	        if (email) {
	            $.get('${pageContext.request.contextPath}/checkEmail', { email: email }, function (response) {
	                if (response.exists) {
	                    $('#errorEmail').text('This email is already registered.').show();
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
	    $("#empNumber").on('input', function () {
	        var mobile = $(this).val();
	        if (mobile) {
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
	document.getElementById("togglePassword").addEventListener("click", function () {
	    var passwordField = document.getElementById("password");
	    var icon = document.getElementById("togglePassword");
	    if (passwordField.type === "password") {
	        passwordField.type = "text";
	        icon.classList.remove("fa-eye");
	        icon.classList.add("fa-eye-slash");
	    } else {
	        passwordField.type = "password";
	        icon.classList.remove("fa-eye-slash");
	        icon.classList.add("fa-eye");
	    }
	});
	        
	</script>
</body>
</html>

