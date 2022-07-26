package com.yxyl.springboot.service.impl;

import com.yxyl.springboot.common.CommonResult;
import com.yxyl.springboot.service.RedisService;
import com.yxyl.springboot.service.UmsMemberService;
import com.yxyl.springboot.utils.SystemUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Random;

/**
 * @program: mall
 * @description:
 * @author: YxYL
 * @create: 2022-06-16 10:41
 **/

@Service
public class UmsMemberServiceImpl implements UmsMemberService {

    @Autowired
    private RedisService redisService;
    @Value("${redis.key.prefix.authCode}")
    private String REDIS_KEY_PREFIX_AUTH_CODE;
    @Value("${redis.key.expire.authCode}")
    private Long AUTH_CODE_EXPIRE_SESSION;

    /**
     * 获取验证码
     *
     * @param telephone
     * @return
     */
    @Override
    public CommonResult generateAuthCode(String telephone) {

        StringBuilder sb = new StringBuilder();
        Random r = new Random();
        for (int i = 0; i < 10; i++) {
            sb.append(r.nextInt(10));
        }
        //验证码绑定手机并存在redis中
        redisService.set(REDIS_KEY_PREFIX_AUTH_CODE + telephone, sb.toString());
        redisService.expire(REDIS_KEY_PREFIX_AUTH_CODE + telephone, AUTH_CODE_EXPIRE_SESSION);

        return CommonResult.success(sb.toString(), "获取验证码成功");
    }


    /**
     * 判断验证码是否正确
     *
     * @param telephone
     * @param authCode
     * @return
     */
    @Override
    public CommonResult verifyAuthCode(String telephone, String authCode) {

        if (SystemUtil.isNullOrEmpty(telephone)) {
            return CommonResult.failed("请输入验证码");
        }
        String realAuthCode = redisService.get(REDIS_KEY_PREFIX_AUTH_CODE + telephone);
        boolean result = authCode.equals(realAuthCode);
        if (result) {
            return CommonResult.success(null, "验证码校验成功");
        } else {
            return CommonResult.failed("验证码不对");
        }

    }
}
