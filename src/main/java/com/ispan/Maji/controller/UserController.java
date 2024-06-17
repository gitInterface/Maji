package com.ispan.Maji.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ispan.Maji.domain.UserBean;
import com.ispan.Maji.service.UserService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/users")
@CrossOrigin
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private HttpSession session;

    // 註冊
    @PostMapping("/register")
    public ResponseEntity<String> registerUser(@RequestBody UserBean user) {
        try {
            if (userService.emailExists(user.getEmail())) {
                return new ResponseEntity<>("Email已存在", HttpStatus.CONFLICT);
            }
            userService.registerUser(user);
            return new ResponseEntity<>("用戶註冊成功", HttpStatus.CREATED);
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            return new ResponseEntity<>("註冊過程中發生錯誤", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 登入
    @PostMapping("/login")
    public ResponseEntity<String> loginUser(@RequestBody UserBean user) {
        UserBean loggedInUser = userService.loginUser(user.getEmail(), user.getPassword());
        if (loggedInUser != null) {
            session.setAttribute("loggedInUser", loggedInUser); // 將用戶信息存儲到Session中
            return new ResponseEntity<>("登入成功", HttpStatus.OK);
        }
        return new ResponseEntity<>("不正確的email或密碼", HttpStatus.UNAUTHORIZED);
    }

    // 登出
    @PostMapping("/logout")
    public ResponseEntity<String> logoutUser() {
        session.invalidate(); // 清除Session
        return new ResponseEntity<>("登出成功", HttpStatus.OK);
    }

    // 獲取當前登錄的用戶
    @GetMapping("/current")
    public ResponseEntity<UserBean> getCurrentUser() {
        UserBean currentUser = (UserBean) session.getAttribute("loggedInUser");
        if (currentUser != null) {
            return new ResponseEntity<>(currentUser, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
    }

    // 顯示用戶詳情
    @GetMapping("/{userId}")
    public ResponseEntity<UserBean> viewUser(@PathVariable("userId") Integer userId) {
        UserBean loggedInUser = (UserBean) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        if (!loggedInUser.getUserID().equals(userId) && !loggedInUser.getIsAdmin()) {
            return new ResponseEntity<>(HttpStatus.FORBIDDEN);
        }

        UserBean user = userService.getUserById(userId);
        if (user != null) {
            return new ResponseEntity<>(user, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // 更新用戶資料
    @PutMapping("/{userId}")
    public ResponseEntity<UserBean> updateUser(@PathVariable Integer userId, @RequestBody UserBean user) {
        UserBean updatedUser = userService.updateUser(userId, user);
        if (updatedUser != null) {
            return new ResponseEntity<>(updatedUser, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    // 忘記密碼
    @PostMapping("/forgotPassword")
    public ResponseEntity<String> forgotPassword(@RequestBody Map<String, String> request) {
        try {
            String email = request.get("email");
            userService.forgotPassword(email);
            return new ResponseEntity<>("重置密碼的電子郵件已發送", HttpStatus.OK);
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    // 重設密碼
    @PostMapping("/resetPassword")
    public ResponseEntity<String> resetPassword(@RequestParam("token") String token,
                                                @RequestBody String newPassword) {
        try {
            userService.resetPassword(token, newPassword);
            return ResponseEntity.ok("密碼已重置");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
