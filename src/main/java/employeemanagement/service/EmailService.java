package employeemanagement.service;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Service;
import employeemanagement.model.Employee;

@Service
public class EmailService {

    public void sendCredentialEmail(Employee employee, String plainPassword) {
        try {
            SimpleEmail email = new SimpleEmail();
            email.setHostName("smtp.gmail.com");
            email.setSmtpPort(587);
            email.setAuthentication("dcpatel073@gmail.com", "yycfhkmsitaftugx"); 
            email.setStartTLSRequired(true);
            email.setFrom("dcpatel073@gmail.com", "Employee Management"); 
            email.setSubject("Welcome to Employee Management System - Your Login Credentials");

            String emailContent = String.format(
                "Dear %s,\n\n" +
                "Welcome to the Employee Management System! Your account has been successfully created.\n\n" +
                "Here are your login credentials:\n\n" +
                "Employee ID: EMP00%s\n" +
                "Email ID: %s\n" +
                "Password: %s\n\n" +
                "Please login at: http://localhost:8080/employeemanagement/signin\n\n" +
                "For security reasons, we recommend changing your password after your first login.\n\n" +
                "Best regards,\n" +
                "Employee Management Team",
                employee.getEmpName(),
                employee.getId(),
                employee.getEmailId(),
                plainPassword
            );

            email.setMsg(emailContent);
            email.addTo(employee.getEmailId()); 
            email.send();

            System.out.println("Email sent successfully!");
        } catch (EmailException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to send email", e);
        }
    }
}
