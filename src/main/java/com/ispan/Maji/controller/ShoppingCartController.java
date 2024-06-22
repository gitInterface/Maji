package com.ispan.Maji.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ispan.Maji.domain.ShoppingCartBean;
import com.ispan.Maji.domain.UserBean;
import com.ispan.Maji.service.ShoppingCartService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/cart")
@CrossOrigin
public class ShoppingCartController {
    @Autowired
    private ShoppingCartService shoppingCartService;

    // 新增商品進購物車
    @PostMapping("/add")
    public ResponseEntity<String> addToCart(@RequestBody ShoppingCartBean cartItem, HttpSession session) {
        // 從session中獲取當前登入的用戶
         UserBean loggedInUser = (UserBean) session.getAttribute("loggedInUser");
         if (loggedInUser == null) {
            return ResponseEntity.status(401).body("未登入");
        }
        cartItem.setUserID(loggedInUser.getUserID());
        shoppingCartService.addToCart(cartItem);
        return ResponseEntity.ok("已成功添加到購物車");
    }

    // 取得該userID所有購物車商品
    @GetMapping("/user")
    public ResponseEntity<List<ShoppingCartBean>> getUserCartItems(HttpSession session) {
        // 從session中獲取當前登入的用戶
        UserBean loggedInUser = (UserBean) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return ResponseEntity.status(401).body(null);
        }
        List<ShoppingCartBean> cartItems = shoppingCartService.getCartItemsByUserID(loggedInUser.getUserID());
        return ResponseEntity.ok(cartItems);
    }

    // 刪除某筆購物車商品
    @DeleteMapping("/delete/{cartID}")
    public ResponseEntity<String> removeFromCart(@PathVariable Integer cartID, HttpSession session) {
        // 從session中獲取當前登入的用戶
        UserBean loggedInUser = (UserBean) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return ResponseEntity.status(401).body(null);
        }
        shoppingCartService.removeFromCart(cartID);
        return ResponseEntity.ok("商品已從購物車中刪除");
    }

    // 取得結帳商品
    @PostMapping("/checkoutItems")
    public ResponseEntity<List<ShoppingCartBean>> getCheckoutItems(@RequestBody List<Integer> cartItemIds) {
        List<ShoppingCartBean> checkoutItems = shoppingCartService.getCheckoutItems(cartItemIds);
        return ResponseEntity.ok(checkoutItems);
    }

    // 刪除選定的購物車項目
    @PostMapping("/deleteSelected")
    public ResponseEntity<String> deleteSelectedCartItems(@RequestBody List<Integer> cartIDs) {
        shoppingCartService.deleteSelectedCartItems(cartIDs);
        return ResponseEntity.ok("已成功刪除選定的購物車項目");
    }
}
