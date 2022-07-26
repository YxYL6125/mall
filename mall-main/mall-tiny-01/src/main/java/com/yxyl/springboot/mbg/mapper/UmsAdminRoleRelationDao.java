package com.yxyl.springboot.mbg.mapper;

import com.yxyl.springboot.mbg.model.UmsPermission;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @program: mall
 * @description: 后台用户与角色管理Dao
 * @author: YxYL
 * @create: 2022-06-23 08:22
 **/
@Component
public interface UmsAdminRoleRelationDao {

    /**
     *获取用户所有权限信息
     * @param adminId
     * @return
     */
    List<UmsPermission> getPermissionList(@Param("adminId")Long adminId);

}
