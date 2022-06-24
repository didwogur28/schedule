package com.schedule.login.service;

import com.schedule.login.dao.LoginDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private LoginDAO loginDAO;

    @Override
    public void doRegister(Map<String, Object> modelMap) throws Exception {
        loginDAO.doRegister(modelMap);
    }
}
