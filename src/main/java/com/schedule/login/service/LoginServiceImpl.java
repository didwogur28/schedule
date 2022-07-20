package com.schedule.login.service;

import com.schedule.login.dao.LoginMapper;
import com.schedule.login.vo.LoginVO;
import com.schedule.login.vo.UserDetailsVO;
import com.schedule.security.CustomLoginFailureHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import java.util.Collections;
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

    @Override
    public UserDetailsVO getUsrInfo(String usrId) {

        UserDetailsVO userDetailsVO = null;
        LoginVO loginVO = loginMapper.getUsrInfo(usrId);

        if(loginVO != null) {
            userDetailsVO = new UserDetailsVO(loginVO, Collections.singleton(new SimpleGrantedAuthority(loginVO.getRoles())));
        } else {
            userDetailsVO = null;
        }

        return userDetailsVO;
    }
}
