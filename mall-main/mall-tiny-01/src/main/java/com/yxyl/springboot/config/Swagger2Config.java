package com.yxyl.springboot.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * @program: mall-tiny-01
 * @description: Swagger2配置类
 * @author: YxYL
 * @create: 2022-07-26 14:57
 **/
@Configuration
@EnableSwagger2
public class Swagger2Config {

    @Bean
    public Docket creatRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.yxyl.springboot.controller"))
                .paths(PathSelectors.any())
                .build();
    }

    

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("SwaggerUI")
                .description("Mall")
                .version("1.0.0")
                .contact("YxYL")
                .build();
    }


}
