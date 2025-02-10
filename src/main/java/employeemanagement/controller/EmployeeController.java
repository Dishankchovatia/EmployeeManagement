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
import employeemanagement.dao.LeaveDao;
import employeemanagement.model.Employee;
import employeemanagement.model.Leave;
import employeemanagement.service.EmailService;
import employeemanagement.service.SalaryDeductionService;
import employeemanagement.service.SalaryDeductionService.SalaryCalculationResult;

import java.util.List;

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
	
	@Autowired
	private LeaveDao leaveDao;
	
	@Autowired
	private SalaryDeductionService salaryDeductionService;

	@RequestMapping(value = "/eupdate-employee", method = RequestMethod.POST)
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
			if (existingEmployee != null) {
				employee.setVersion(existingEmployee.getVersion());
			}

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

				return new RedirectView(request.getContextPath() + "/eupdate/" + employee.getId());
			}

			if (result.hasErrors()) {
				redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.employee", result);
				redirectAttributes.addFlashAttribute("employee", employee);
				return new RedirectView(request.getContextPath() + "/eupdate/" + employee.getId());
			}

			employeeDao.updateEmployee(employee);

		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "The data was updated by another user. Please try again.");
			return new RedirectView(request.getContextPath() + "/error");
		}
		return new RedirectView(request.getContextPath() + "/" + loggedInUserId);
	}

	@RequestMapping("/eupdate/{employeeId}")
	public String updateForm(@PathVariable("employeeId") int eid, Model model) {
		Employee employee = this.employeeDao.getEmployee(eid);
		model.addAttribute("employee", employee);
		return "eupdate_form";
	}

	// dashboard
	@RequestMapping("/{employeeId}")
	public String showDashboare(@PathVariable("employeeId") int employeeId, Model model,HttpSession session) {
		 Integer employeId = (Integer) session.getAttribute("id");
	        Employee employee = employeeDao.getEmployee(employeeId);
	        List<Leave> leaves = leaveDao.getEmployeeLeaves(employeeId);
	        
	        // Calculate salary details
	        SalaryCalculationResult salaryDetails = salaryDeductionService.calculateSalary(
	            leaves, 
	            employee.getSalary()
	        );
	        
	        model.addAttribute("employee", employee);
	        model.addAttribute("salaryDetails", salaryDetails);
	        return "employee-dashboard";
	}
}