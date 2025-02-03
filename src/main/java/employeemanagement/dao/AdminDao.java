package employeemanagement.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import employeemanagement.model.Admin;

@Repository
public class AdminDao {

    @Autowired
    private HibernateTemplate hibernateTemplate;

    @Transactional
    public void createAdmin(Admin admin) {
        hibernateTemplate.save(admin);
    }

    public Admin getAdminByAdminId(String adminId) {
        return hibernateTemplate.execute(session -> {
            String hql = "FROM Admin WHERE adminId = :adminId";
            return session.createQuery(hql, Admin.class)
                          .setParameter("adminId", adminId)
                          .uniqueResult();
        });
    }

    public Admin getAdminByAdminName(String adminName) {
        return hibernateTemplate.execute(session -> {
            String hql = "FROM Admin WHERE adminName = :adminName";
            return session.createQuery(hql, Admin.class)
                          .setParameter("adminName", adminName)
                          .uniqueResult();
        });
    }
    
    
}