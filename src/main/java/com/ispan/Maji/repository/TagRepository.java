package com.ispan.Maji.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ispan.Maji.domain.TagBean;

@Repository
public interface TagRepository extends JpaRepository<TagBean, String>{
    
}
