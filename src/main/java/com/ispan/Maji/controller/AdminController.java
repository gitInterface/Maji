package com.ispan.Maji.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ispan.Maji.domain.AdminBean;
import com.ispan.Maji.service.AdminService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/admin")
@CrossOrigin
public class AdminController {
    @Autowired
    private AdminService adminService;

    @Autowired
    private HttpSession session;

    @PostMapping("/login")
    public ResponseEntity<String> loginAdmin(@RequestBody AdminBean admin) {
        AdminBean loggedInAdmin = adminService.loginAdmin(admin.getAccount(), admin.getPassword());
        if (loggedInAdmin != null) {
            // 將管理員訊息儲存到Session中
            session.setAttribute("loggedInAdmin", loggedInAdmin); 
            return new ResponseEntity<>("登入成功", HttpStatus.OK);
        }
        return new ResponseEntity<>("不正確的帳號或密碼", HttpStatus.UNAUTHORIZED);
    }

    @PostMapping("/logout")
    public ResponseEntity<String> logoutAdmin() {
        session.removeAttribute("loggedInAdmin");
        return new ResponseEntity<>("登出成功", HttpStatus.OK);
    }

    @GetMapping("/current")
    public ResponseEntity<AdminBean> getCurrentAdmin() {
        AdminBean currentAdmin = (AdminBean) session.getAttribute("loggedInAdmin");
        if (currentAdmin != null) {
            return new ResponseEntity<>(currentAdmin, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
    }
}
