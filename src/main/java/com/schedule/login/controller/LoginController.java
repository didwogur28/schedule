package com.schedule.login.controller;

import com.schedule.login.service.LoginService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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

    protected static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private LoginService loginService;

    // 로그인 페이지 이동
    @RequestMapping(value = "/goLogin")
    public String goGetLogin(HttpServletRequest request){

        return "login/login";
    }

    // 회원가입 페이지 이동
    @RequestMapping(value = "/goRegister", method = RequestMethod.GET)
    public String goRegister(@RequestParam(value="cpnCd", required=false) String cpnCd,
                             @RequestParam(value="seq", required=false) String seq,
                             Map<String, Object> modelMap) throws Exception {

        modelMap.put("cpnCd", cpnCd);
        modelMap.put("seq", seq);

        try {

            // 유저 회원가입
            if (cpnCd != null && seq != null) {
                String phoNo = loginService.getPhoNo(modelMap);
                modelMap.put("phoNo", phoNo);
            }

        } catch (Exception e) {
            logger.error("휴대폰 번호 조회 에러 : " + e.toString());
        }

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

        Map<String, Object> result = new HashMap<String, Object>();
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

        modelMap.put("pwdNo", (passwordEncoder.encode((CharSequence) modelMap.get("pwdNo"))));

        try {

            // 임시 유저 테이블 정보 삭제
            if(modelMap.get("cpnCd") != null) {
                loginService.delTmpInfo(modelMap);
            }

            loginService.doRegister(modelMap);

            result.put("status", "OK");

        } catch (Exception e) {

            result.put("status", "FALE");
            logger.error("회원가입 에러: "+e.toString());
        }

        return result;
    }
}
