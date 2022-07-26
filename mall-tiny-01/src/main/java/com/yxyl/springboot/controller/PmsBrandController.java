package com.yxyl.springboot.controller;

import com.yxyl.springboot.common.CommonPage;
import com.yxyl.springboot.common.CommonResult;
import com.yxyl.springboot.mbg.model.PmsBrand;
import com.yxyl.springboot.service.PmsBrandService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @program: mall
 * @description: 品牌管理Controller
 * @author: YxYL
 * @create: 2022-06-15 09:56
 **/

@RestController
@Api(tags = "PmsBrandController", description = "品牌管理Controller")
@RequestMapping("/brand")
public class PmsBrandController {

    @Autowired
    private PmsBrandService pmsBrandService;

    private static final Logger LOGGER = LoggerFactory.getLogger(PmsBrandController.class);


    /**
     * 查询所有品牌
     *
     * @return
     */
    @ApiOperation("查询所有品牌")
    @GetMapping("/listAll")
    public CommonResult<List<PmsBrand>> getBrandList() {
        LOGGER.info("getBrandList");
        return CommonResult.success(pmsBrandService.listALlBrand());
    }


    /**
     * 创建品牌
     *
     * @param pmsBrand
     * @return
     */
    @PostMapping(value = "/create")
    @ApiOperation("创建品牌")
    public CommonResult creatBrand(PmsBrand pmsBrand) {
        CommonResult commonResult;
        LOGGER.info("creatBrand start");
        int count = pmsBrandService.creatBrand(pmsBrand);

        if (count == 1) {
            commonResult = CommonResult.success(pmsBrand);
            LOGGER.info("creatBrand success:{}" + pmsBrand);
        } else {
            commonResult = CommonResult.failed("操作失败");
            LOGGER.info("creatBrand failed:{}" + pmsBrand);
        }
        LOGGER.info("creatBrand end");
        return commonResult;
    }


    /**
     * 删除品牌
     *
     * @param id
     * @return
     */
    @ApiOperation("删除品牌")
    @PostMapping("/delete")
    public CommonResult deleteBrand(@RequestParam("id") long id) {
        LOGGER.info("deleteBrand start");
        int count = pmsBrandService.deleteBrand(id);
        if (count == 1) {
            LOGGER.info("deleteBrand success :id={}" + id);
            return CommonResult.success(null);
        } else {
            LOGGER.info("deleteBrand failed :id={}" + id);
            return CommonResult.failed("操作失败");
        }
    }

    /**
     * 修改品牌
     *
     * @param id
     * @param pmsBrand
     * @return
     */
    @ApiOperation("修改品牌")
    @PostMapping("/update/{id}")
    public CommonResult updateBrand(@PathVariable("id") long id, PmsBrand pmsBrand) {

        LOGGER.info("updateBrand start");
        int count = pmsBrandService.updateBrand(id, pmsBrand);
        if (count == 1) {
            LOGGER.info(("updateBrand success :id={}" + id));
            return CommonResult.success(null);
        } else {
            LOGGER.info(("updateBrand failed :id={}" + id));
            return CommonResult.failed("操作失败");
        }
    }

    /**
     * 查询单个品牌
     *
     * @param id
     * @return
     */
    @ApiOperation("查询单个品牌")
    @GetMapping("/{id}")
    public CommonResult<PmsBrand> brand(@PathVariable("id") long id) {
        return CommonResult.success(pmsBrandService.getBrand(id));
    }

    @GetMapping("/list")
    public CommonResult<CommonPage<PmsBrand>> listBrand(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                                        @RequestParam(value = "pageSize", defaultValue = "3") Integer pageSize) {
        return CommonResult.success(CommonPage.restPage(pmsBrandService.listBrand(pageNum,pageSize)));

    }

}
