package employeemanagement.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

@Component
public class SessionCheckFilter implements Filter {

    // Public URLs accessible without authentication
    private static final Set<String> PUBLIC_URLS = new HashSet<>(Arrays.asList(
        "/",
        "/login",
        "/index",
        "/handle-login",
        "/logout"
    ));

    // URLs that only admins can access
    private static final Set<String> ADMIN_URLS = new HashSet<>(Arrays.asList(
        "/dashboard",
        "/add-employee",
        "/handle-employee",
        "/update",
        "/update-employee",
        "/toggle-employee-status",
        "/promote-to-admin",
        "/listofemployees",
        "/admin/pending-leaves",
        "/admin/process-leave",
        "/admin/generate-leave-report",
        "/admin/leave-report",
        "/attendance-dashboard",
        "/attendance/report",
        "/attendance/calender"
    ));

    // URLs that employees can access
    private static final Set<String> EMPLOYEE_URLS = new HashSet<>(Arrays.asList(
        "/eupdate",
        "/eupdate-employee",
        "/apply-leave",
        "/submit-leave",
        "/my-leaves",
        "/check-in",
        "/check-out",
        "/attendance-status",
        "/attendance/report",
        "/attendance/calender"
    ));

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String contextPath = httpRequest.getContextPath();
        String requestURI = httpRequest.getRequestURI().substring(contextPath.length());
        
        if (requestURI.isEmpty()) {
            requestURI = "/";
        }

        if (isPublicResource(requestURI)) {
            chain.doFilter(request, response);
            return;
        }

        if (isPublicUrl(requestURI)) {
            chain.doFilter(request, response);
            return;
        }

        if (session == null || session.getAttribute("id") == null) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        String userRole = (String) session.getAttribute("role");
        Integer userId = (Integer) session.getAttribute("id");

        if (requestURI.matches("/\\d+")) {
            int requestedUserId = Integer.parseInt(requestURI.substring(1));
            if ("ADMIN".equals(userRole) || requestedUserId == userId) {
                chain.doFilter(request, response);
                return;
            }
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        if (hasAccess(requestURI, userRole)) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
        }
    }

    private boolean isPublicResource(String uri) {
        return uri.startsWith("/resources/") ||
               uri.startsWith("/css/") ||
               uri.startsWith("/js/") ||
               uri.startsWith("/images/");
    }

    private boolean isPublicUrl(String uri) {
        return PUBLIC_URLS.stream()
                .anyMatch(url -> uri.equals(url) || uri.startsWith(url + "?"));
    }

    private boolean hasAccess(String uri, String role) {

        if ("ADMIN".equals(role)) {
            return true;
        }

        if ("USER".equals(role)) {
            return EMPLOYEE_URLS.stream()
                    .anyMatch(url -> uri.startsWith(url));
        }

        return false;
    }
}