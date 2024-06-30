package com.ispan.Maji.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ispan.Maji.domain.NewsBean;

@Repository
public interface NewsRepository extends JpaRepository<NewsBean, Integer>{
    
}
