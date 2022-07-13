package com.schedule.security;

import org.springframework.security.authentication.BadCredentialsException;

import java.util.Map;

public class CustomBadCredentialsException extends BadCredentialsException {
	
	private static final long serialVersionUID = -2228433367137727343L;
	
	private Map<String, Object> resultOnLogin;
	
	public Map<String, Object> getResultOnLogin() {
		return resultOnLogin;
	}

	public void setResultOnLogin(Map<String, Object> resultOnLogin) {
		this.resultOnLogin = resultOnLogin;
	}

	public CustomBadCredentialsException(String msg) {
		super(msg);
	}
	
	public CustomBadCredentialsException(String msg, Throwable t) {
		super(msg, t);
	}
	
	public CustomBadCredentialsException(String msg, Map<String, Object> resultOnLogin) {
		super(msg);
		this.resultOnLogin = resultOnLogin;		
	}

	public CustomBadCredentialsException(String msg, Throwable t, Map<String, Object> resultOnLogin) {
		super(msg);
		this.resultOnLogin = resultOnLogin;		
	}

}
