package employeemanagement.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import employeemanagement.dao.EmployeeDao;

@Controller
public class ValidationController {

	@Autowired
	private EmployeeDao employeeDao;

	// validation
	@GetMapping("/checkEmail")
	public ResponseEntity<Map<String, Boolean>> checkEmail(@RequestParam String email) {
		boolean exists = employeeDao.isEmailExists(email);
		Map<String, Boolean> response = new HashMap<>();
		response.put("exists", exists);
		return ResponseEntity.ok(response);
	}

	@GetMapping("/checkMobile")
	@ResponseBody
	public Map<String, Boolean> checkMobile(@RequestParam String mobile) {
		boolean exists = employeeDao.isMobileNumberExists(mobile);
		return Collections.singletonMap("exists", exists);
	}

}
