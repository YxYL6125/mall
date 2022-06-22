package com.yxyl.springboot.controller;

import com.yxyl.springboot.common.CommonResult;
import com.yxyl.springboot.mbg.model.UmsAdmin;
import com.yxyl.springboot.service.UmsAdminService;
import com.yxyl.springboot.utils.SystemUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @program: mall
 * @description: 后台管理Controller
 * @author: YxYL
 * @create: 2022-06-17 09:55
 **/
@RestController
@Api(tags = "UmsAdminController", description = "后台管理Controller")
@RequestMapping("/admin")
public class UmsAdminController {

    @Autowired
    private UmsAdminService umsAdminService;

    @Value("${jwt.tokenHead}")
    private String tokenHead;
    @Value("${jwt.tokenHeader}")
    private String tokenHeader;

    @ApiOperation("用户注册")
    @PostMapping("/register")
    public CommonResult<UmsAdmin> register(UmsAdmin umsAdminParam) {
        if (SystemUtil.isNull(umsAdminParam)) {
            return CommonResult.failed("注册信息为空");
        }
        UmsAdmin umsAdmin = umsAdminService.register(umsAdminParam);

        if (SystemUtil.isNull(umsAdmin)) {
            return CommonResult.failed();
        }

        return CommonResult.success(umsAdmin);

    }


}
