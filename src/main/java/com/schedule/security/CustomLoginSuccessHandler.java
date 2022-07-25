package com.schedule.security;

import com.schedule.login.vo.LoginVO;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException {

        SecurityContextHolder.getContext().setAuthentication(authentication);

        HttpSession session = request.getSession();

        Map<String, Object> authDetails = (Map<String, Object>)authentication.getDetails();

        session.setAttribute("USER", authDetails.get("USER"));
        session.setAttribute("ROLE", authDetails.get("ROLE"));

        response.sendRedirect("/schedule/goMain");
    }
}
