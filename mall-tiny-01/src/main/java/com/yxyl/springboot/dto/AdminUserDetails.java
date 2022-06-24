package com.yxyl.springboot.dto;

import com.yxyl.springboot.mbg.model.UmsAdmin;
import com.yxyl.springboot.mbg.model.UmsPermission;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @program: mall
 * @description: SpringSecurity 所需要的用户详情
 * @author: YxYL
 * @create: 2022-06-23 10:04
 **/

public class AdminUserDetails implements UserDetails {
    private UmsAdmin admin;
    private List<UmsPermission> permissionList;

    public AdminUserDetails(UmsAdmin admin, List<UmsPermission> permissionList) {
        this.admin = admin;
        this.permissionList = permissionList;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        //返回当前用户权限信息
        //lam

        return permissionList.stream()
                .filter(umsPermission -> umsPermission.getValue()!=null)
                .map(umsPermission -> new SimpleGrantedAuthority(umsPermission.getValue()))
                .collect(Collectors.toList());
    }

    @Override
    public String getPassword() {
        return admin.getPassword();
    }

    @Override
    public String getUsername() {
        return admin.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {//是否有效
        return admin.getStatus().equals(1);
    }
}
