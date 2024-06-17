package com.ispan.Maji.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ispan.Maji.domain.TagBean;

public interface TagRepository extends JpaRepository<TagBean, String>{
    
}
