package com.yxyl.springboot.service;

import com.yxyl.springboot.mbg.model.UmsAdmin;

public interface UmsAdminService {


    /**
     * 注册
     * @param umsAdminParam
     * @return
     */
    UmsAdmin register(UmsAdmin umsAdminParam);
}
