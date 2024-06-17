package com.ispan.Maji.service;

import java.util.Date;
import java.util.Optional;
import java.util.UUID;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ispan.Maji.domain.ResetPasswordTokenBean;
import com.ispan.Maji.domain.UserBean;
import com.ispan.Maji.repository.ResetPasswordTokenRepository;
import com.ispan.Maji.repository.UserRepository;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private HttpSession session;

    @Autowired
    private ResetPasswordTokenRepository resetPasswordTokenRepository;

    @Autowired
    private EmailService emailService;

    // 正則表達式用於驗證 email 格式
    private static final String EMAIL_PATTERN = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final Pattern pattern = Pattern.compile(EMAIL_PATTERN);
    // 正則表達式，假設電話號碼是10位數字，驗證電話格式
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$"); 

    // 用戶註冊
    public UserBean registerUser(UserBean user) {
        validateRegisterUser(user);
        return userRepository.save(user);
    }

    // 驗證註冊用戶數據
    private void validateRegisterUser(UserBean user) {
        if (user.getEmail() == null || user.getEmail().isEmpty()) {
            throw new IllegalArgumentException("Email不能為空");
        }

        if (!pattern.matcher(user.getEmail()).matches()) {
            throw new IllegalArgumentException("Email格式不正確");
        }

        if (user.getPassword() == null || user.getPassword().isEmpty()) {
            throw new IllegalArgumentException("密碼不能為空");
        }

        if (user.getPhone() == null || user.getPhone().isEmpty()) {
            throw new IllegalArgumentException("電話不能為空");
        }

        if (!PHONE_PATTERN.matcher(user.getPhone()).matches()) {
            throw new IllegalArgumentException("電話格式不正確");
        }
        // 這裡可以添加更多的驗證邏輯，如檢查其他必填字段
    }

    // 查詢email是否存在
    public boolean emailExists(String email) {
        if(!email.equals(null)){
            return userRepository.findByEmail(email).isPresent();
        }
        return false;
    }

    // 用戶登入
    public UserBean loginUser(String email, String password) {
        Optional<UserBean> optionalUser = userRepository.findByEmail(email);
        if (optionalUser.isPresent()) {
            UserBean user = optionalUser.get();
            if (user.getPassword().equals(password)) {
                session.setAttribute("loggedInUser", user);
                return user;
            }
        }
        return null;
    }

    // 用戶登出
    public void logoutUser() {
        session.invalidate();
    }

    // 更新用戶資料
    public UserBean updateUser(Integer userId, UserBean user) {
        Optional<UserBean> existingUser = userRepository.findById(userId);
        if (existingUser.isPresent()) {
            UserBean updatedUser = existingUser.get();
            // 後端驗證
            validateUpdateUser(user); 
            updatedUser.setPassword(user.getPassword());
            updatedUser.setName(user.getName());
            updatedUser.setGender(user.getGender());
            updatedUser.setPhone(user.getPhone());
            updatedUser.setBirth(user.getBirth());
            updatedUser.setImage(user.getImage());
            return userRepository.save(updatedUser);
        } else {
            throw new IllegalArgumentException("找不到使用者");
        }
    }

    // 驗證更新用戶數據
    private void validateUpdateUser(UserBean user) {
        if (user.getPassword() == null || user.getPassword().isEmpty()) {
            throw new IllegalArgumentException("密碼不能為空");
        }

        if (user.getName() == null || user.getName().isEmpty()) {
            throw new IllegalArgumentException("姓名不能為空");
        }

        if (user.getPhone() == null || !user.getPhone().matches("^[0-9]{10}$")) {
            throw new IllegalArgumentException("電話號碼格式不正確");
        }

        if (user.getBirth() == null || user.getBirth().after(new Date())) {
            throw new IllegalArgumentException("生日不能是未來的日期");
        }
    }

    // 獲取用戶通過ID
    public UserBean getUserById(Integer userId) {
        Optional<UserBean> user = userRepository.findById(userId);
        return user.orElse(null);
    }

    // 忘記密碼
    public void forgotPassword(String email) {
        Optional<UserBean> user = userRepository.findByEmail(email);
        if (!user.isPresent()) {
            throw new IllegalArgumentException("該電子郵件不存在");
        }

        UserBean userBean = user.get();

        String token = UUID.randomUUID().toString();
        ResetPasswordTokenBean resetPasswordToken = new ResetPasswordTokenBean();
        resetPasswordToken.setToken(token);
        resetPasswordToken.setExpiryDate(calculateExpiryDate());
        resetPasswordToken.setUserID(userBean.getUserID());

        resetPasswordTokenRepository.save(resetPasswordToken);

        String resetLink = "http://localhost:8080/portal/resetpassword?token=" + token;
        emailService.sendEmail(email, "重置密碼", "點擊以下鏈接重置您的密碼: " + resetLink);
    }

    // 計算token有效期
    private Date calculateExpiryDate() {
        // 設置有效期，例如24小時
        long expiryTime = System.currentTimeMillis() + 24 * 60 * 60 * 1000;
        return new Date(expiryTime);
    }

    // 重設密碼
    public void resetPassword(String token, String newPassword) {
        ResetPasswordTokenBean resetPasswordToken = resetPasswordTokenRepository.findByToken(token)
                .orElseThrow(() -> new IllegalArgumentException("無效的重置密碼令牌"));

        if (resetPasswordToken.getExpiryDate().before(new Date())) {
            throw new IllegalArgumentException("重置密碼令牌已過期");
        }

        UserBean user = userRepository.findById(resetPasswordToken.getUserID())
                .orElseThrow(() -> new IllegalArgumentException("用戶不存在"));

        user.setPassword(newPassword);
        userRepository.save(user);
    }
}
