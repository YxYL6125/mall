package com.yxyl.springboot.service.impl;

import com.yxyl.springboot.mbg.mapper.UmsAdminMapper;
import com.yxyl.springboot.mbg.model.UmsAdmin;
import com.yxyl.springboot.mbg.model.UmsAdminExample;
import com.yxyl.springboot.service.UmsAdminService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @program: mall
 * @description:
 * @author: YxYL
 * @create: 2022-06-17 10:17
 **/
@Service
@Configuration
public class UmsAdminServiceImpl implements UmsAdminService {


    @Autowired
    private UmsAdminMapper adminMapper;


    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * 注册
     *
     * @param umsAdminParam
     * @return
     */
    @Override
    public UmsAdmin register(UmsAdmin umsAdminParam) {

        //创建一个Admin
        UmsAdmin admin = new UmsAdmin();
        BeanUtils.copyProperties(umsAdminParam, admin);//赋值
        admin.setStatus(1);//设置状态
        admin.setCreateTime(new Date());//创建时间

        //查询是否有相同用户名的admin
        UmsAdminExample example = new UmsAdminExample();
        example.createCriteria().andUsernameEqualTo(umsAdminParam.getUsername());
        List<UmsAdmin> umsAdmins = adminMapper.selectByExample(example);
        if (umsAdmins.size() > 0) {
            return null;
        }

        //加密操作
        String password = passwordEncoder().encode(umsAdminParam.getPassword());
        admin.setPassword(password);

        adminMapper.insert(admin);
        return admin;
    }
}
