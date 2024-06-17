package com.ispan.Maji.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ispan.Maji.domain.FeedbackBean;
import com.ispan.Maji.domain.UserBean;
import com.ispan.Maji.service.FeedbackService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/feedback")
@CrossOrigin
public class FeedbackController {
    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private HttpSession session;

    @PostMapping("/submit")
    public ResponseEntity<String> submitFeedback(@RequestBody FeedbackBean feedback) {
        try {
            UserBean currentUser = (UserBean) session.getAttribute("loggedInUser");
            if (currentUser == null) {
                return new ResponseEntity<>("用戶未登入", HttpStatus.UNAUTHORIZED);
            }

            feedbackService.saveFeedback(feedback);
            return new ResponseEntity<>("回饋送出成功", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("回饋送出失敗", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/delete/{feedbackID}")
    public ResponseEntity<String> deleteFeedback(@PathVariable Integer feedbackID) {
        feedbackService.deleteFeedback(feedbackID);
        return new ResponseEntity<>("Feedback deleted successfully", HttpStatus.OK);
    }

    @GetMapping("/all")
    public ResponseEntity<List<FeedbackBean>> getAllFeedbacks() {
        List<FeedbackBean> feedbacks = feedbackService.getAllFeedbacks();
        return new ResponseEntity<>(feedbacks, HttpStatus.OK);
    }

    @GetMapping("/user/{userID}")
    public ResponseEntity<List<FeedbackBean>> getFeedbacksByUserId(@PathVariable Integer userID) {
        List<FeedbackBean> feedbacks = feedbackService.getFeedbacksByUserId(userID);
        return new ResponseEntity<>(feedbacks, HttpStatus.OK);
    }

    @GetMapping("/{feedbackID}")
    public ResponseEntity<FeedbackBean> getFeedbackById(@PathVariable Integer feedbackID) {
        FeedbackBean feedback = feedbackService.getFeedbackById(feedbackID);
        return new ResponseEntity<>(feedback, HttpStatus.OK);
    }
}
