package employeemanagement.dao;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import employeemanagement.model.Attendance;

@Repository
public class AttendanceDao {

	@Autowired
	private HibernateTemplate hibernateTemplate;

	@Transactional
	public void saveAttendance(Attendance attendance) {
		this.hibernateTemplate.save(attendance);
	}

	@Transactional
	public void updateAttendance(Attendance attendance) {
		this.hibernateTemplate.update(attendance);
	}

	public Attendance getAttendanceByDateAndEmployee(LocalDate date, int employeeId) {
		return hibernateTemplate.execute(session -> {
			LocalDateTime startOfDay = date.atStartOfDay();
			LocalDateTime endOfDay = date.atTime(23, 59, 59);

			String hql = "FROM Attendance WHERE employee.id = :employeeId AND date BETWEEN :startOfDay AND :endOfDay";
			Query<Attendance> query = session.createQuery(hql, Attendance.class);
			query.setParameter("employeeId", employeeId);
			query.setParameter("startOfDay", startOfDay);
			query.setParameter("endOfDay", endOfDay);

			List<Attendance> results = query.list();
			return results.isEmpty() ? null : results.get(0);
		});
	}

	public List<Attendance> getAttendanceByDate(LocalDate date) {
		return hibernateTemplate.execute(session -> {
			LocalDateTime startOfDay = date.atStartOfDay();
			LocalDateTime endOfDay = date.atTime(23, 59, 59);

			String hql = "FROM Attendance WHERE date BETWEEN :startOfDay AND :endOfDay";
			Query<Attendance> query = session.createQuery(hql, Attendance.class);
			query.setParameter("startOfDay", startOfDay);
			query.setParameter("endOfDay", endOfDay);

			return query.list();
		});
	}

	public Attendance getTodayAttendance(int employeeId) {
		return getAttendanceByDateAndEmployee(LocalDate.now(), employeeId);
	}

	public List<Attendance> getAllTodayAttendance() {
		return getAttendanceByDate(LocalDate.now());
	}

	@Transactional(readOnly = true)
	public List<Attendance> getAttendanceByEmployeeAndDateRange(int employeeId, LocalDateTime startDate,
			LocalDateTime endDate) {
		return hibernateTemplate.execute(session -> {
			String hql = "FROM Attendance a WHERE a.employee.id = :employeeId "
					+ "AND a.date BETWEEN :startDate AND :endDate";

			Query<Attendance> query = session.createQuery(hql, Attendance.class);
			query.setParameter("employeeId", employeeId);
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);

			return query.list();
		});

	}

	@Transactional(readOnly = true)
	public List<Attendance> getAttendanceByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
		return this.hibernateTemplate.execute(session -> {
			String hql = "FROM Attendance a WHERE a.date BETWEEN :startDate AND :endDate";
			Query<Attendance> query = session.createQuery(hql, Attendance.class);
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);
			return query.list();
		});
	}

	@Transactional(readOnly = true)
	public List<Attendance> getMonthlyAttendance(int employeeId, int year, int month) {
		LocalDateTime startDate = LocalDate.of(year, month, 1).atStartOfDay();
		LocalDateTime endDate = startDate.plusMonths(1).minusSeconds(1);
		return getAttendanceByEmployeeAndDateRange(employeeId, startDate, endDate);
	}
}