package com.yxyl.springboot.service;

import com.yxyl.springboot.dto.UmsAdminLoginParam;
import com.yxyl.springboot.mbg.model.UmsAdmin;
import com.yxyl.springboot.mbg.model.UmsPermission;

import java.util.List;

public interface UmsAdminService {


    /**
     * 注册
     * @param umsAdminParam
     * @return
     */
    UmsAdmin register(UmsAdmin umsAdminParam);

    /**
     * 获取用户所有权限
     * @param adminId
     * @return
     */
    List<UmsPermission> getPermissionList(Long adminId);

    /**
     * 登录获取token
     * @param username
     * @param password
     * @return
     */
    String login(String username, String password);

    /**
     * 根据name获取管理员
     * @param username
     * @return
     */
    UmsAdmin getAdminByUsername(String username);
}
