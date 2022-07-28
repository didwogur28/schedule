package com.schedule.sch.controller;

import com.schedule.login.vo.LoginVO;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@ConfigurationProperties
public class SchController {

    // 스케줄 페이지 이동
    @RequestMapping(value = "/sch/goCalendar")
    public String goCalendar(@RequestParam(value="cpnCd", required=true) String cpnCd,
                             @RequestParam(value="tab", required=true) String tab,
                             Map<String, Object> modelMap, HttpSession session){

        modelMap.put("cpnCd", cpnCd);
        modelMap.put("tab", tab);

        return "sch/calendar";
    }

    // 스케줄 페이지(주간) 이동
    @RequestMapping(value = "/sch/goCalendarW")
    public String goCalendarW(@RequestParam(value="cpnCd", required=true) String cpnCd,
                             Map<String, Object> modelMap){

        modelMap.put("cpnCd", cpnCd);

        return "sch/calendarW";
    }

    // 스케줄 페이지(월간) 이동
    @RequestMapping(value = "/sch/goCalendarM")
    public String goCalendarM(@RequestParam(value="cpnCd", required=true) String cpnCd,
                              Map<String, Object> modelMap){

        modelMap.put("cpnCd", cpnCd);

        return "sch/calendarM";
    }

    // 스케줄 페이지(목록) 이동
    @RequestMapping(value = "/sch/goCalendarL")
    public String goCalendarL(@RequestParam(value="cpnCd", required=true) String cpnCd,
                              Map<String, Object> modelMap){

        modelMap.put("cpnCd", cpnCd);

        return "sch/calendarL";
    }
}
