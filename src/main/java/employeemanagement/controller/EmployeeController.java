package employeemanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;
import employeemanagement.dao.EmployeeDao;
import employeemanagement.model.Admin;
import employeemanagement.model.Employee;
import employeemanagement.service.EmailService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
public class EmployeeController {

	@Autowired
	private EmployeeDao employeeDao;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private EmailService emailService;

	// signup Form
	@RequestMapping("/signup")
	public String addEmployee(Model m) {
		m.addAttribute("title", "Add Employee");
		return "employee-signup";
	}

	// login form
	@RequestMapping("/signin")
	public String signinForm() {
		return "employee-signin";
	}

	// handle signin
	@PostMapping("/handle-signin")
	public RedirectView handleEmployeeLogin(@RequestParam String emailId, @RequestParam String password,
			HttpServletRequest request, RedirectAttributes redirectAttributes) {
		Employee employee = employeeDao.findEmployeeByEmail(emailId);
		StringBuilder errorParam = new StringBuilder();

		if (employee != null && passwordEncoder.matches(password, employee.getPassword())) {
			if (!employee.isActive()) {
				errorParam.append("deactivated,");
			} else {
				HttpSession session = request.getSession();
				session.setAttribute("id", employee.getId());
			}
		} else {
			errorParam.append("invalid,");
		}

		if (errorParam.length() > 0) {
			String errorValue = errorParam.substring(0, errorParam.length() - 1);
			return new RedirectView(request.getContextPath() + "/signin?error=" + errorValue);
		}
		return new RedirectView(request.getContextPath() + "/show/" + employee.getId());
	}

	// dashboard
	@GetMapping("/employee-dashboard")
	public String employeeDashboard(@ModelAttribute("employee") Employee employee, Model model) {
		model.addAttribute("employee", employee);
		return "employee-dashboard";
	}
	
	@RequestMapping("/show/{eid}")
	public String showDashboare(@PathVariable("eid") int eid, Model model) {
		Employee employee = this.employeeDao.getEmployee(eid);
		model.addAttribute("employee", employee);
		return "employee-dashboard";
	}


	// handle signup
	@RequestMapping(value = "/signup-employee", method = RequestMethod.POST)
	public RedirectView handleEmployee(@Valid @ModelAttribute Employee employee, BindingResult result,
			HttpServletRequest request, RedirectAttributes redirectAttributes, Model model) {

		boolean emailExists = employeeDao.isEmailExists(employee.getEmailId());
		boolean mobileExists = employeeDao.isMobileNumberExists(employee.getEmpNumber());

		if (emailExists || mobileExists) {
			model.addAttribute("errorEmail", emailExists ? "This email is already in use." : null);
			model.addAttribute("errorMobile", mobileExists ? "This mobile number is already in use." : null);
			return new RedirectView("employee-signup");
		}

		if (result.hasErrors()) {
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.employee", result);
			redirectAttributes.addFlashAttribute("employee", employee);
			return new RedirectView("employee-signup");
		}

		String plainPassword = employee.getPassword();
		String encryptedPassword = passwordEncoder.encode(employee.getPassword());
		employee.setPassword(encryptedPassword);
		
		HttpSession session = request.getSession();
		session.setAttribute("id", employee.getId());
		
		employeeDao.createEmployee(employee);
		emailService.sendCredentialEmail(employee, plainPassword);

		redirectAttributes.addFlashAttribute("employee", employee);
		RedirectView redirectView = new RedirectView();
		redirectView.setUrl(request.getContextPath() + "/show/" + employee.getId());
		return redirectView;
	}

	// Update Employee Form
	@RequestMapping("/show/eupdate/{employeeId}")
	public String updateForm(@PathVariable("employeeId") int eid, Model model) {
		Employee employee = this.employeeDao.getEmployee(eid);
		model.addAttribute("employee", employee);
		return "eupdate_form";
	}

	// Handle Update Employee Form
	@RequestMapping(value = "/eupdate-employee", method = RequestMethod.POST)
	public RedirectView updateEmployee(@Valid @ModelAttribute Employee employee, BindingResult result,
			HttpServletRequest request, RedirectAttributes redirectAttributes, Model model) {
		int eid = employee.getId();
		Employee existingEmployee = employeeDao.getEmployee(eid);

		boolean emailExists = employeeDao.isEmailExists(employee.getEmailId())
				&& !employee.getEmailId().equals(existingEmployee.getEmailId());
		boolean mobileExists = employeeDao.isMobileNumberExists(employee.getEmpNumber())
				&& !employee.getEmpNumber().equals(existingEmployee.getEmpNumber());

		if (emailExists || mobileExists) {
			redirectAttributes.addFlashAttribute("errorEmail", "This email is already in use.");
			redirectAttributes.addFlashAttribute("errorMobile", "This mobile number is already in use.");
			return new RedirectView(request.getContextPath() + "/eupdate/" + employee.getId());

		}
		if (result.hasErrors()) {
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.employee", result);
			redirectAttributes.addFlashAttribute("employee", employee);

			RedirectView redirectView = new RedirectView(request.getContextPath() + "/eupdate/" + employee.getId());
			return redirectView;
		}
		employeeDao.updateEmployee(employee);
		redirectAttributes.addFlashAttribute("successMessage", "Employee updated successfully.");

		return new RedirectView(request.getContextPath() + "/show/" + eid);

	}

	// logout
	@GetMapping("/employee-logout")
	public RedirectView employeeLogout(HttpServletRequest request) {
		// Invalidate the session
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		return new RedirectView(request.getContextPath() + "/signin?logout=true");
	}

}