package com.ispan.Maji.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ispan.Maji.domain.AdminBean;

@Repository
public interface AdminRepository extends JpaRepository<AdminBean, Integer>{
    AdminBean findByAccountAndPassword(String account, String password);
}
