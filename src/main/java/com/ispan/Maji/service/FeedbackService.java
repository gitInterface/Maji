package com.ispan.Maji.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ispan.Maji.domain.FeedbackBean;
import com.ispan.Maji.repository.FeedbackRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class FeedbackService {
    @Autowired
    private FeedbackRepository feedbackRepository;

    // 保存反饋
    public FeedbackBean saveFeedback(FeedbackBean feedback) {
        return feedbackRepository.save(feedback);
    }

    // 刪除反饋
    public void deleteFeedback(Integer feedbackID) {
        if (feedbackRepository.existsById(feedbackID)) {
            feedbackRepository.deleteById(feedbackID);
        } else {
            throw new IllegalArgumentException("找不到反饋");
        }
    }

    // 查詢所有反饋
    public List<FeedbackBean> getAllFeedbacks() {
        return feedbackRepository.findAll();
    }

    // 查詢特定用戶的所有反饋
    public List<FeedbackBean> getFeedbacksByUserId(Integer userID) {
        return feedbackRepository.findByUserID(userID);
    }

    // 查詢單個反饋
    public FeedbackBean getFeedbackById(Integer feedbackID) {
        Optional<FeedbackBean> feedback = feedbackRepository.findById(feedbackID);
        if (feedback.isPresent()) {
            return feedback.get();
        } else {
            throw new IllegalArgumentException("找不到反饋");
        }
    }
}
