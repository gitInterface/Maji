package com.ispan.Maji.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ispan.Maji.domain.TagBean;
import com.ispan.Maji.repository.TagRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class TagService {
    @Autowired
    private TagRepository tagRepository;

    public List<TagBean> getAllTags() {
        return tagRepository.findAll();
    }

    public TagBean getTagById(String id) {
        return tagRepository.findById(id).orElse(null);
    }

    public void saveTag(TagBean tag) {
        tagRepository.save(tag);
    }

    public void deleteTag(String id) {
        tagRepository.deleteById(id);
    }
}
