package com.schedule.sch.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface SchMapper {

    public List<Map<String, Object>> getCntInfo(Map<String, Object> modelMap) throws Exception;
}
