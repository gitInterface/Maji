package com.ispan.Maji.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ispan.Maji.domain.AdminBean;
import com.ispan.Maji.repository.AdminRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class AdminService {
    @Autowired
    private AdminRepository adminRepository;

    public AdminBean loginAdmin(String account, String password) {
        AdminBean admin = adminRepository.findByAccountAndPassword(account, password);
        if (admin != null) {
            return admin;
        }
        return null;
    }
}
