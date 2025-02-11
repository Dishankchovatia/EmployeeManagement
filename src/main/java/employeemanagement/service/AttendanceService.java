package employeemanagement.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import employeemanagement.dao.AttendanceDao;
import employeemanagement.dao.EmployeeDao;
import employeemanagement.model.Attendance;
import employeemanagement.model.AttendanceStats;
import employeemanagement.model.Employee;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class AttendanceService {

    @Autowired
    private AttendanceDao attendanceDao;

    @Autowired
    private EmployeeDao employeeDao;

    public void checkIn(int employeeId) {
        Employee employee = employeeDao.getEmployee(employeeId);
        Attendance attendance = attendanceDao.getTodayAttendance(employeeId);
        
        if (attendance == null) {
            attendance = new Attendance();
            attendance.setEmployee(employee);
            attendance.setDate(LocalDateTime.now());
            attendance.setCheckInTime(LocalDateTime.now());
            attendanceDao.saveAttendance(attendance);
        }
    }

    public void checkOut(int employeeId) {
        Attendance attendance = attendanceDao.getTodayAttendance(employeeId);
        if (attendance != null && attendance.getCheckOutTime() == null) {
            attendance.setCheckOutTime(LocalDateTime.now());
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