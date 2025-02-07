package employeemanagement.model;

import java.math.BigDecimal;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@Entity
@Table(name = "employee")
public class Employee {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@NotBlank(message = "Employee ID cannot be blank")
	@Column(name = "employee_id", unique = true, nullable = false)
	private String employeeId;

	@NotBlank(message = "Employee name cannot be blank")
	@Column(name = "emp_name", nullable = false)
	private String empName;

	@NotBlank(message = "Employee number cannot be blank")
	@Pattern(regexp = "^[0-9]{10}$", message = "Employee number must be a 10-digit number")
	@Column(name = "emp_number", unique = true, nullable = false)
	private String empNumber;

	@NotBlank(message = "Email cannot be blank")
	@Email(message = "Invalid email format")
	@Column(name = "email_id", unique = true, nullable = false)
	private String emailId;

	@NotBlank(message = "Gender cannot be blank")
	private String gender;

	@NotNull(message = "Date of birth cannot be null")
	private String dob;

	@NotNull(message = "Date of joining cannot be null")
	private String doj;

	@NotBlank(message = "Password cannot be blank")
	@Size(min = 6, message = "Password must be at least 6 characters long")
	@Column(name = "password", nullable = false)
	private String password;

	@Column(name = "is_active", nullable = false)
	private boolean isActive = true;

	@Column(name = "role", nullable = false)
	private String role = "USER";

	@Version
	@Column(name = "version", nullable = false)
	private int version;

	@Column(name = "salary")
	private BigDecimal salary;

	public BigDecimal getSalary() {
		return salary;
	}

	public void setSalary(BigDecimal salary) {
		this.salary = salary;
	}

	public boolean isActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getEmpNumber() {
		return empNumber;
	}

	public void setEmpNumber(String empNumber) {
		this.empNumber = empNumber;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getDoj() {
		return doj;
	}

	public void setDoj(String doj) {
		this.doj = doj;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public Employee() {
		super();
	}

	public Employee(int id, @NotBlank(message = "Employee ID cannot be blank") String employeeId,
			@NotBlank(message = "Employee name cannot be blank") String empName,
			@NotBlank(message = "Employee number cannot be blank") @Pattern(regexp = "^[0-9]{10}$", message = "Employee number must be a 10-digit number") String empNumber,
			@NotBlank(message = "Email cannot be blank") @Email(message = "Invalid email format") String emailId,
			@NotBlank(message = "Gender cannot be blank") String gender,
			@NotNull(message = "Date of birth cannot be null") String dob,
			@NotNull(message = "Date of joining cannot be null") String doj,
			@NotBlank(message = "Password cannot be blank") @Size(min = 6, message = "Password must be at least 6 characters long") String password,
			boolean isActive, String role, int version, BigDecimal salary) {
		super();
		this.id = id;
		this.employeeId = employeeId;
		this.empName = empName;
		this.empNumber = empNumber;
		this.emailId = emailId;
		this.gender = gender;
		this.dob = dob;
		this.doj = doj;
		this.password = password;
		this.isActive = isActive;
		this.role = role;
		this.version = version;
		this.salary = salary;
	}

	@Override
	public String toString() {
		return "Employee [id=" + id + ", employeeId=" + employeeId + ", empName=" + empName + ", empNumber=" + empNumber
				+ ", emailId=" + emailId + ", gender=" + gender + ", dob=" + dob + ", doj=" + doj + ", password="
				+ password + ", isActive=" + isActive + ", role=" + role + ", version=" + version + ", salary=" + salary
				+ "]";
	}

}