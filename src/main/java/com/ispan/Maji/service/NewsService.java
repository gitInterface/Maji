package com.ispan.Maji.service;

import java.util.Base64;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.ispan.Maji.domain.NewsBean;
import com.ispan.Maji.repository.NewsRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class NewsService {
    @Autowired
    private NewsRepository newsRepository;

    // 保存最新消息
    public NewsBean saveNews(NewsBean news) {
        return newsRepository.save(news);
    }

    // 查詢所有最新消息(停用)
    public List<NewsBean> getAllNews() {
        return newsRepository.findAll().stream()
                .map(this::convertPictureToBase64)
                .collect(Collectors.toList());
    }

    // 查詢所有最新消息(Page)
    public Page<NewsBean> getAllNews(int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
        return newsRepository.findAll(pageable);
    }

    // 轉換Bytes陣列成Base64
    private NewsBean convertPictureToBase64(NewsBean news) {
        if (news.getPicture() != null) {
            news.setPictureBase64(Base64.getEncoder().encodeToString(news.getPicture()));
        }
        return news;
    }

    // 根據ID查詢最新消息
    public Optional<NewsBean> getNewsById(Integer id) {
        Optional<NewsBean> newsOpt = newsRepository.findById(id);
        newsOpt.ifPresent(news -> {
            news.setPictureBase64(news.getPictureBase64());
        });
        return newsOpt;    
    }

    // 刪除最新消息
    public void deleteNews(Integer id) {
        newsRepository.deleteById(id);
    }
}
