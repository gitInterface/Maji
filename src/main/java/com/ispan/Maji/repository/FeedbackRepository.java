package com.ispan.Maji.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ispan.Maji.domain.FeedbackBean;

public interface FeedbackRepository extends JpaRepository<FeedbackBean, Integer>{
    List<FeedbackBean> findByUserID(Integer userID);
}
