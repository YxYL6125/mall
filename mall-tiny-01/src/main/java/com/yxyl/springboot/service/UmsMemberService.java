package com.yxyl.springboot.service;

import com.yxyl.springboot.common.CommonResult;

public interface UmsMemberService {
    /**
     *获取验证码
     * @param telephone
     * @return
     */
    CommonResult generateAuthCode(String telephone);

    /**
     * 判断验证码是否正确
     * @param telephone
     * @param authCode
     * @return
     */
    CommonResult verifyAuthCode(String telephone, String authCode);
}
