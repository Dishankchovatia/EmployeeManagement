package employeemanagement.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import org.springframework.stereotype.Component;

@Component
public class SessionCheckFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession(false);

		String requestURI = httpRequest.getRequestURI();
		String contextPath = httpRequest.getContextPath();

		// URLs that don't need authentication
		boolean isPublicPage = requestURI.equals(contextPath + "/") || 
				requestURI.endsWith("/login")
				|| requestURI.equals(contextPath + "/index"); 

		boolean isPublicResource = requestURI.contains("/resources/") || requestURI.contains("/css/")
				|| requestURI.contains("/js/") || requestURI.contains("/images/")
				|| requestURI.contains("/handle-login") ;
		if (isPublicPage || isPublicResource) {
			chain.doFilter(request, response);
			return;
		}

		if (session == null || (session.getAttribute("adminId") == null && session.getAttribute("id") == null)) {
			httpResponse.sendRedirect(contextPath + "/");
			return;
		}

		chain.doFilter(request, response);
	}

}