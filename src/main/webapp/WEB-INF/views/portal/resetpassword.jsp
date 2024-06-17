<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>重設密碼</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const token = urlParams.get('token');

        document.getElementById('resetPasswordForm').addEventListener('submit', function(event) {
            event.preventDefault();
            var newPassword = document.getElementById('newPassword').value;

            axios.post('${pageContext.request.contextPath}/api/users/resetPassword?token=' + token, newPassword, {
                headers: {
                    'Content-Type': 'text/plain'
                }
            }).then(function(response) {
                Swal.fire('成功!', response.data, 'success')
                    .then(function() {
                        // 重定向到登入頁面
                        window.location.href = '/portal/login';
                    });
            }).catch(function(error) {
                Swal.fire('失敗!', error.response.data, 'error');
            });
        });
    }
    </script>
    <style>
        /* 重設密碼外框 */
        .reset-password-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        /* 重設密碼標題 */
        .reset-password-title {
            text-align: center;
            margin-bottom: 20px;
        }
        /* input css */
        .form-control {
            width: 100%;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>

    <div class="container">
        <div class="reset-password-container"> 
            <h2 class="reset-password-title">重置密碼</h2>
            <form id="resetPasswordForm">
                <div class="mb-3">
                    <label for="newPassword" class="form-label">新密碼</label>
                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                </div>
                <button type="submit" class="btn btn-warning btn-block">提交</button>
            </form>
        </div>
    </div>
</body>
</html>