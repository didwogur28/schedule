package com.schedule.login.controller;

import com.schedule.login.service.LoginService;
import com.schedule.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@ConfigurationProperties
public class LoginController {

    @Autowired
    private LoginService loginService;

    // 로그인 페이지 이동
    @RequestMapping(value = "/goLogin", method = RequestMethod.GET)
    public String getLoginPage(HttpServletRequest request){

        String referer = request.getHeader(HttpHeaders.REFERER);
        if(referer == null)
            referer = "";

        if(referer.indexOf("login") >= 0)
            referer = "";

        request.getSession().setAttribute("url_prior_login", referer);

        return "login/login";
    }

    // 회원가입 페이지 이동
    @RequestMapping(value = "/goRegister", method = RequestMethod.GET)
    public String goRegister() {

        return "login/register";
    }

    // 회원가입
    @RequestMapping(value = "/doRegister", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> doRegister(@RequestParam Map <String, Object> modelMap) throws Exception {

        modelMap.put("pwdNo", Util.digestStringSHA256((String) modelMap.get("pwdNo")));

        Map<String, Object> result = new HashMap<String, Object>();
        try {

            loginService.doRegister(modelMap);
            result.put("status", "OK");

        } catch (Exception e) {
            result.put("status", "FALE");
            result.put("msg", e.toString());
        }

        return result;
    }
}
