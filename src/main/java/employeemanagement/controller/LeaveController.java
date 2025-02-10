package employeemanagement.controller;

import employeemanagement.dao.LeaveDao;
import employeemanagement.dao.EmployeeDao;
import employeemanagement.model.Leave;
import employeemanagement.model.Employee;
import employeemanagement.model.LeaveStatus;
import employeemanagement.service.SalaryDeductionService;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LeaveController {

    @Autowired
    private LeaveDao leaveDao;
    
    @Autowired
    private EmployeeDao employeeDao;
    
    @Autowired
    private SalaryDeductionService salaryDeductionService;
    
    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
    
    @GetMapping("/apply-leave")
    public String showLeaveForm(Model model) {
    	Leave leave = new Leave();
        leave.setStartDate(new Date());
        leave.setEndDate(new Date());
        model.addAttribute("leave", leave);
        return "apply_leave";
    }
    
    @PostMapping("/submit-leave")
    public String submitLeave(@Valid @ModelAttribute Leave leave, 
                            BindingResult result,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "apply_leave";
        }
        
        Integer employeeId = (Integer) session.getAttribute("id");
        Employee employee = employeeDao.getEmployee(employeeId);
        leave.setEmployee(employee);
        
        leaveDao.createLeave(leave);
        redirectAttributes.addFlashAttribute("message", "Leave application submitted successfully");
        
        return "redirect:/my-leaves";
    }
    
    @GetMapping("/my-leaves")
    public String myLeaves(Model model, HttpSession session) {
        Integer employeeId = (Integer) session.getAttribute("id");
        List<Leave> leaves = leaveDao.getEmployeeLeaves(employeeId);
        model.addAttribute("leaves", leaves);
        return "my_leaves";
    }
    
    @GetMapping("/admin/pending-leaves")
    public String pendingLeaves(Model model) {
        List<Leave> pendingLeaves = leaveDao.getPendingLeaves();
        model.addAttribute("leaves", pendingLeaves);
        return "admin_pending_leaves";
    }
    
    @PostMapping("/admin/process-leave/{id}")
    @ResponseBody 
    public Map<String, String> processLeave(
            @PathVariable int id,
            @RequestParam LeaveStatus status,
            @RequestParam String remarks,
            RedirectAttributes redirectAttributes) {
        
        Map<String, String> response = new HashMap<>();
        
        try {
            Leave leave = leaveDao.getLeave(id);
            if (leave != null) {
                leave.setStatus(status);
                leave.setAdminRemarks(remarks);
                leaveDao.updateLeave(leave);
                
                response.put("status", "success");
                response.put("message", "Leave " + status.toString().toLowerCase() + " successfully");
            } else {
                response.put("status", "error");
                response.put("message", "Leave request not found");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Error processing leave request: " + e.getMessage());
        }
        
        return response;
    }
    
    @GetMapping("/admin/leave-report")
    public String showLeaveReportForm(Model model) {
        List<Employee> employees = employeeDao.getEmployees();
        model.addAttribute("employees", employees);
        return "admin/leave_report_form";
    }

    @GetMapping("/admin/generate-leave-report")
    public String generateLeaveReport(
            @RequestParam("employeeId") int employeeId,
            @RequestParam(value = "startDate", required = false) Date startDate,
            @RequestParam(value = "endDate", required = false) Date endDate,
            Model model) {
        
        Employee employee = employeeDao.getEmployee(employeeId);
        if (employee == null) {
            return "redirect:/admin/leave-report";
        }

        List<Leave> leaves;
        if (startDate != null && endDate != null) {
            leaves = leaveDao.getEmployeeLeavesByDateRange(employeeId, startDate, endDate);
        } else {
            leaves = leaveDao.getEmployeeLeaves(employeeId);
        }

        int approvedLeaves = 0;
        int rejectedLeaves = 0;
        int pendingLeaves = 0;
        int totalDays = 0;

        for (Leave leave : leaves) {
            switch (leave.getStatus()) {
                case APPROVED:
                    approvedLeaves++;
                    break;
                case REJECTED:
                    rejectedLeaves++;
                    break;
                case PENDING:
                    pendingLeaves++;
                    break;
            }
          
            long diff = leave.getEndDate().getTime() - leave.getStartDate().getTime();
            totalDays += (diff / (1000 * 60 * 60 * 24)) + 1;
        }

        model.addAttribute("employee", employee);
        model.addAttribute("leaves", leaves);
        model.addAttribute("approvedLeaves", approvedLeaves);
        model.addAttribute("rejectedLeaves", rejectedLeaves);
        model.addAttribute("pendingLeaves", pendingLeaves);
        model.addAttribute("totalDays", totalDays);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        
        return "admin/leave_report";
    }
    
    

}
    
    
