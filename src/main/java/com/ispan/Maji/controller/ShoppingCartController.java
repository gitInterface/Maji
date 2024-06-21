package com.ispan.Maji.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ispan.Maji.domain.ShoppingCartBean;
import com.ispan.Maji.service.ShoppingCartService;

@RestController
@RequestMapping("/api/cart")
@CrossOrigin
public class ShoppingCartController {
    @Autowired
    private ShoppingCartService shoppingCartService;

    @PostMapping("/add")
    public ResponseEntity<String> addToCart(@RequestBody ShoppingCartBean cartItem) {
        shoppingCartService.addToCart(cartItem);
        return ResponseEntity.ok("商品已成功添加到購物車");
    }
}
