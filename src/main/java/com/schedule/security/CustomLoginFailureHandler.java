package com.schedule.security;

import com.google.gson.Gson;
import org.apache.ibatis.javassist.NotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
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

		if (exception instanceof BadCredentialsException) {
			request.setAttribute("LoginFailMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/goLogin");
		dispatcher.forward(request, response);

	}

}
