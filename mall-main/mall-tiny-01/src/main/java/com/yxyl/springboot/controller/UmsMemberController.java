package com.yxyl.springboot.controller;

import com.yxyl.springboot.common.CommonResult;
import com.yxyl.springboot.service.UmsMemberService;
import com.yxyl.springboot.utils.SystemUtil;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.xml.transform.sax.SAXResult;

/**
 * @program: mall
 * @description: 登录注册管理Controller
 * @author: YxYL
 * @create: 2022-06-16 10:36
 **/
@RestController
@RequestMapping("/sso")
public class UmsMemberController {
    private final Logger LOGGER = LoggerFactory.getLogger(UmsMemberController.class);

    @Autowired
    private UmsMemberService memberService;

    @ApiOperation("获取验证码")
    @GetMapping("/getAuthCode")
    public CommonResult getAuthCode(@RequestParam String telephone) {
        LOGGER.info("getAuthCode start");
        if (SystemUtil.isNullOrEmpty(telephone)) {
            LOGGER.error("getAuthCode failed:telephone为空");
            return CommonResult.failed("telephone为空");
        }

        CommonResult commonResult = memberService.generateAuthCode(telephone);

        LOGGER.info("getAuthCode return :" + commonResult);
        LOGGER.info("getAuthCode end");
        return commonResult;
    }


    @ApiOperation("判断验证码是否正确")
    @PostMapping("/verifyAuthCode")
    public CommonResult updatePassword(@RequestParam String telephone, @RequestParam String authCode) {
            return memberService.verifyAuthCode(telephone,authCode);
    }
}
