package com.yxyl.springboot.service.impl;

import com.yxyl.springboot.mbg.mapper.EsProductDao;
import com.yxyl.springboot.nosql.elasticsearch.document.EsProduct;
import com.yxyl.springboot.nosql.elasticsearch.repository.EsProductRepository;
import com.yxyl.springboot.service.EsProductService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Iterator;
import java.util.List;

/**
 * @program: mall-tiny-01
 * @description:
 * @author: YxYL
 * @create: 2022-07-26 14:37
 **/
@Service
public class EsProductServiceImpl implements EsProductService {

    private static final Logger LOGGER = LoggerFactory.getLogger(EsProductServiceImpl.class);
    @Autowired
    private EsProductDao productDao;
    @Autowired
    private EsProductRepository productRepository;
    
    @Override
    public int importAll() {
        List<EsProduct> esProductList = productDao.getAllEsProductList(null);//数据库取出
        Iterable<EsProduct> esProductIterable = productRepository.saveAll(esProductList);//存入ElasticSearch
        Iterator<EsProduct> iterator = esProductIterable.iterator();//迭代获得操作值
        int result = 0;
        while (iterator.hasNext()) {
            result++;
            iterator.next();
        }
        return result;
    }
}
