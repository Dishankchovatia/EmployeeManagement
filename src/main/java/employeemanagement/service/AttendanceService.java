package employeemanagement.service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import employeemanagement.dao.AttendanceDao;
import employeemanagement.dao.EmployeeDao;
import employeemanagement.model.Attendance;
import employeemanagement.model.AttendanceStats;
import employeemanagement.model.Employee;

@Service
public class AttendanceService {

    @Autowired
    private AttendanceDao attendanceDao;

    @Autowired
    private EmployeeDao employeeDao;

    public void checkIn(int employeeId) {
        Employee employee = employeeDao.getEmployee(employeeId);
        Attendance attendance = attendanceDao.getTodayAttendance(employeeId);
        LocalDateTime now = LocalDateTime.now();
        
        if (attendance == null) {
            attendance = new Attendance();
            attendance.setEmployee(employee);
            attendance.setDate(now);
            attendance.setCheckInTime(now);
            attendance.setFirstCheckIn(now); 
            attendance.setTotalHours(0.0);
            attendanceDao.saveAttendance(attendance);
        } else if (attendance.getCheckOutTime() != null) {
            attendance.setCheckInTime(now);
            attendance.setCheckOutTime(null);
            attendanceDao.updateAttendance(attendance);
        }
    }
    
    public void checkOut(int employeeId) {
        Attendance attendance = attendanceDao.getTodayAttendance(employeeId);
        if (attendance != null && attendance.getCheckOutTime() == null) {
            LocalDateTime now = LocalDateTime.now();
            attendance.setCheckOutTime(now);
            
            Duration currentSession = Duration.between(attendance.getCheckInTime(), now);
            double currentHours = currentSession.toMinutes() / 60.0;
            
            double totalHours = (attendance.getTotalHours() != null ? attendance.getTotalHours() : 0.0) + currentHours;
            attendance.setTotalHours(totalHours);
            attendanceDao.updateAttendance(attendance);
        }
    }


    public AttendanceStats getAttendanceStats() {
        return getAttendanceStatsByDate(LocalDate.now());
    }

    public AttendanceStats getAttendanceStatsByDate(LocalDate date) {
        List<Employee> allEmployees = employeeDao.getEmployees();
        List<Attendance> dateAttendance = attendanceDao.getAttendanceByDate(date);
        
        AttendanceStats stats = new AttendanceStats();
        stats.setTotalEmployees(allEmployees.size());
        stats.setPresentEmployees(dateAttendance.size());
        stats.setAbsentEmployees(allEmployees.size() - dateAttendance.size());
        stats.setAttendanceList(dateAttendance);
        stats.setDate(date);
        
        return stats;
    }
}