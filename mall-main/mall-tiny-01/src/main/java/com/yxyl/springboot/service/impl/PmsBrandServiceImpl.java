package com.yxyl.springboot.service.impl;

import com.github.pagehelper.PageHelper;
import com.yxyl.springboot.mbg.mapper.PmsBrandMapper;
import com.yxyl.springboot.mbg.model.PmsBrand;
import com.yxyl.springboot.mbg.model.PmsBrandExample;
import com.yxyl.springboot.service.PmsBrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @program: mall
 * @description: 品牌管理Service
 * @author: YxYL
 * @create: 2022-06-15 10:02
 **/

@Service
public class PmsBrandServiceImpl implements PmsBrandService {

    @Autowired
    private PmsBrandMapper brandMapper;

    /**
     * 查询所有品牌
     *
     * @return
     */
    @Override
    public List<PmsBrand> listALlBrand() {
        return brandMapper.selectByExample(new PmsBrandExample());
    }

    /**
     * 创建品牌
     *
     * @param pmsBrand
     * @return
     */
    @Override
    public int creatBrand(PmsBrand pmsBrand) {
        return brandMapper.insertSelective(pmsBrand);
    }

    /**
     * 删除品牌
     *
     * @param id
     * @return
     */
    @Override
    public int deleteBrand(long id) {
        return brandMapper.deleteByPrimaryKey(id);
    }

    /**
     * 更新品牌
     *
     * @param id
     * @param pmsBrand
     * @return
     */
    @Override
    public int updateBrand(long id, PmsBrand pmsBrand) {
        pmsBrand.setId(id);
        return brandMapper.updateByPrimaryKeySelective(pmsBrand);
    }

    /**
     * 查询单个品牌
     * @param id
     * @return
     */
    @Override
    public PmsBrand getBrand(long id) {
        return brandMapper.selectByPrimaryKey(id);
    }

    /**
     * 分页查询
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public List<PmsBrand> listBrand(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        return brandMapper.selectByExample(new PmsBrandExample());
    }
}
