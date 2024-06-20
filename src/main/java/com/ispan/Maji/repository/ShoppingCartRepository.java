package com.ispan.Maji.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ispan.Maji.domain.ShoppingCartBean;

@Repository
public interface ShoppingCartRepository extends JpaRepository<ShoppingCartBean, Integer>{
    
}
