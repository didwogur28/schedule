package com.schedule.login.service;

import com.schedule.login.dao.LoginMapper;
import com.schedule.login.vo.LoginVO;
import com.schedule.login.vo.UserDetailsVO;
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
    public LoginVO getUsrInfo(String usrId) {
        return loginMapper.getUsrInfo(usrId);
    }

    @Override
    public UserDetailsVO setUserDetailVO(LoginVO loginVO) {

        UserDetailsVO userDetailsVO = new UserDetailsVO(loginVO, Collections.singleton(new SimpleGrantedAuthority(loginVO.getRoles())));

        return userDetailsVO;
    }
}
