package com.yxyl.springboot.utils;

/**
 * @program: mall
 * @description: 系统工具类
 * @author: YxYL
 * @create: 2022-06-17 09:04
 **/

public class SystemUtil {

    /**
     * 是否为NULL
     * @param obj
     * @return
     */
    public static boolean isNull(Object obj) {
        return null == obj ? true : false;
    }


    /**
     * 是否为null||空字符
     * @param str
     * @return
     */
    public static boolean isNullOrEmpty(String str){
        return null==str||str.equals("");
    }
}
