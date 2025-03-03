package employeemanagement.service;

import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import employeemanagement.dao.AttendanceDao;
import employeemanagement.dao.LeaveDao;
import employeemanagement.dto.AttendanceRecordDTO;
import employeemanagement.model.Attendance;
import employeemanagement.model.CalendarDay;
import employeemanagement.model.Leave;

@Service
public class AttendanceReportService {

	@Autowired
	private AttendanceDao attendanceDao;

	@Autowired
	private LeaveDao leaveDao;

	private static final LocalTime LATE_ARRIVAL_TIME = LocalTime.of(10, 30); // 10:30 AM
	private static final LocalTime EARLY_DEPARTURE_TIME = LocalTime.of(19, 0); // 7:00 PM

	public AttendanceRecordDTO generateAttendanceReport(int employeeId, LocalDateTime startDate,
			LocalDateTime endDate) {
		List<Attendance> attendances = attendanceDao.getAttendanceByEmployeeAndDateRange(employeeId, startDate,
				endDate);
		List<Leave> leaves = leaveDao.getEmployeeLeavesByDate(employeeId,
				java.util.Date.from(startDate.atZone(java.time.ZoneId.systemDefault()).toInstant()),
				java.util.Date.from(endDate.atZone(java.time.ZoneId.systemDefault()).toInstant()));

		AttendanceRecordDTO record = new AttendanceRecordDTO();

		int totalDays = calculateWorkingDays(startDate, endDate);
		record.setTotalDays(totalDays);

		record.setPresentDays(attendances.size());

		int leaveDays = calculateLeaveDays(leaves);
		record.setLeaveDays(leaveDays);

		record.setAbsentDays(Math.max(0, totalDays - record.getPresentDays() - leaveDays));

		double totalHours = 0;
		int lateArrivals = 0;
		int earlyDepartures = 0;

		for (Attendance attendance : attendances) {
			if (attendance.getTotalHours() != null) {
				totalHours += attendance.getTotalHours();
			}

			if (attendance.getFirstCheckIn() != null
					&& attendance.getFirstCheckIn().toLocalTime().isAfter(LATE_ARRIVAL_TIME)) {
				lateArrivals++;
			}

			if (attendance.getCheckOutTime() != null
					&& attendance.getCheckOutTime().toLocalTime().isBefore(EARLY_DEPARTURE_TIME)) {
				earlyDepartures++;
			}
		}

		record.setTotalWorkingHours(totalHours);
		record.setAverageWorkingHours(record.getPresentDays() > 0 ? totalHours / record.getPresentDays() : 0);
		record.setLateArrivals(lateArrivals);
		record.setEarlyDepartures(earlyDepartures);

		return record;
	}

	private int calculateWorkingDays(LocalDateTime startDate, LocalDateTime endDate) {
		int totalDays = 0;
		LocalDateTime current = startDate;

		while (!current.isAfter(endDate)) {
			if (current.getDayOfWeek().getValue() < 7) {
				totalDays++;
			}
			current = current.plusDays(1);
		}

		return totalDays;
	}

	private int calculateLeaveDays(List<Leave> leaves) {
		int totalLeaveDays = 0;
		for (Leave leave : leaves) {
			LocalDateTime startDate = LocalDateTime.ofInstant(Instant.ofEpochMilli(leave.getStartDate().getTime()),
					ZoneId.systemDefault());

			LocalDateTime endDate = LocalDateTime.ofInstant(Instant.ofEpochMilli(leave.getEndDate().getTime()),
					ZoneId.systemDefault());
			totalLeaveDays += calculateWorkingDays(startDate, endDate);
		}
		return totalLeaveDays;
	}

	public List<List<CalendarDay>> generateCalendarData(int employeeId, int month, int year) {
	    LocalDate firstDayOfMonth = LocalDate.of(year, month, 1);
	    LocalDate lastDayOfMonth = firstDayOfMonth.withDayOfMonth(firstDayOfMonth.lengthOfMonth());
	    
	    List<Attendance> attendances = attendanceDao.getAttendanceByEmployeeAndDateRange(employeeId,
	            firstDayOfMonth.atStartOfDay(), lastDayOfMonth.atTime(23, 59, 59));
	    List<Leave> leaves = leaveDao.getEmployeeLeavesByDate(employeeId,
	            java.util.Date.from(firstDayOfMonth.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant()),
	            java.util.Date.from(lastDayOfMonth.atTime(23, 59, 59).atZone(ZoneId.systemDefault()).toInstant()));

	    List<List<CalendarDay>> calendar = new ArrayList<>();
	    
	    LocalDate currentDate = firstDayOfMonth.minusDays(firstDayOfMonth.getDayOfWeek().getValue() - 1);
	    
	    LocalDate lastCalendarDay = lastDayOfMonth.plusDays(7L - lastDayOfMonth.getDayOfWeek().getValue());
	    
	    if (ChronoUnit.DAYS.between(currentDate, lastCalendarDay) > 50) {
	        throw new IllegalStateException("Calendar period exceeds maximum allowed days");
	    }

	    while (!currentDate.isAfter(lastCalendarDay)) {
	        List<CalendarDay> week = new ArrayList<>(7); 
	        
	        for (int i = 0; i < 7; i++) {
	            CalendarDay day = new CalendarDay();
	            day.setDate(currentDate.getDayOfMonth());
	            day.setOutsideMonth(currentDate.getMonth() != firstDayOfMonth.getMonth());
	            
	            if (!day.isOutsideMonth()) {
	                if (currentDate.getDayOfWeek() == DayOfWeek.SUNDAY) {
	                    day.setStatus("");
	                } else {
	                    setDayStatus(day, currentDate, attendances, leaves);
	                }
	            }
	            
	            week.add(day);
	            currentDate = currentDate.plusDays(1);
	        }
	        
	        calendar.add(week);
	    }
	    
	    return calendar;
	}

	private void setDayStatus(CalendarDay day, LocalDate date, List<Attendance> attendances, List<Leave> leaves) {
	    boolean isPresent = attendances.stream()
	            .anyMatch(a -> a.getDate().toLocalDate().equals(date));
	    boolean isOnLeave = leaves.stream()
	            .anyMatch(l -> isDateInRange(date, l.getStartDate(), l.getEndDate()));
	    
	    if (isPresent) {
	        day.setStatus("Present");
	    } else if (isOnLeave) {
	        day.setStatus("Leave");
	    } else {
	        day.setStatus(!date.isAfter(LocalDate.now()) ? "Absent" : "");
	    }
	}
	private boolean isDateInRange(LocalDate date, Date startDate, Date endDate) {
		LocalDate start = new java.sql.Date(startDate.getTime()).toLocalDate();
		LocalDate end = new java.sql.Date(endDate.getTime()).toLocalDate();
		return !date.isBefore(start) && !date.isAfter(end);
	}

}