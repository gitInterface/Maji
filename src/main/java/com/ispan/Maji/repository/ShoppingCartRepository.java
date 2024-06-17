package com.ispan.Maji.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ispan.Maji.domain.ShoppingCartBean;

public interface ShoppingCartRepository extends JpaRepository<ShoppingCartBean, Integer>{
    
}
