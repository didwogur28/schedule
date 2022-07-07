package com.schedule.login.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface LoginMapper {

    public int idDupChk(Map<String, Object> modelMap) throws Exception;

    public void doRegister(Map<String, Object> modelMap) throws Exception;
}