package com.yxyl.springboot.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

/**
 * @program: mall
 * @description: Mybatis配置类
 * @author: YxYL
 * @create: 2022-06-15 09:55
 **/

@Configuration
@MapperScan(basePackages = "com.yxyl.springboot.mbg.mapper")
public class MybatisConfig {
}
