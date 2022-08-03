package com.schedule.sch.service;

import com.schedule.sch.dao.SchMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SchServiceImpl implements SchService {

    @Autowired
    private SchMapper schMapper;

    @Override
    public List<Map<String, Object>> getCntInfo(Map<String, Object> modelMap) throws Exception {
        return schMapper.getCntInfo(modelMap);
    }
}
