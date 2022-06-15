package com.yxyl.springboot.controller;

import com.yxyl.springboot.common.CommonResult;
import com.yxyl.springboot.mbg.model.PmsBrand;
import com.yxyl.springboot.service.PmsBrandService;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @program: mall
 * @description: 品牌管理Controller
 * @author: YxYL
 * @create: 2022-06-15 09:56
 **/

@RestController
@RequestMapping("/brand")
public class PmsBrandController {

    @Autowired
    private PmsBrandService pmsBrandService;

    private static final Logger LOGGER = LoggerFactory.getLogger(PmsBrandController.class);


    @GetMapping("/listAll")
    public CommonResult<List<PmsBrand>> getBrandList() {
        return CommonResult.success(pmsBrandService.listALlBrand());
    }


}
