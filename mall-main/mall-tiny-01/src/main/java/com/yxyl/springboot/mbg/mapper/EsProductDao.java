package com.yxyl.springboot.mbg.mapper;

import com.yxyl.springboot.nosql.elasticsearch.document.EsProduct;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface EsProductDao {
    List<EsProduct> getAllEsProductList(Object o);
}
