package com.schedule.main.service;

import com.schedule.login.vo.LoginVO;
import com.schedule.login.vo.UserDetailsVO;

import java.util.Map;

public interface MainService {

    public String getMaxSeq(Map<String, Object> modelMap) throws Exception;

    public void doRegisterTmp(Map<String, Object> modelMap) throws Exception;

}
