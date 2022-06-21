package com.schedule.properties;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;
import com.zaxxer.hikari.HikariConfig;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Data
@EnableEncryptableProperties
@ConfigurationProperties(prefix = "spring.datasource")
public class DatabaseProperties {

    private String driverClassName;
    private String url;
    private String username;
    private String password;
    private int maxTotal;
    private int maxIdle;
    private int minIdle;
    private int maxWaitMillis;
    private int maxOpenPreparedStatements;
    private String validationQuery;

    private String configLocation;
    private String mapperLocations;

    private String dbName;

    /**
     * using HikariCP
     * @return
     */
    public HikariConfig getHikariConfig() {

        HikariConfig hcp = new HikariConfig();

        hcp.setDriverClassName(driverClassName);
        hcp.setJdbcUrl(url);
        hcp.setUsername(username);
        hcp.setPassword(password);
        hcp.setAutoCommit(false);
        hcp.setConnectionTimeout(300000);	// Connection 연결 시도 Timeout, Default:30초
        hcp.setIdleTimeout(600000);			// Connection의 maximum idle time 결정, Default:10분
        hcp.setMaximumPoolSize(maxTotal);	// 최대 Connection 개수
        hcp.setMinimumIdle(minIdle);			// 유지할 최소 Connection 개수, maximumPoolSize와 동일하게 사용하는 것을 권장함. - Default : maximumPoolSize 개수
        hcp.setMaxLifetime(maxWaitMillis);	//  Connection 최대 생명주기, 30~60분을 권장, Default:30분

        hcp.setConnectionTestQuery(validationQuery);
        hcp.addDataSourceProperty("cachePrepStmts", "true");
        hcp.addDataSourceProperty("prepStmtCacheSize", "250");
        hcp.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

        hcp.setPoolName(dbName);

        return hcp;
    }
}
