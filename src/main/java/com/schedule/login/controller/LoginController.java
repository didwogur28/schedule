package com.schedule.login.controller;

import com.schedule.login.service.LoginService;
import com.schedule.util.Util;
import lombok.NonNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.http.HttpHeaders;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@ConfigurationProperties
public class LoginController {

    protected static final Logger logger = LoggerFactory.getLogger(LoginController.class);

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


    // 아아디 중복체크
    @RequestMapping(value = "/idDupChk", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> idDupChk(@RequestParam Map <String, Object> modelMap) throws Exception {

        Map<String, Object> result = new HashMap<String, Object>();

        try {

            int idDupChk = loginService.idDupChk(modelMap);
            System.out.println("idDupChk" + idDupChk);
            if(idDupChk > 0) {
                result.put("dupYn", "Y");
            } else {
                result.put("dupYn", "N");
            }

            result.put("status", "OK");

        } catch (Exception e) {

            result.put("status", "FALE");
            logger.error("아이디 중복체크 에러: "+e.toString());
        }

        return result;
    }

    // 회원가입
    @RequestMapping(value = "/doRegister", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> doRegister(@RequestParam Map <String, Object> modelMap) throws Exception {

        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

        modelMap.put("pwdNo", (passwordEncoder.encode((CharSequence) modelMap.get("pwdNo"))));

        Map<String, Object> result = new HashMap<String, Object>();
        try {

            loginService.doRegister(modelMap);
            result.put("status", "OK");

        } catch (Exception e) {

            result.put("status", "FALE");
            logger.error("회원가입 에러: "+e.toString());
        }

        return result;
    }
}
