package com.yxyl.springboot.service;

public interface RedisService {
    /**
     * 存储数据
     * @param key
     * @param value
     */
    void set(String key, String value);

    /**
     * 设置超时时间
     * @param key
     * @param expire
     * @return
     */
    boolean expire(String key, Long expire);

    /**
     * 获取验证码
     * @param key
     * @return
     */
    String get(String key);


    /**
     * 删除键
     * @param key
     */
    void remove(String key);

    /**
     * 自增操作
     * @param key
     * @param delta
     * @return
     */
    Long increment(String key,long delta);
}
