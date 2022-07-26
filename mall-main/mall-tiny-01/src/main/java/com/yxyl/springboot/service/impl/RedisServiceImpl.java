package com.yxyl.springboot.service.impl;

import com.yxyl.springboot.service.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * @program: mall
 * @description:
 * @author: YxYL
 * @create: 2022-06-17 08:48
 **/
@Service
public class RedisServiceImpl implements RedisService {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;


    /**
     * 存储数据
     *
     * @param key
     * @param value
     */
    @Override
    public void set(String key, String value) {
        stringRedisTemplate.opsForValue().set(key, value);
    }

    /**
     * 设置超时时间
     * @param key
     * @param expire
     * @return
     */
    @Override
    public boolean expire(String key, Long expire) {
        return stringRedisTemplate.expire(key,expire,TimeUnit.SECONDS);
    }

    /**
     * 获取验证码
     * @param key
     * @return
     */
    @Override
    public String get(String key) {
        return stringRedisTemplate.opsForValue().get(key);
    }

    /**
     * 删除键
     * @param key
     */
    @Override
    public void remove(String key) {stringRedisTemplate.delete(key);}

    /**
     * 自增操作
     * @param key
     * @param delta
     * @return
     */
    @Override
    public Long increment(String key, long delta) {
        return stringRedisTemplate.opsForValue().increment(key,delta);
    }
}
