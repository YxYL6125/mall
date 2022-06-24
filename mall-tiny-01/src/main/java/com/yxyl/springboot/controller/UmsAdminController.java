package com.yxyl.springboot.controller;

import com.yxyl.springboot.common.CommonResult;
import com.yxyl.springboot.dto.UmsAdminLoginParam;
import com.yxyl.springboot.mbg.model.UmsAdmin;
import com.yxyl.springboot.mbg.model.UmsPermission;
import com.yxyl.springboot.service.UmsAdminService;
import com.yxyl.springboot.utils.SystemUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    private UmsAdminService adminService;
    private static final Logger LOGGER = LoggerFactory.getLogger(UmsAdminController.class);

    @Value("${jwt.tokenHead}")
    private String tokenHead;
    @Value("${jwt.tokenHeader}")
    private String tokenHeader;

    @ApiOperation("用户注册")
    @PostMapping("/register")
    public CommonResult<UmsAdmin> register(UmsAdmin umsAdminParam) {
        LOGGER.info("Admin register");
        if (SystemUtil.isNull(umsAdminParam)) {
            return CommonResult.failed("注册信息为空");
        }
        UmsAdmin umsAdmin = adminService.register(umsAdminParam);

        if (SystemUtil.isNull(umsAdmin)) {
            return CommonResult.failed();
        }

        LOGGER.info("Admin register return:{}" + umsAdmin.toString());
        return CommonResult.success(umsAdmin);

    }

    @ApiOperation("登录后返回token")
    @PostMapping("/login")
    public CommonResult login( UmsAdminLoginParam umsAdminLoginParam) {
        String token = adminService.login(umsAdminLoginParam.getUsername(),umsAdminLoginParam.getPassword());
        if (token == null) {
            return CommonResult.validateFailed("用户名或密码错误");
        }

        Map<String, String> toKenMap = new HashMap<>();
        toKenMap.put("token", token);
        toKenMap.put("tokenHeader", tokenHeader);
        return CommonResult.success(toKenMap, "登录成功");
    }


    @ApiOperation("获取用户所有权限")
    @GetMapping("/permission/{adminId}")
    public CommonResult<List<UmsPermission>> getPermissionList(@PathVariable("adminId") Long adminId) {
        List<UmsPermission> list = adminService.getPermissionList(adminId);
        return CommonResult.success(list, "操作成功");
    }


}
