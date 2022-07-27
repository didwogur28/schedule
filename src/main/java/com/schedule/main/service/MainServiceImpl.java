package com.schedule.main.service;

import com.schedule.login.dao.LoginMapper;
import com.schedule.login.service.LoginService;
import com.schedule.login.vo.LoginVO;
import com.schedule.login.vo.UserDetailsVO;
import com.schedule.main.dao.MainMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Map;

@Service
public class MainServiceImpl implements MainService {

    @Autowired
    private MainMapper mainMapper;

    @Override
    public String getMaxSeq(Map<String, Object> modelMap) throws Exception {
        return mainMapper.getMaxSeq(modelMap);
    }

    @Override
    public void doRegisterTmp(Map<String, Object> modelMap) throws Exception {
        mainMapper.doRegisterTmp(modelMap);
    }

}
