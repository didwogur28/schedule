package com.schedule.main.controller;

import com.schedule.main.service.MainService;
import net.nurigo.java_sdk.api.Message;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@ConfigurationProperties
public class MainController {

    protected static final Logger logger = LoggerFactory.getLogger(MainController.class);

    @Value("${sms.info.sndNo}")
    private String sndNo;

    @Value("${sms.info.apiKey}")
    private String apiKey;

    @Value("${sms.info.secretKey}")
    private String secretKey;

    @Autowired
    private MainService mainService;

    // 관리자 페이지 이동
    @RequestMapping(value = "/goMain", method = RequestMethod.GET)
    public String goMainPage(HttpSession session) {

        if("ROLE_ADMIN".equals(session.getAttribute("ROLE"))){
            return "main/mainAd";
        } else {
            return "main/mainEm";
        }
    }

    // SMS 전송
    @RequestMapping(value = "/main/sendSms", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> sendSms(@RequestParam Map <String, Object> modelMap) throws Exception {

        Map<String, Object> result = new HashMap<String, Object>();
        HashMap<String, String> params = new HashMap<String, String>();
        String smsMsg = "";

        try {

            String maxSeq = mainService.getMaxSeq(modelMap);
            modelMap.put("maxSeq", maxSeq);

            mainService.doRegisterTmp(modelMap);

            smsMsg = (String) modelMap.get("smsMsg") + "cpnCd=" + modelMap.get("cpnCd") + "&seq=" + maxSeq;

            String api_key = apiKey;              //사이트에서 발급 받은 API KEY
            String api_secret = secretKey;        //사이트에서 발급 받은 API SECRET KEY

            Message coolsms = new Message(api_key, api_secret);

            params.put("to", (String) modelMap.get("phoNo"));
            params.put("from", sndNo);          //사전에 사이트에서 번호를 인증하고 등록하여야 함
            params.put("type", "SMS");
            params.put("text", smsMsg);     //메시지 내용
            params.put("app_version", "test app 1.2");

            JSONObject obj = (JSONObject) coolsms.send(params);

            result.put("status", "OK");

        } catch (Exception e) {

            result.put("status", "FALE");

        }

        return result;
    }
}
