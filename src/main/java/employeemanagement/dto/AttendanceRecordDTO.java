package employeemanagement.dto;

public class AttendanceRecordDTO {
    private int totalDays;
    private int presentDays;
    private int absentDays;
    private int leaveDays;
    private double averageWorkingHours;
    private double totalWorkingHours;
    private int lateArrivals;
    private int earlyDepartures;
    
    public int getTotalDays() {
        return totalDays;
    }

    public void setTotalDays(int totalDays) {
        this.totalDays = totalDays;
    }

    public int getPresentDays() {
        return presentDays;
    }

    public void setPresentDays(int presentDays) {
        this.presentDays = presentDays;
    }

    public int getAbsentDays() {
        return absentDays;
    }

    public void setAbsentDays(int absentDays) {
        this.absentDays = absentDays;
    }

    public int getLeaveDays() {
        return leaveDays;
    }

    public void setLeaveDays(int leaveDays) {
        this.leaveDays = leaveDays;
    }

    public double getAverageWorkingHours() {
        return averageWorkingHours;
    }

    public void setAverageWorkingHours(double averageWorkingHours) {
        this.averageWorkingHours = averageWorkingHours;
    }

    public double getTotalWorkingHours() {
        return totalWorkingHours;
    }

    public void setTotalWorkingHours(double totalWorkingHours) {
        this.totalWorkingHours = totalWorkingHours;
    }

    public int getLateArrivals() {
        return lateArrivals;
    }

    public void setLateArrivals(int lateArrivals) {
        this.lateArrivals = lateArrivals;
    }

    public int getEarlyDepartures() {
        return earlyDepartures;
    }

    public void setEarlyDepartures(int earlyDepartures) {
        this.earlyDepartures = earlyDepartures;
    }
}