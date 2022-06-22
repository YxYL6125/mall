package com.yxyl.springboot.filter;

import com.yxyl.springboot.utils.JwtTokenUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @program: mall
 * @description: JWT过滤器
 * @author: YxYL
 * @create: 2022-06-22 18:07
 **/
@Component
public class JwtAuthenticationTokenFilter extends OncePerRequestFilter {

    private static final Logger LOGGER = LoggerFactory.getLogger(JwtAuthenticationTokenFilter.class);
    @Autowired
    private UserDetailsService userDetailsService;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Value("${jwt.tokenHead}")
    private String tokenHead;//JWT负载中拿到开头
    @Value("${jwt.tokenHeader}")
    private String tokenHeader;//JWT存储的请求头


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String authHeader = request.getHeader(this.tokenHeader);
        if (authHeader != null && authHeader.startsWith(this.tokenHeader)) {//authHeader不为空&&以请求头开始
            String authToken = authHeader.substring(this.tokenHead.length());
            String userName = jwtTokenUtil.getUserNameFromToken(authToken);//获取userName
            LOGGER.info("userName:{}" + userName);

            if (userName != null && SecurityContextHolder.getContext().getAuthentication() == null) {//username不为空，获取权限为空
                UserDetails userDetails = this.userDetailsService.loadUserByUsername(userName);
                if (jwtTokenUtil.validateToken(userName, userDetails)) {//验证token是否还有效
                    UsernamePasswordAuthenticationToken authenticationToken = new
                            UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                    authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    LOGGER.info("authentication user:{}" + userName);
                    SecurityContextHolder.getContext().setAuthentication(authenticationToken);//添加权限
                }

            }

        }
        filterChain.doFilter(request, response);//过滤
    }
}
