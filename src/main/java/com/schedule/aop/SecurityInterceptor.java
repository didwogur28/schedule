package com.schedule.aop;


import com.schedule.login.vo.LoginVO;
import org.apache.commons.io.IOUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@ConfigurationProperties
@Service
public class SecurityInterceptor extends HandlerInterceptorAdapter {
	 /**
    * Logger for this class
    */
	public static final Logger logger = LoggerFactory.getLogger(SecurityInterceptor.class);

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

		try {

			super.afterCompletion(request, response, handler, ex);
			MDC.remove("uid");

			String userId = request.getSession().getAttribute("USER") == null ? "" : ((LoginVO)request.getSession().getAttribute("USER")).getUsrId();
			String requestURI = request.getRequestURI().substring(request.getContextPath().length());
			String controller = handler.getClass().getName();

			if(controller.indexOf("$")>0){
				controller = controller.substring(0, controller.indexOf("$"));
			}

			String method = requestURI.substring(requestURI.lastIndexOf("/")+1);
			String params = "";

			if (request.getAttribute("params") != null) {
				params = (String)request.getAttribute("params");
			}else {
				String[] codes = null;

				if (request.getQueryString() != null && request.getQueryString().length() > 10) {
					String queryString = request.getQueryString();
					queryString = queryString.substring(queryString.indexOf("?") + 1);
					codes = queryString.split("&");
				} else {
					Pattern pattern = Pattern.compile("(\\d{2})/(\\d{2})/(\\d{3}/(\\d{6}))");
					Matcher matcher = pattern.matcher(request.getRequestURI());

					if (matcher.find()) {
						codes = matcher.group().split("/");
					}
				}

				Map<String, String> map = new HashMap<String, String>();

				if(codes != null){
					for (String str: codes){
						if(str.indexOf("=") > 0){
							map.put(str.substring(0, str.indexOf("=")), str.substring(str.indexOf("=") + 1));
						}
					}
				}

				map.put("requestMethod", "GET");
			}


		} catch(Exception e) {
			logger.error("afterCompletion Error : " + e.toString());
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);

	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		try {
			logger.debug(">>>" + request.getRequestURI());

			if(request.getRequestURI().contains("/goLogin")) {
				HttpSession session = request.getSession(false);
				if(session != null){
					session.invalidate();	//old session invalidated
				}
				return true;
			}

			// json type으로 넘어온 데이타는 즉 서버저장시 사용하는 값은 request의 attribute에 params로 setting
			HttpSession session = request.getSession(true);
			Object siteLogin = session.getAttribute("USER");

			logger.debug("COGNITOYN"  + session.getAttribute("COGNITOYN"));
			logger.debug("SESSION_KEY" + session.getAttribute("SESSION_KEY"));

			String contentType = request.getContentType();

			if (contentType != null && contentType.indexOf("application/json") >= 0) {

				// 저장시 JSON형식으로 스트림전송된 내용을 params로 저장해둔다.
				request.setAttribute("params", IOUtils.toString(request.getInputStream()));
				logger.debug("params>>>{}", request.getAttribute("params"));
			}

			if (siteLogin == null) {
				if (contentType != null && contentType.indexOf("application/json") >= 0) {
					response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
				}else{
					response.setContentType("text/html");
					PrintWriter out = response.getWriter();
					out.print("<script>window.location.href = '/schedule/goLogin';</script>");
				}
				return false;
			}

		} catch(Exception e) {

			logger.debug("params>>>{}", request.getRequestURI());
			throw e;
		}

		return true;
	}

}
