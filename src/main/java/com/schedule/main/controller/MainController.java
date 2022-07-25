package com.schedule.main.controller;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@ConfigurationProperties
public class MainController {

    // 관리자 페이지 이동
    @RequestMapping(value = "/goMain", method = RequestMethod.GET)
    public String goMainPage(HttpSession session) {

        if("ROLE_ADMIN".equals(session.getAttribute("ROLE"))){
            return "main/Amain";
        } else {
            return "main/Emain";
        }
    }
}
