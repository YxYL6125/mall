package com.yxyl.springboot.service.impl;

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

    @Override
    public List<PmsBrand> listALlBrand() {
        return brandMapper.selectByExample(new PmsBrandExample());
    }
}
