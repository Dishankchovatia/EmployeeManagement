package employeemanagement.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import employeemanagement.dao.EmployeeDao;
import employeemanagement.model.Employee;

@Controller
public class PaginationAndSearchController {

	@Autowired
	private EmployeeDao employeeDao;

	// Search API and Pagination
	@RequestMapping("/listofemployees")
	public String home(Model model, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "5") int size, @RequestParam(required = false) String searchName) {

		int offset = (page - 1) * size;
		List<Employee> employees;
		long totalEmployees;
		int totalPages;

		if (searchName != null && !searchName.isEmpty()) {
			employees = employeeDao.searchEmployeesByName(searchName, offset, size);
			totalEmployees = employeeDao.getSearchEmployeesCount(searchName);
		} else {
			employees = employeeDao.getPaginatedEmployees(offset, size);
			totalEmployees = employeeDao.getTotalEmployeesCount();
		}

		totalPages = (int) Math.ceil((double) totalEmployees / size);

		model.addAttribute("employees", employees);
		model.addAttribute("size", size);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("totalEmployees", totalEmployees);
		model.addAttribute("searchName", searchName);

		return "listofemployees";
	}

}
