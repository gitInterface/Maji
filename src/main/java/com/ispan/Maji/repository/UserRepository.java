package com.ispan.Maji.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ispan.Maji.domain.UserBean;

@Repository
public interface UserRepository extends JpaRepository<UserBean, Integer>{

    Optional<UserBean> findByEmail(String email);

}