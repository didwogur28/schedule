package com.schedule.login.dao;

import com.schedule.login.vo.LoginVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface LoginMapper {

    public int idDupChk(Map<String, Object> modelMap) throws Exception;

    public void doRegister(Map<String, Object> modelMap) throws Exception;

    public LoginVO getUsrInfo(String usrId);

    public String getPhoNo(Map<String, Object> modelMap) throws Exception;

    public void delTmpInfo(Map<String, Object> modelMap) throws Exception;
}