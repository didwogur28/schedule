package com.schedule.common.service;

import com.schedule.common.dao.CommonMapper;
import com.schedule.main.dao.MainMapper;
import com.schedule.main.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CommonServiceImpl implements CommonService {

    @Autowired
    private CommonMapper commonMapper;


    @Override
    public List<Map<String, Object>> getCodeList(Map<String, Object> modelMap) throws Exception {
        return commonMapper.getCodeList(modelMap);
    }
}
