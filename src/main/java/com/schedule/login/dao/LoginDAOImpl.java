package com.schedule.login.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class LoginDAOImpl implements LoginDAO {

    @Autowired
    private SqlSession sql;

    @Override
    public void doRegister(Map<String, Object> modelMap) throws Exception {
        sql.update("login.doRegister", modelMap);
    }
}
