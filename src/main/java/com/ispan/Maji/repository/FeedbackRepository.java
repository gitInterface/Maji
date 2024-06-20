package com.ispan.Maji.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ispan.Maji.domain.FeedbackBean;

@Repository
public interface FeedbackRepository extends JpaRepository<FeedbackBean, Integer>{
    List<FeedbackBean> findByUserID(Integer userID);
}
