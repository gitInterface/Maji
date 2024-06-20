package com.ispan.Maji.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ispan.Maji.domain.PaymentBean;

@Repository
public interface PaymentRepository extends JpaRepository<PaymentBean, Integer>{
    
}
