package com.ispan.Maji.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ispan.Maji.domain.UserBean;

public interface UserRepository extends JpaRepository<UserBean, Integer>{

    Optional<UserBean> findByEmail(String email);

}