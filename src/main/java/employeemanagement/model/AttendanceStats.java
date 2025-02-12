package employeemanagement.model;

import java.time.LocalDate;
import java.util.List;

public class AttendanceStats {
    private int totalEmployees;
    private int presentEmployees;
    private int absentEmployees;
    private int onLeaveEmployees;
    private List<Attendance> attendanceList;
    private List<Leave> leavesForToday;
    private LocalDate date;

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public int getTotalEmployees() {
        return totalEmployees;
    }

    public void setTotalEmployees(int totalEmployees) {
        this.totalEmployees = totalEmployees;
    }

    public int getPresentEmployees() {
        return presentEmployees;
    }

    public void setPresentEmployees(int presentEmployees) {
        this.presentEmployees = presentEmployees;
    }

    public int getAbsentEmployees() {
        return absentEmployees;
    }

    public void setAbsentEmployees(int absentEmployees) {
        this.absentEmployees = absentEmployees;
    }

    public int getOnLeaveEmployees() {
        return onLeaveEmployees;
    }

    public void setOnLeaveEmployees(int onLeaveEmployees) {
        this.onLeaveEmployees = onLeaveEmployees;
    }

    public List<Attendance> getAttendanceList() {
        return attendanceList;
    }

    public void setAttendanceList(List<Attendance> attendanceList) {
        this.attendanceList = attendanceList;
    }

    public List<Leave> getLeavesForToday() {
        return leavesForToday;
    }

    public void setLeavesForToday(List<Leave> leavesForToday) {
        this.leavesForToday = leavesForToday;
    }
}