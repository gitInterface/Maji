package com.ispan.Maji.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ispan.Maji.domain.ResetPasswordTokenBean;

public interface ResetPasswordTokenRepository extends JpaRepository<ResetPasswordTokenBean, Integer>{
    Optional<ResetPasswordTokenBean> findByToken(String token);
}
