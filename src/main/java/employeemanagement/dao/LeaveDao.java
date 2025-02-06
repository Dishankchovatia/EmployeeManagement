package employeemanagement.dao;

import employeemanagement.model.Leave;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Component
public class LeaveDao {
    
    @Autowired
    private HibernateTemplate hibernateTemplate;
    
    @Transactional
    public void createLeave(Leave leave) {
        this.hibernateTemplate.save(leave);
    }
    
    @Transactional
    public void updateLeave(Leave leave) {
        this.hibernateTemplate.update(leave);
    }
    
    public Leave getLeave(int id) {
        return this.hibernateTemplate.get(Leave.class, id);
    }
    
    public List<Leave> getEmployeeLeaves(int employeeId) {
        return hibernateTemplate.execute(session -> {
            String hql = "FROM Leave l WHERE l.employee.id = :employeeId ORDER BY l.startDate DESC";
            return session.createQuery(hql, Leave.class)
                    .setParameter("employeeId", employeeId)
                    .list();
        });
    }
    
    public List<Leave> getPendingLeaves() {
        return hibernateTemplate.execute(session -> {
            String hql = "FROM Leave l WHERE l.status = 'PENDING' ORDER BY l.startDate";
            return session.createQuery(hql, Leave.class).list();
        });
    }
}
