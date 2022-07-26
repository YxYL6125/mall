package com.yxyl.springboot.controller;

import com.yxyl.springboot.common.CommonResult;
import com.yxyl.springboot.service.EsProductService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * @program: mall-tiny-01
 * @description: Es商品搜索类
 * @author: YxYL
 * @create: 2022-07-26 14:35
 **/
@RestController
@RequestMapping("/esProduct")
@Api(tags = "EsProductController", description = "搜索商品管理")
public class EsProductController {
    @Autowired
    private EsProductService esProductService;

    @ApiOperation(value = "导入所有数据库中商品到ES")
    @RequestMapping(value = "/importAll", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult<Integer> importAllList() {
        int count = esProductService.importAll();
        return CommonResult.success(count);
    }

}
