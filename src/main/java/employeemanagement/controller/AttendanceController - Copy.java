package employeemanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import employeemanagement.dao.AttendanceDao;
import employeemanagement.dao.EmployeeDao;
import employeemanagement.model.Attendance;
import employeemanagement.model.Employee;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {

    @Autowired
    private AttendanceDao attendanceDao;

    @Autowired
    private EmployeeDao employeeDao;

    @GetMapping("/mark")
    public String showAttendanceForm(Model model) {
        List<Employee> employees = employeeDao.getEmployees();
        model.addAttribute("employees", employees);
        return "mark-attendance";
    }

    @PostMapping("/mark")
    public String markAttendance(@RequestParam("employeeId") int employeeId,
                               @RequestParam("status") String status,
                               @RequestParam(value = "remarks", required = false) String remarks,
                               RedirectAttributes redirectAttributes) {
        try {
            Employee employee = employeeDao.getEmployee(employeeId);
            Attendance attendance = new Attendance();
            attendance.setEmployee(employee);
            attendance.setCheckIn(LocalDateTime.now());
            attendance.setStatus(status);
            attendance.setRemarks(remarks);
            
            if ("PRESENT".equals(status)) {
                attendance.setCheckOut(LocalDateTime.now().plusHours(9)); // Assuming 9-hour workday
                attendance.setHoursWorked(9.0);
            }
            
            attendanceDao.saveAttendance(attendance);
            redirectAttributes.addFlashAttribute("message", "Attendance marked successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to mark attendance: " + e.getMessage());
        }
        return "redirect:/attendance/mark";
    }

    @GetMapping("/report")
    public String showAttendanceReport(
            @RequestParam(required = false) Integer employeeId,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Model model) {
        
        if (employeeId != null && startDate != null && endDate != null) {
            List<Attendance> attendanceList = attendanceDao.getAttendanceByEmployeeAndDateRange(employeeId, startDate, endDate);
            Double totalHours = attendanceDao.getTotalHoursWorked(employeeId, startDate, endDate);
            
            model.addAttribute("attendanceList", attendanceList);
            model.addAttribute("totalHours", totalHours);
            model.addAttribute("employee", employeeDao.getEmployee(employeeId));
        }
        
        model.addAttribute("employees", employeeDao.getEmployees());
        return "attendance-report";
    }

    @GetMapping("/daily")
    public String showDailyAttendance(Model model) {
        LocalDateTime today = LocalDateTime.now();
        List<Attendance> dailyAttendance = attendanceDao.getDailyAttendance(today);
        long presentCount = attendanceDao.getPresentEmployeesCount(today);

        // Prepare maps for converted Date values (using attendance id as key)
        Map<Integer, Date> formattedCheckInMap = new HashMap<>();
        Map<Integer, Date> formattedCheckOutMap = new HashMap<>();

        for (Attendance attendance : dailyAttendance) {
            if (attendance.getCheckIn() != null) {
                Date checkInDate = Date.from(attendance.getCheckIn().atZone(ZoneId.systemDefault()).toInstant());
                formattedCheckInMap.put(attendance.getId(), checkInDate);
            }
            if (attendance.getCheckOut() != null) {
                Date checkOutDate = Date.from(attendance.getCheckOut().atZone(ZoneId.systemDefault()).toInstant());
                formattedCheckOutMap.put(attendance.getId(), checkOutDate);
            }
        }

        model.addAttribute("dailyAttendance", dailyAttendance);
        model.addAttribute("formattedCheckInMap", formattedCheckInMap);
        model.addAttribute("formattedCheckOutMap", formattedCheckOutMap);
        model.addAttribute("presentCount", presentCount);
        model.addAttribute("totalEmployees", employeeDao.getTotalEmployeesCount());
        return "daily-attendance";
    }
}