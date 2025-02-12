package employeemanagement.model;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.time.Duration;

@Entity
@Table(name = "attendance")
public class Attendance {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@ManyToOne
	@JoinColumn(name = "employee_id", nullable = false)
	private Employee employee;

	@Column(name = "first_check_in")
	private LocalDateTime firstCheckIn;

	@Column(name = "check_in_time")
	private LocalDateTime checkInTime;

	@Column(name = "check_out_time")
	private LocalDateTime checkOutTime;

	@Column(name = "total_hours")
	private Double totalHours;

	@Column(name = "date")
	private LocalDateTime date;

	// Getters and setters

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public LocalDateTime getCheckInTime() {
		return checkInTime;
	}

	public void setCheckInTime(LocalDateTime checkInTime) {
		this.checkInTime = checkInTime;
	}

	public LocalDateTime getCheckOutTime() {
		return checkOutTime;
	}

	public void setCheckOutTime(LocalDateTime checkOutTime) {
		this.checkOutTime = checkOutTime;
	}

	public Double getTotalHours() {
		return totalHours;
	}

	public void setTotalHours(Double totalHours) {
		this.totalHours = totalHours;
	}

	public LocalDateTime getDate() {
		return date;
	}

	public void setDate(LocalDateTime date) {
		this.date = date;
	}

	public Date getCheckInTimeAsDate() {
		return (checkInTime == null) ? null : Date.from(checkInTime.atZone(ZoneId.systemDefault()).toInstant());
	}

	public Date getCheckOutTimeAsDate() {
		return (checkOutTime == null) ? null : Date.from(checkOutTime.atZone(ZoneId.systemDefault()).toInstant());
	}

	public LocalDateTime getFirstCheckIn() {
		return firstCheckIn;
	}

	public void setFirstCheckIn(LocalDateTime firstCheckIn) {
		this.firstCheckIn = firstCheckIn;
	}

	public Date getFirstCheckInAsDate() {
		return firstCheckIn != null ? Date.from(firstCheckIn.atZone(ZoneId.systemDefault()).toInstant()) : null;
	}

}