package com.schedule.security;

import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

	public static final Logger logger = LoggerFactory.getLogger(CustomLoginFailureHandler.class);
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		
		if(isAjax) {
			Map<String, Object> validationResult = new HashMap<String, Object>();
			if(exception instanceof CustomBadCredentialsException)
				validationResult = ((CustomBadCredentialsException)exception).getResultOnLogin();
			response.setContentType("application/json");
			response.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			out.print(new Gson().toJson(validationResult));
			out.flush();
		}
		else {
			request.setAttribute("errorMessage", "Invalid user or password");
			RequestDispatcher rd = request.getRequestDispatcher("/schedule/goLogin");
            rd.forward(request, response);          
		}

	}

}
