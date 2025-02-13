package employeemanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import employeemanagement.dao.AttendanceDao;
import employeemanagement.dao.EmployeeDao;
import employeemanagement.dao.LeaveDao;
import employeemanagement.dto.AttendanceRecordDTO;
import employeemanagement.model.Attendance;
import employeemanagement.model.CalendarDay;
import employeemanagement.model.Employee;
import employeemanagement.model.Leave;
import employeemanagement.service.AttendanceReportService;
import employeemanagement.service.AttendanceService;
import employeemanagement.service.EmailService;
import employeemanagement.service.SalaryDeductionService;
import employeemanagement.service.SalaryDeductionService.SalaryCalculationResult;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Month;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	@Autowired
	private AttendanceService attendanceService;
	
	@Autowired
	private AttendanceDao attendanceDao;
	
	@Autowired
	private AttendanceReportService attendanceReportService;

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

				RedirectView redirectView = new RedirectView(request.getContextPath() + "/eupdate/" + employee.getId());
				return redirectView;
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
	       
	        SalaryCalculationResult salaryDetails = salaryDeductionService.calculateSalary(
	            leaves, 
	            employee.getSalary()
	        );
	        
	        model.addAttribute("employee", employee);
	        model.addAttribute("salaryDetails", salaryDetails);
	        return "employee-dashboard";
	}
	
	//Attendance
    @PostMapping("/check-in")
    @ResponseBody
    public Map<String, String> checkIn(HttpSession session) {
        Map<String, String> response = new HashMap<>();
        try {
            Integer employeeId = (Integer) session.getAttribute("id");
            if (employeeId == null) {
                response.put("status", "error");
                response.put("message", "Not logged in");
                return response;
            }
            
            attendanceService.checkIn(employeeId);
            response.put("status", "success");
            response.put("message", "Checked in successfully");
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", e.getMessage());
        }
        return response;
    }

    @PostMapping("/check-out")
    @ResponseBody
    public Map<String, String> checkOut(HttpSession session) {
        Map<String, String> response = new HashMap<>();
        try {
            Integer employeeId = (Integer) session.getAttribute("id");
            if (employeeId == null) {
                response.put("status", "error");
                response.put("message", "Not logged in");
                return response;
            }
            
            attendanceService.checkOut(employeeId);
            response.put("status", "success");
            response.put("message", "Checked out successfully");
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", e.getMessage());
        }
        return response;
    }


    @GetMapping("/attendance-status")
    @ResponseBody
    public Map<String, Object> getAttendanceStatus(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            Integer employeeId = (Integer) session.getAttribute("id");
            if (employeeId == null) {
                response.put("error", "Not logged in");
                return response;
            }

            Attendance attendance = attendanceDao.getTodayAttendance(employeeId);
            if (attendance != null && attendance.getCheckInTime() != null) {
                response.put("checkedIn", attendance.getCheckOutTime() == null);
                response.put("checkInTime", attendance.getCheckInTime().toString());

                if (attendance.getCheckOutTime() != null) {
                    response.put("checkOutTime", attendance.getCheckOutTime().toString());

                    LocalDateTime checkInTime = attendance.getCheckInTime();
                    LocalDateTime checkOutTime = attendance.getCheckOutTime();
                    Duration duration = Duration.between(checkInTime, checkOutTime);

                    long totalMinutes = duration.toMinutes();
                    long hours = totalMinutes / 60;
                    long minutes = totalMinutes % 60;

                    response.put("totalWorkingTime", hours + " hours " + minutes + " minutes");
                    response.put("hours", hours);
                    response.put("minutes", minutes);
                    response.put("completed", true);
                } else {
                    response.put("completed", false);
                }
            } else {
                response.put("checkedIn", false);
                response.put("completed", false);
            }
        } catch (Exception e) {
            response.put("error", e.getMessage());
            e.printStackTrace(); 
        }
        return response;
    }

    @GetMapping("/attendance/report/{employeeId}")
    public String getAttendanceReport(
            @PathVariable int employeeId,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
            Model model) {
        
        if (startDate == null || endDate == null) {
            YearMonth currentMonth = YearMonth.now();
            startDate = currentMonth.atDay(1);
            endDate = currentMonth.atEndOfMonth();
        }
        
        LocalDateTime startDateTime = startDate.atStartOfDay();
        LocalDateTime endDateTime = endDate.atTime(23, 59, 59);
        
        Employee employee = employeeDao.getEmployee(employeeId);
        AttendanceRecordDTO record = attendanceReportService.generateAttendanceReport(
            employeeId, startDateTime, endDateTime);
        
        model.addAttribute("employee", employee);
        model.addAttribute("record", record);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        
        return "attendance_report";
    }

    
    @GetMapping("/attendance/calender/{employeeId}")
    public String getAttendanceCalendar(
            @PathVariable int employeeId,
            @RequestParam(required = false) Integer month,
            @RequestParam(required = false) Integer year,
            Model model) {
        
        LocalDate today = LocalDate.now();
        month = month != null ? month : today.getMonthValue();
        year = year != null ? year : today.getYear();
        Employee employee = employeeDao.getEmployee(employeeId);
        
        List<List<CalendarDay>> calendarData = attendanceReportService.generateCalendarData(employeeId, month, year);
 
        List<Integer> yearRange = new ArrayList<>();
        for (int i = year - 2; i <= year + 2; i++) {
            yearRange.add(i);
        }
        
        model.addAttribute("employee", employee);
        model.addAttribute("calendarData", calendarData);
        model.addAttribute("currentMonth", month);
        model.addAttribute("currentYear", year);
        model.addAttribute("yearRange", yearRange);  
        model.addAttribute("monthYear", Month.of(month).toString() + " " + year);
        
        return "attendance_calendar";
    }
    
}