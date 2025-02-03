package employeemanagement.model;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Entity
@Table(name = "admins")
public class Admin {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@NotBlank(message = "Admin ID cannot be blank")
	@Column(name = "admin_id", unique = true, nullable = false)
	private String adminId;

	@NotBlank(message = "Admin name cannot be blank")
	@Column(name = "admin_name", unique = true, nullable = false)
	private String adminName;

	@NotBlank(message = "Password cannot be blank")
	@Size(min = 5, message = "Password must be at least 5 characters long")
	@Column(name = "password", nullable = false)
	private String password;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Admin(int id, @NotBlank(message = "Admin ID cannot be blank") String adminId,
			@NotBlank(message = "Admin name cannot be blank") String adminName,
			@NotBlank(message = "Password cannot be blank") @Size(min = 5, message = "Password must be at least 5 characters long") String password) {
		super();
		this.id = id;
		this.adminId = adminId;
		this.adminName = adminName;
		this.password = password;
	}

	public Admin() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "Admin [id=" + id + ", adminId=" + adminId + ", adminName=" + adminName + ", password=" + password + "]";
	}

}