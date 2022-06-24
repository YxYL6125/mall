package com.yxyl.springboot.service.impl;

import com.yxyl.springboot.dto.UmsAdminLoginParam;
import com.yxyl.springboot.mbg.mapper.UmsAdminRoleRelationDao;
import com.yxyl.springboot.mbg.mapper.UmsAdminMapper;
import com.yxyl.springboot.mbg.model.UmsAdmin;
import com.yxyl.springboot.mbg.model.UmsAdminExample;
import com.yxyl.springboot.mbg.model.UmsPermission;
import com.yxyl.springboot.service.UmsAdminService;
import com.yxyl.springboot.utils.JwtTokenUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
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
    private static final Logger LOGGER = LoggerFactory.getLogger(UmsAdminServiceImpl.class);

    @Autowired
    private UmsAdminMapper adminMapper;

    @Autowired
    private UmsAdminRoleRelationDao adminRoleRelationDao;
    @Autowired
    private UserDetailsService userDetailsService;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;

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

    /**
     * 获取用户所有权限信息
     *
     * @param adminId
     * @return
     */
    @Override
    public List<UmsPermission> getPermissionList(Long adminId) {
        return adminRoleRelationDao.getPermissionList(adminId);
    }

    @Override
    public String login(String username, String password) {
        String token = null;
        try {
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);
            if (!passwordEncoder().matches(password, userDetails.getPassword())) {//密码不匹配
                throw new RuntimeException("密码错误");
            }
            UsernamePasswordAuthenticationToken authenticationToken
                    = new UsernamePasswordAuthenticationToken(userDetails,
                    null,
                    userDetails.getAuthorities());

            SecurityContextHolder.getContext().setAuthentication(authenticationToken);
            token = jwtTokenUtil.generateToken(userDetails);
        } catch (RuntimeException e) {
            LOGGER.warn("登录异常:{}", e.getMessage());
        }
        return token;
    }

    /**
     * 根据name获取管理员
     * @param username
     * @return
     */
    @Override
    public UmsAdmin getAdminByUsername(String username) {
        UmsAdminExample example = new UmsAdminExample();
        example.createCriteria().andUsernameEqualTo(username);
        List<UmsAdmin> umsAdmins = adminMapper.selectByExample(example);
        if (umsAdmins != null && umsAdmins.size() > 0) {
            return umsAdmins.get(0);
        }
        return null;
    }


}
