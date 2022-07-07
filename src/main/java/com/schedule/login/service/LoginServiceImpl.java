package com.schedule.login.service;

import com.schedule.login.dao.LoginMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private LoginMapper loginMapper;

    @Override
    public int idDupChk(Map<String, Object> modelMap) throws Exception {
        return loginMapper.idDupChk(modelMap);
    }

    @Override
    public void doRegister(Map<String, Object> modelMap) throws Exception {
        loginMapper.doRegister(modelMap);
    }
}
