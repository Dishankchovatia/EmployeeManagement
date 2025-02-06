package employeemanagement.controller;

import employeemanagement.dao.LeaveDao;
import employeemanagement.dao.EmployeeDao;
import employeemanagement.model.Leave;
import employeemanagement.model.Employee;
import employeemanagement.model.LeaveStatus;
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
    @ResponseBody // Add this annotation
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
    

}
    
    
