package employeemanagement.service;

import employeemanagement.model.Leave;
import employeemanagement.model.LeaveStatus;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAdjusters;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class SalaryDeductionService {

	private static final BigDecimal DEDUCTION_RATE = new BigDecimal("0.40"); 
	private static final BigDecimal DAYS_IN_MONTH = new BigDecimal("30");

	public SalaryCalculationResult calculateSalary(List<Leave> leaves, BigDecimal salary) {

		LocalDate now = LocalDate.now();
		LocalDate firstDayOfMonth = now.with(TemporalAdjusters.firstDayOfMonth());
		LocalDate lastDayOfMonth = now.with(TemporalAdjusters.lastDayOfMonth());

		List<Leave> currentMonthLeaves = leaves.stream().filter(leave -> leave.getStatus() == LeaveStatus.APPROVED)
				.filter(leave -> {
					LocalDate leaveStart = new java.sql.Date(leave.getStartDate().getTime()).toLocalDate();
					LocalDate leaveEnd = new java.sql.Date(leave.getEndDate().getTime()).toLocalDate();
					return !leaveEnd.isBefore(firstDayOfMonth) && !leaveStart.isAfter(lastDayOfMonth);
				}).collect(Collectors.toList());

		long lopDays = currentMonthLeaves.stream().filter(leave -> "Loss of Pay".equalsIgnoreCase(leave.getLeaveType()))
				.mapToLong(leave -> calculateOverlappingDays(leave, firstDayOfMonth, lastDayOfMonth)).sum();

		long nonLopDays = currentMonthLeaves.stream()
				.filter(leave -> !"Loss of Pay".equalsIgnoreCase(leave.getLeaveType()))
				.mapToLong(leave -> calculateOverlappingDays(leave, firstDayOfMonth, lastDayOfMonth)).sum();

		BigDecimal dailySalary = salary.divide(DAYS_IN_MONTH, 2, RoundingMode.HALF_UP);

		BigDecimal lopDeduction = dailySalary.multiply(BigDecimal.valueOf(lopDays)).setScale(2, RoundingMode.HALF_UP);

		BigDecimal nonLopDeduction = BigDecimal.ZERO;
		if (nonLopDays > 2) {
			long excessDays = nonLopDays - 2;
			nonLopDeduction = dailySalary.multiply(BigDecimal.valueOf(excessDays)).multiply(DEDUCTION_RATE).setScale(2,
					RoundingMode.HALF_UP);
		}

		BigDecimal totalDeduction = lopDeduction.add(nonLopDeduction);

		BigDecimal finalSalary = salary.subtract(totalDeduction);

		return new SalaryCalculationResult(salary, lopDays, nonLopDays, totalDeduction, finalSalary);
	}

	private long calculateOverlappingDays(Leave leave, LocalDate firstDayOfMonth, LocalDate lastDayOfMonth) {

		LocalDate leaveStart = new java.sql.Date(leave.getStartDate().getTime()).toLocalDate();
		LocalDate leaveEnd = new java.sql.Date(leave.getEndDate().getTime()).toLocalDate();

		LocalDate effectiveStart = leaveStart.isBefore(firstDayOfMonth) ? firstDayOfMonth : leaveStart;
		LocalDate effectiveEnd = leaveEnd.isAfter(lastDayOfMonth) ? lastDayOfMonth : leaveEnd;

		long daysBetween = ChronoUnit.DAYS.between(effectiveStart, effectiveEnd) + 1;
		return daysBetween > 0 ? daysBetween : 0;
	}

	public class SalaryCalculationResult {
		private final BigDecimal baseSalary;
		private final long lopDays;
		private final long nonLopDays;
		private final BigDecimal deduction;
		private final BigDecimal finalSalary;

		public SalaryCalculationResult(BigDecimal baseSalary, long lopDays, long nonLopDays, BigDecimal deduction,
				BigDecimal finalSalary) {
			this.baseSalary = baseSalary;
			this.lopDays = lopDays;
			this.nonLopDays = nonLopDays;
			this.deduction = deduction;
			this.finalSalary = finalSalary;
		}

		public BigDecimal getBaseSalary() {
			return baseSalary;
		}

		public long getLopDays() {
			return lopDays;
		}

		public long getNonLopDays() {
			return nonLopDays;
		}

		public BigDecimal getDeduction() {
			return deduction;
		}

		public BigDecimal getFinalSalary() {
			return finalSalary;
		}
	}
}
