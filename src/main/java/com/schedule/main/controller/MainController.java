package com.schedule.main.controller;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
@ConfigurationProperties
public class MainController {

    // 로그인 페이지 이동
    @RequestMapping(value = "/goMain", method = RequestMethod.GET)
    public String goMainPage(HttpServletRequest request){

        return "main/main";
    }
}
