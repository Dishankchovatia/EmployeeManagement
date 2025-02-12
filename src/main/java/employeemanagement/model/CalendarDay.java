package employeemanagement.model;

public class CalendarDay {

	private int date;
	private String status;
	private boolean outsideMonth;
	
	
	public int getDate() {
		return date;
	}
	public void setDate(int date) {
		this.date = date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public boolean isOutsideMonth() {
		return outsideMonth;
	}
	public void setOutsideMonth(boolean outsideMonth) {
		this.outsideMonth = outsideMonth;
	}

}
