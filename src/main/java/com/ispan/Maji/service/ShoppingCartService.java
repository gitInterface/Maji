package com.ispan.Maji.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ispan.Maji.domain.ShoppingCartBean;
import com.ispan.Maji.repository.ShoppingCartRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class ShoppingCartService {
    @Autowired
    private ShoppingCartRepository shoppingCartRepository;

    public ShoppingCartBean addToCart(ShoppingCartBean cartItem) {
        Optional<ShoppingCartBean> existingCartItem = shoppingCartRepository.findByUserIDAndProductID(cartItem.getUserID(), cartItem.getProductID());
        if (existingCartItem.isPresent()) {
            ShoppingCartBean existingItem = existingCartItem.get();
            // 累加該商品的數量
            existingItem.setNumbers(existingItem.getNumbers() + cartItem.getNumbers());
            return shoppingCartRepository.save(existingItem);
        } else {
            return shoppingCartRepository.save(cartItem);
        }
    }
}
