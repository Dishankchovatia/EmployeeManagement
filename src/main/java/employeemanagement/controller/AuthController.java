package employeemanagement.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import employeemanagement.dao.EmployeeDao;
import employeemanagement.model.Employee;

@Controller
public class AuthController {
	
	@Autowired
	private EmployeeDao employeeDao;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@GetMapping("/login")
	public String showLoginPage() {
		System.out.println(passwordEncoder.encode("#EMP001"));
		return "login";
	}

	@PostMapping("/handle-login")
	public RedirectView handleLogin(@RequestParam String userId, @RequestParam String password,
			HttpServletRequest request, RedirectAttributes redirectAttributes) {

		HttpSession session = request.getSession();

		Employee employee = employeeDao.findEmployeeByEmployeeId(userId);
		if (employee == null) {
			employee = employeeDao.findEmployeeByEmail(userId);
		}

		if (employee != null && passwordEncoder.matches(password, employee.getPassword())) {
			if (!employee.isActive()) {
				redirectAttributes.addFlashAttribute("error", "Your account is deactivated");
				return new RedirectView(request.getContextPath() + "/login?error=deactivated");
			}

			session.setAttribute("id", employee.getId());
			session.setAttribute("userId", employee.getEmployeeId());
			session.setAttribute("name", employee.getEmpName());
			session.setAttribute("role", employee.getRole());

			if ("ADMIN".equals(employee.getRole())) {
				return new RedirectView(request.getContextPath() + "/dashboard");
			} else {
				return new RedirectView(request.getContextPath() + "/" + employee.getId());
			}
		}

		redirectAttributes.addFlashAttribute("error", "Invalid credentials");
		return new RedirectView(request.getContextPath() + "/login?error=invalid");
	}

	@GetMapping("/logout")
	public RedirectView logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		return new RedirectView(request.getContextPath() + "/login?logout=true");
	}
}