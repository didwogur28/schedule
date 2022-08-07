package com.schedule.sch.controller;

import com.schedule.common.service.CommonService;
import com.schedule.login.vo.LoginVO;
import com.schedule.sch.service.SchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@ConfigurationProperties
public class SchController {

    @Autowired
    private SchService schService;

    @Autowired
    private CommonService commonService;

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
    @RequestMapping(value = "/sch/goDetailCalendar")
    public String goDetailCalendar(@RequestParam(value="cpnCd", required=true) String cpnCd,
                                   @RequestParam(value="tabNum", required=true) String tabNum,
                                   Map<String, Object> modelMap) throws Exception {

        modelMap.put("cpnCd", cpnCd);

        if("1".equals(tabNum)) {
            return "sch/calendarW";

        } else if("2".equals(tabNum)) {

            modelMap.put("comClsCd", "CNT_CD");
            List<Map<String, Object>> cntCodeList = commonService.getCodeList(modelMap);
            modelMap.put("cntCodeList", cntCodeList);

            modelMap.put("comClsCd", "CNT_TM_CD");
            List<Map<String, Object>> cntTmCodeList = commonService.getCodeList(modelMap);
            modelMap.put("cntTmCodeList", cntTmCodeList);

            return "sch/calendarM";

        }else {
            return "sch/calendarL";

        }
    }

    // 스케줄 페이지(월간) 데이터 조회
    @RequestMapping(value = "/sch/getCntInfo", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getCntInfo(@RequestParam(value="cpnCd", required=true) String cpnCd,
                                          @RequestParam(value="date", required=true) String date,
                                          Map<String, Object> modelMap) throws Exception {

        Map<String, Object> result = new HashMap<String, Object>();

        modelMap.put("date", date);
        modelMap.put("cpnCd", cpnCd);

        try {
            List<Map<String, Object>> getCntInfoList = schService.getCntInfo(modelMap);

            result.put("datas", getCntInfoList);
            result.put("status", "OK");

        } catch (Exception e){
            result.put("status", "FALE");
        }

        return result;
    }

    // 스케줄 페이지(월간) 데이터 조회
    @RequestMapping(value = "/sch/saveMonthCnt", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> saveMonthCnt(@RequestParam Map <String, Object> modelMap,
                                            HttpSession session) throws Exception {

        LoginVO loginVO = (LoginVO) session.getAttribute("USER");

        modelMap.put("usrId", loginVO.getUsrId());

        Map<String, Object> result = new HashMap<String, Object>();

        try {
            schService.saveMonthCnt(modelMap);

            result.put("status", "OK");

        } catch (Exception e){
            result.put("status", "FALE");
        }

        return result;
    }
}
