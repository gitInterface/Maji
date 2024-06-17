package com.ispan.Maji.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ispan.Maji.domain.TagBean;
import com.ispan.Maji.service.TagService;

@RestController
@RequestMapping("/pages/tag")
@CrossOrigin
public class TagController {
     @Autowired
    private TagService tagService;

    @GetMapping("/gettags")
    public List<TagBean> getTags() {
        return tagService.getAllTags();
    }     
}
