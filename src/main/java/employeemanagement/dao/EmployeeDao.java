package employeemanagement.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import employeemanagement.model.Employee;
import employeemanagement.model.Role;

@Component
public class EmployeeDao {

	@Autowired
	private HibernateTemplate hibernateTemplate;


	// create new employee
	@Transactional
	public void createEmployee(Employee employee) {
		this.hibernateTemplate.save(employee);
	}

	// update employee
	@Transactional
	public void updateEmployee(Employee employee) {
		hibernateTemplate.update(employee);
	}

	// get all employee
	public List<Employee> getEmployees() {
		List<Employee> employees = this.hibernateTemplate.loadAll(Employee.class);
		return employees;
	}

	// Get the single employee
	public Employee getEmployee(int id) {
		return this.hibernateTemplate.get(Employee.class, id);
	}

	// validation
	public boolean isEmailExists(String email) {
		try {
			String query = "FROM Employee e WHERE e.emailId = :email";
			List<Employee> employees = (List<Employee>) hibernateTemplate.findByNamedParam(query, "email", email);
			return !employees.isEmpty();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Database error occurred while checking the email.");
		}
	}

	public boolean isMobileNumberExists(String mobile) {
		try {
			String query = "FROM Employee e WHERE e.empNumber = :mobile";
			List<Employee> employees = (List<Employee>) hibernateTemplate.findByNamedParam(query, "mobile", mobile);
			return !employees.isEmpty();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Database error occurred while checking the mobile number.");
		}
	}

	// pagination
	public List<Employee> getPaginatedEmployees(int offset, int pageSize) {
		return hibernateTemplate.execute(session -> {
			String hql = "FROM Employee";
			Query<Employee> query = session.createQuery(hql, Employee.class);
			query.setFirstResult(offset);
			query.setMaxResults(pageSize);
			return query.list();
		});
	}

	public long getTotalEmployeesCount() {
		return hibernateTemplate.execute(session -> {
			String hql = "SELECT COUNT(e) FROM Employee e";
			return (Long) session.createQuery(hql).uniqueResult();
		});
	}

	// search function
	public List<Employee> searchEmployeesByName(String name, int offset, int pageSize) {
		return hibernateTemplate.execute(session -> {
			String hql = "FROM Employee e WHERE e.empName LIKE :name ";
			Query<Employee> query = session.createQuery(hql, Employee.class);
			query.setParameter("name", name + "%");
			query.setFirstResult(offset);
			query.setMaxResults(pageSize);
			return query.list();
		});
	}

	public long getSearchEmployeesCount(String name) {
		return hibernateTemplate.execute(session -> {
			String hql = "SELECT COUNT(e) FROM Employee e WHERE e.empName LIKE :name";
			Query<Long> query = session.createQuery(hql, Long.class);
			query.setParameter("name", "%" + name + "%");
			return query.uniqueResult();
		});
	}

	public Employee findEmployeeByEmail(String emailId) {
		return hibernateTemplate.execute(session -> {
			String hql = "FROM Employee WHERE emailId = :emailId";
			return session.createQuery(hql, Employee.class).setParameter("emailId", emailId).uniqueResult();
		});
	}
	
	public Employee findEmployeeByEmployeeId(String employeeId) {
	    return hibernateTemplate.execute(session -> {
	        String hql = "FROM Employee WHERE employeeId = :employeeId";
	        return session.createQuery(hql, Employee.class)
	                .setParameter("employeeId", employeeId)
	                .uniqueResult();
	    });
	}

	// status ? active : deactive;
	@Transactional
	public void updateEmployeeStatus(int employeeId, boolean status) {
		Employee employee = getEmployee(employeeId);
		if (employee != null) {
			if (!status && "ADMIN".equals(employee.getRole())) {
				throw new RuntimeException("Cannot deactivate an admin account");
			}
			employee.setActive(status);
			hibernateTemplate.update(employee);
		} 
	}

	// promote to admin
	@Transactional
	public void promoteToAdmin(int employeeId) {
	    try {
	        Employee employee = getEmployee(employeeId);
	        if (employee != null) {
	            if (!employee.isActive()) {
	                throw new RuntimeException("Cannot promote inactive employee to admin");
	            }
	            if ("ADMIN".equals(employee.getRole())) {
	                throw new RuntimeException("Employee is already an admin");
	            }
	            employee.setRole("ADMIN");
	            hibernateTemplate.update(employee);
	        } else {
	            throw new RuntimeException("Employee not found");
	        }
	    } catch (Exception e) {
	        throw new RuntimeException("Failed to promote employee to admin: " + e.getMessage());
	    }
	}


	public boolean isEmployeeIdExists(String employeeId) {
	    return hibernateTemplate.execute(session -> {
	        Query query = session.createQuery("FROM Employee WHERE employeeId = :employeeId");
	        query.setParameter("employeeId", employeeId);
	        return query.list().isEmpty();
	    });
	}

}