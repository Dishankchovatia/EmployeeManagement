package employeemanagement.model;

import java.util.List;

public class AttendanceStats {
    private int totalEmployees;
    private int presentEmployees;
    private int absentEmployees;
    private List<Attendance> attendanceList;

    // Getters and setters
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

    public List<Attendance> getAttendanceList() {
        return attendanceList;
    }

    public void setAttendanceList(List<Attendance> attendanceList) {
        this.attendanceList = attendanceList;
    }
}