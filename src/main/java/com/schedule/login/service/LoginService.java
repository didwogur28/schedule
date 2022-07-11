package com.schedule.login.service;

import com.schedule.login.vo.LoginVO;

import java.util.Map;

public interface LoginService {

    public int idDupChk(Map<String, Object> modelMap) throws Exception;

    public void doRegister(Map<String, Object> modelMap) throws Exception;

    public LoginVO getUsrInfo(String usrId) throws Exception;
}
