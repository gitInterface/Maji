package com.ispan.Maji.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ispan.Maji.domain.ShoppingCartBean;

@Repository
public interface ShoppingCartRepository extends JpaRepository<ShoppingCartBean, Integer>{
    Optional<ShoppingCartBean> findByUserIDAndProductID(Integer userID, Integer productID);

    List<ShoppingCartBean> findByUserID(int userID);
    
    Optional<ShoppingCartBean> findByUserIDAndProductID(int userID, int productID);
}
