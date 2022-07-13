package com.schedule.login.service;

import com.schedule.login.vo.LoginVO;
import com.schedule.login.vo.UserDetailsVO;

import java.util.Map;

public interface LoginService {

    public int idDupChk(Map<String, Object> modelMap) throws Exception;

    public void doRegister(Map<String, Object> modelMap) throws Exception;

    public UserDetailsVO getUsrInfo(String usrId);

}
