package com.yxyl.springboot.common;

import java.util.List;

import com.github.pagehelper.PageInfo;

/**
 * @program: mall
 * @description: 分页数据封装类
 * @author: YxYL
 * @create: 2022-06-15 20:07
 **/

public class CommonPage<T> {

    private Integer totalPage;
    private Integer pageNum;
    private Integer pageSize;
    private Long total;
    private List<T> list;


    /**
     * 将PageHelper分页后的List转为分页信息
     * @param list
     * @return
     * @param <T>
     */
    public static <T> CommonPage<T> restPage(List<T> list) {
        CommonPage result = new CommonPage();
        PageInfo pageInfo = new PageInfo(list);
        result.setList(pageInfo.getList());
        result.setPageNum(pageInfo.getPageNum());
        result.setTotal(pageInfo.getTotal());
        result.setTotalPage(pageInfo.getNextPage());
        result.setPageSize(pageInfo.getPageSize());
        return result;
    }


    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}
