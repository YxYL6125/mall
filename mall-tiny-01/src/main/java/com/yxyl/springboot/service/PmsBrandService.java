package com.yxyl.springboot.service;

import com.yxyl.springboot.mbg.model.PmsBrand;

import java.util.List;

public interface PmsBrandService {
    /**
     * 查询所有品牌
     * @return
     */
    List<PmsBrand> listALlBrand();

    /**
     * 创建品牌
     * @param pmsBrand
     * @return
     */
    int creatBrand(PmsBrand pmsBrand);

    /**
     * 删除品牌
     * @param id
     * @return
     */
    int deleteBrand(long id);

    /**
     * 更新品牌
     * @param id
     * @param pmsBrand
     * @return
     */
    int updateBrand(long id, PmsBrand pmsBrand);

    /**
     * 查询单个品牌
     * @param id
     * @return
     */
    PmsBrand getBrand(long id);

    /**
     * 分页查询
     * @param pageNum
     * @param pageSize
     * @return
     */
    List<PmsBrand> listBrand(Integer pageNum, Integer pageSize);
}
