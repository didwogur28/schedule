package com.schedule.sch.service;

import java.util.List;
import java.util.Map;

public interface SchService {

    public List<Map<String, Object>> getCntInfo(Map<String, Object> modelMap) throws Exception;

    public void saveMonthCnt(Map<String, Object> modelMap) throws Exception;
}
