<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>註冊</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
    $(document).ready(function() {
        function checkPasswordMatch() {
            var password = $('#password').val();
            var confirmPassword = $('#confirmPassword').val();

            if (password !== confirmPassword) {
                $('#passwordMatchMessage').text('密碼不一致');
            } else {
                $('#passwordMatchMessage').text('');
            }
        }

        $('#confirmPassword').on('keyup', checkPasswordMatch);

        $('#registerForm').submit(function(event) {
            event.preventDefault(); 

            if ($('#passwordMatchMessage').text() !== '') {
                Swal.fire('註冊失敗!', '請確保密碼一致', 'error');
                return;
            }

            var formData = {
                email: $('#email').val(),
                password: $('#password').val(),
                name: $('#name').val(),
                gender: $('#gender').val(),
                phone: $('#phone').val(),
                birth: $('#birth').val(),
                isAdmin: false // 默認設置為 false
            };

            axios.post('/api/users/register', formData)
                .then(function(response) {
                    Swal.fire('註冊成功!', response.data, 'success')
                    .then(function() {
                        // 重定向到 login.jsp
                        window.location.href = '/portal/login';
                    });
                })
                .catch(function(error) {
                    if (error.response && error.response.status === 409) {
                        Swal.fire('註冊失敗!', 'Email 已經存在', 'error');
                    } else if (error.response && error.response.status === 400) {
                        Swal.fire('註冊失敗!', error.response.data, 'error');
                    } else {
                        Swal.fire('註冊失敗!', '發生錯誤，請稍後再試', 'error');
                    }
                });
        });
    });
    </script>
    <style>
        .form-container {
            border: 1px solid #ddd;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 8px;
            width: 60%; /* 調整最大寬度 */
            margin: auto; /* 居中對齊 */
        }
        .form-control {
            max-width: 100%;
        }
        /* 縮小輸入框和選擇框的寬度 */
        .form-group input,
        .form-group select {
            width: 100%;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>

    <div class="container mt-5 d-flex justify-content-center">
        <div class="form-container">
            <h2>註冊</h2>
            <form id="registerForm">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">密碼</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">確認密碼</label> 
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    <!-- 顯示密碼不一致的提示 -->
                    <span id="passwordMatchMessage" style="color: red;"></span> 
                </div>
                <div class="form-group">
                    <label for="name">姓名</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="gender">性別</label>
                    <select class="form-control" id="gender" name="gender" required>
                        <option>男性</option>
                        <option>女性</option>
                        <option>其他</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="phone">電話</label>
                    <input type="text" class="form-control" id="phone" name="phone" required>
                </div>
                <div class="form-group">
                    <label for="birth">生日</label>
                    <input type="date" class="form-control" id="birth" name="birth" required>
                </div>
                <button type="submit" class="btn btn-danger">註冊</button>
            </form>
        </div>
    </div>
</body>
</html>
