package com.schedule.config;

import com.schedule.properties.DatabaseProperties;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;

@Configuration
@EnableConfigurationProperties({DatabaseProperties.class})
@MapperScan(basePackages = "com.schedule.mapper")
public class DatabaseConfig {

    @Autowired
    private DatabaseProperties databaseProperties;

    @Bean(name="dataSource")
    public DataSource dataSource() {
        DataSource dataSource = new HikariDataSource(databaseProperties.getHikariConfig());
        return dataSource;
    }

    @Bean(name="sqlSessionFactory")
    SqlSessionFactory sqlSessionFactory(@Qualifier("dataSource") DataSource dataSource) throws Exception {

        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();

        sqlSessionFactoryBean.setDataSource(dataSource);

        sqlSessionFactoryBean.setConfigLocation(resolver.getResource(databaseProperties.getConfigLocation()));
        sqlSessionFactoryBean.setMapperLocations(resolver.getResources(databaseProperties.getMapperLocations()));

        return sqlSessionFactoryBean.getObject();
    }

    @Bean
    SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
        sqlSessionFactory.getConfiguration().setMapUnderscoreToCamelCase(true);
        return new SqlSessionTemplate(sqlSessionFactory);
    }
}
