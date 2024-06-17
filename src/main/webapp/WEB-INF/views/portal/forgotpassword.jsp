<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>忘記密碼</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
     window.onload = function() {
        document.getElementById('forgotPasswordForm').addEventListener('submit', function(event) {
            event.preventDefault();
            var email = document.getElementById('email').value;

            axios.post('${pageContext.request.contextPath}/api/users/forgotPassword', {
                email: email
            }).then(function(response) {
                Swal.fire('成功!', '請檢查你的電子郵件以重置密碼', 'success');
            }).catch(function(error) {
                Swal.fire('失敗!', '該電子郵件不存在', 'error');
            });
        });
    }
    </script>
    <style>
        /* 忘記密碼邊框 */
        .forgot-password-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        /* 忘記密碼標題 */
        .forgot-password-title {
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
        <div class="forgot-password-container"> 
            <h2 class="forgot-password-title">忘記密碼</h2>
            <form id="forgotPasswordForm">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <button type="submit" class="btn btn-warning btn-block">送出</button>
            </form>
        </div>
    </div>
</body>
</html>