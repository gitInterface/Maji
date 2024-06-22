package com.ispan.Maji.service;

import java.util.Base64;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ispan.Maji.domain.ProductBean;
import com.ispan.Maji.domain.ShoppingCartBean;
import com.ispan.Maji.repository.ShoppingCartRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class ShoppingCartService {
    @Autowired
    private ShoppingCartRepository shoppingCartRepository;

    // 加入購物車邏輯
    public ShoppingCartBean addToCart(ShoppingCartBean cartItem) {
        Optional<ShoppingCartBean> existingCartItem = shoppingCartRepository.findByUserIDAndProductID(cartItem.getUserID(), cartItem.getProductID());
        // 檢查購物車中是否已經有此商品，如果有，更新數量
        if (existingCartItem.isPresent()) {
            ShoppingCartBean existingItem = existingCartItem.get();
            // 累加該商品的數量
            existingItem.setNumbers(existingItem.getNumbers() + cartItem.getNumbers());
            return shoppingCartRepository.save(existingItem);
        } else {
            return shoppingCartRepository.save(cartItem);
        }
    }

    // 從userID取得所有購物車商品
    public List<ShoppingCartBean> getCartItemsByUserID(int userID) {
        List<ShoppingCartBean> cartItems = shoppingCartRepository.findByUserID(userID);
        return cartItems.stream()
                .map(this::convertProductToBase64)
                .collect(Collectors.toList());
    }

    // 將圖片轉換為Base64
    private ShoppingCartBean convertProductToBase64(ShoppingCartBean cartItem) {
        ProductBean product = cartItem.getProduct();
        if (product != null && product.getPicture() != null) {
            product.setPictureBase64(Base64.getEncoder().encodeToString(product.getPicture()));
        }
        return cartItem;
    }

    // 刪除某筆購物車資訊
    public void removeFromCart(Integer cartID) {
        shoppingCartRepository.deleteById(cartID);
    }

    // 取得結帳商品
    public List<ShoppingCartBean> getCheckoutItems(List<Integer> cartItemIds) {
        List<ShoppingCartBean> checkoutItems = shoppingCartRepository.findAllById(cartItemIds);
        return checkoutItems.stream().map(this::convertProductToBase64).collect(Collectors.toList());
    }

    // 刪除選定的購物車項目
    public void deleteSelectedCartItems(List<Integer> cartIDs) {
        shoppingCartRepository.deleteAllById(cartIDs);
    }
}
