package employeemanagement.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import employeemanagement.dao.EmployeeDao;
import employeemanagement.model.Employee;
import employeemanagement.service.EmailService;

@Controller
public class AdminController {

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private EmployeeDao employeeDao;

	@Autowired
	private EmailService emailService;

	@GetMapping("/dashboard")
	public String adminDashboard(Model model, HttpSession session) {
		String empName = (String) session.getAttribute("name");
		model.addAttribute("empName", empName);
		return "admin-dashboard";
	}

	// Add Employee Form
	@RequestMapping("/add-employee")
	public String addEmployee(Model m) {
		m.addAttribute("title", "Add Employee");
		return "add_employee_form";
	}

	@RequestMapping(value = "/handle-employee", method = RequestMethod.POST)
	public RedirectView handleEmployee(@Valid @ModelAttribute Employee employee, BindingResult result,
			HttpServletRequest request, RedirectAttributes redirectAttributes, Model model) {

		boolean emailExists = employeeDao.isEmailExists(employee.getEmailId());
		boolean mobileExists = employeeDao.isMobileNumberExists(employee.getEmpNumber());

		if (emailExists || mobileExists) {
			model.addAttribute("errorEmail", emailExists ? "This email is already in use." : null);
			model.addAttribute("errorMobile", mobileExists ? "This mobile number is already in use." : null);
			return new RedirectView("add-employee");
		}

		// Validate form inputs
		if (result.hasErrors()) {
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.employee", result);
			redirectAttributes.addFlashAttribute("employee", employee);
			return new RedirectView("add-employee");
		}

		String plainPassword = employee.getPassword();
		String encryptedPassword = passwordEncoder.encode(employee.getPassword());
		employee.setPassword(encryptedPassword);

		employeeDao.createEmployee(employee);
		emailService.sendCredentialEmail(employee, plainPassword);

		RedirectView redirectView = new RedirectView();
		redirectView.setUrl(request.getContextPath() + "/listofemployees");
		return redirectView;
	}

	// Update Employee Form
	@RequestMapping("/update/{employeeId}")
	public String updateForm(@PathVariable("employeeId") int eid, Model model) {
		Employee employee = this.employeeDao.getEmployee(eid);
		model.addAttribute("employee", employee);
		return "update_form";
	}

	// Handle Update Employee Form
	@RequestMapping(value = "/update-employee", method = RequestMethod.POST)
	public RedirectView updateEmployee(@Valid @ModelAttribute Employee employee, BindingResult result,
			HttpServletRequest request, RedirectAttributes redirectAttributes, Model model) {

		HttpSession session = request.getSession();

		String role = (String) session.getAttribute("role");
		Integer loggedInUserId = (Integer) session.getAttribute("id");

		if (role == null || loggedInUserId == null) {

			redirectAttributes.addFlashAttribute("error", "You need to log in first.");
			return new RedirectView(request.getContextPath() + "/login");
		}
		try {

			Employee existingEmployee = employeeDao.getEmployee(employee.getId());

			boolean emailExists = employeeDao.isEmailExists(employee.getEmailId())
					&& !employee.getEmailId().equals(existingEmployee.getEmailId());
			boolean mobileExists = employeeDao.isMobileNumberExists(employee.getEmpNumber())
					&& !employee.getEmpNumber().equals(existingEmployee.getEmpNumber());

			if (emailExists || mobileExists) {
				if (emailExists) {
					model.addAttribute("errorEmail", "This email is already in use.");
				}
				if (mobileExists) {
					model.addAttribute("errorMobile", "This mobile number is already in use.");
				}

				RedirectView redirectView = new RedirectView(request.getContextPath() + "/update/" + employee.getId());
				return redirectView;
			}

			if (result.hasErrors()) {
				redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.employee", result);
				redirectAttributes.addFlashAttribute("employee", employee);

				// Redirect back to the update page with the validation errors
				RedirectView redirectView = new RedirectView(request.getContextPath() + "/update/" + employee.getId());
				return redirectView;
			}

			employeeDao.updateEmployee(employee);

		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "The data was updated by another user. Please try again.");
			return new RedirectView(request.getContextPath() + "/error");
		}

		return new RedirectView(request.getContextPath() + "/listofemployees");
	}

	// handle active or inactive
	@PostMapping("/toggle-employee-status/{id}")
	public RedirectView toggleEmployeeStatus(@PathVariable("id") int employeeId, @RequestParam boolean status,
			HttpServletRequest request, RedirectAttributes redirectAttributes) {
		try {
			employeeDao.updateEmployeeStatus(employeeId, status);
			redirectAttributes.addFlashAttribute("message",
					status ? "Employee activated successfully" : "Employee deactivated successfully");
		} catch (RuntimeException e) {
			redirectAttributes.addFlashAttribute("error", e.getMessage());
		}
		return new RedirectView(request.getContextPath() + "/listofemployees");
	}

	// promote employee to admin
	@PostMapping("/promote-to-admin/{id}")
	public RedirectView promoteToAdmin(@PathVariable("id") int employeeId, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		try {
			Employee employee = employeeDao.getEmployee(employeeId);

			if (employee == null) {
				redirectAttributes.addFlashAttribute("error", "Employee not found");
				return new RedirectView(request.getContextPath() + "/listofemployees");
			}

			if (!employee.isActive()) {
				redirectAttributes.addFlashAttribute("error", "Cannot promote inactive employee to admin");
				return new RedirectView(request.getContextPath() + "/listofemployees");
			}

			if ("ADMIN".equals(employee.getRole())) {
				redirectAttributes.addFlashAttribute("error", "Employee is already an admin");
				return new RedirectView(request.getContextPath() + "/listofemployees");
			}

			employee.setRole("ADMIN");
			employeeDao.updateEmployee(employee);

			redirectAttributes.addFlashAttribute("message", "Employee successfully promoted to admin");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Failed to promote employee: " + e.getMessage());
		}

		return new RedirectView(request.getContextPath() + "/listofemployees");
	}

}
