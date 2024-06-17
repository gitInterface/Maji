package com.ispan.Maji.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ispan.Maji.domain.ProductBean;

public interface ProductRepository extends JpaRepository<ProductBean, Integer>{
    List<ProductBean> findByProductNameContainingIgnoreCaseOrDiscriptionContainingIgnoreCaseOrTagContainingIgnoreCase(String productName, String discription, String tag);

    List<ProductBean> findByPrice(int price);

     // 分頁查詢方法
     Page<ProductBean> findAll(Pageable pageable);
}
