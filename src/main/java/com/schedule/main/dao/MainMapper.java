package com.schedule.main.dao;

import com.schedule.login.vo.LoginVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface MainMapper {

    public String getMaxSeq(Map<String, Object> modelMap) throws Exception;

    public void doRegisterTmp(Map<String, Object> modelMap) throws Exception;

}