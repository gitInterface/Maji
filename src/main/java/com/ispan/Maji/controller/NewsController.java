package com.ispan.Maji.controller;

import java.util.Base64;
import java.util.Date;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import com.ispan.Maji.domain.NewsBean;
import com.ispan.Maji.service.NewsService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/news")
@CrossOrigin
public class NewsController {
    @Autowired
    private NewsService newsService;

    // 新增最新消息
    @PostMapping("/add")
    public ResponseEntity<?> addNews(@RequestParam("title") String title,
                                     @RequestParam("content") String content,
                                     @RequestParam(value = "picture", required = false) String picture,
                                     @RequestParam("adminID") Integer adminID) {
        try {
            NewsBean news = new NewsBean();
            news.setTitle(title);
            news.setContent(content);
            news.setAdminID(adminID);

            // 當接收到的 picture 為非空時，將其轉換為 byte[]
            if (picture != null && !picture.isEmpty()) {
                news.setPicture(Base64.getDecoder().decode(picture));
            }

            NewsBean savedNews = newsService.saveNews(news);
            return new ResponseEntity<>(savedNews, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>("新增最新消息時發生錯誤: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 查詢所有最新消息
    @GetMapping("/all")
    public ResponseEntity<Page<NewsBean>> getAllNews(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "6") int size) {
        Page<NewsBean> newsPage = newsService.getAllNews(page, size);
        return new ResponseEntity<>(newsPage, HttpStatus.OK);
    }

    // 根據ID查詢最新消息
    @GetMapping("/{id}")
    public ResponseEntity<NewsBean> getNewsById(@PathVariable Integer id) {
        Optional<NewsBean> news = newsService.getNewsById(id);
        if (news.isPresent()) {
            return ResponseEntity.ok(news.get());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    // 刪除最新消息
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteNews(@PathVariable Integer id) {
        try {
            newsService.deleteNews(id);
            return ResponseEntity.ok("消息已刪除");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("刪除最新消息時發生錯誤: " + e.getMessage());
        }
    }

    // 更新最新消息
    @PutMapping("/update/{id}")
    public ResponseEntity<?> updateNews(@PathVariable Integer id,
                                        @RequestParam("title") String title,
                                        @RequestParam("content") String content,
                                        @RequestParam(value = "picture", required = false) String picture,
                                        HttpSession session) {
        try {
            // 查找要更新的最新訊息
            Optional<NewsBean> newsOpt = newsService.getNewsById(id);
            if (newsOpt.isPresent()) {
                NewsBean news = newsOpt.get();
                // 更新訊息標題和内容
                news.setTitle(title);
                news.setContent(content);
                news.setCreatedAt(new Date());

                // 如果圖片存在且不為空，則將其解碼並設置到新聞對象中
                if (picture != null && !picture.isEmpty()) {
                    news.setPicture(Base64.getDecoder().decode(picture));
                }else{
                    news.setPicture(null);
                }

                // 保存更新後的最新消息
                NewsBean updatedNews = newsService.saveNews(news);
                return ResponseEntity.ok(updatedNews);
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("消息未找到");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("更新最新消息時發生錯誤: " + e.getMessage());
        }
    }
}
