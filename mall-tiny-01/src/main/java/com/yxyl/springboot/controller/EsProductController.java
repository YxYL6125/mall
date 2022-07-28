package com.yxyl.springboot.controller;

import com.mysql.cj.exceptions.ClosedOnExpiredPasswordException;
import com.yxyl.springboot.common.CommonPage;
import com.yxyl.springboot.common.CommonResult;
import com.yxyl.springboot.nosql.elasticsearch.document.EsProduct;
import com.yxyl.springboot.service.EsProductService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    public CommonResult<Integer> importAllList() {
        int count = esProductService.importAll();
        return CommonResult.success(count);
    }

    @PostMapping("/delete/{id}")
    @ApiOperation("根据id删除商品")
    public CommonResult<Object> delete(@PathVariable("id") Long id) {
        esProductService.delete(id);
        return CommonResult.success(null);
    }


    @PostMapping("/delete/batch")
    @ApiOperation("根据id批量删除商品")
    public CommonResult<Object> delete(@RequestParam("ids") List<Long> ids) {
        esProductService.delete(ids);
        return CommonResult.success(null);
    }

    @PostMapping("/create/{id}")
    @ApiOperation("根据id创建商品")
    public CommonResult<EsProduct> create(@PathVariable("id") Long id) {
        EsProduct esProduct = esProductService.create(id);
        if (esProduct != null) {
            return CommonResult.success(esProduct);
        } else {
            return CommonResult.failed();
        }
    }

    @GetMapping("/search/simple")
    @ApiOperation("简单搜索")
    public CommonResult<CommonPage<EsProduct>> search(@RequestParam(required = false) String keyword,
                                                      @RequestParam(required = false) Integer pageNum,
                                                      @RequestParam(required = false) Integer pageSize) {
        Page<EsProduct> esProductPage = esProductService.search(keyword, pageNum, pageSize);
        return CommonResult.success(CommonPage.restPage(esProductPage));
    }


}
