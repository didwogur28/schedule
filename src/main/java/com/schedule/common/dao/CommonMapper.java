package com.schedule.common.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CommonMapper {

    public List<Map<String, Object>> getCodeList(Map<String, Object> modelMap) throws Exception;

}