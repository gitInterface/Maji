package com.ispan.Maji.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ispan.Maji.domain.PaymentBean;

public interface PaymentRepository extends JpaRepository<PaymentBean, Integer>{
    
}
