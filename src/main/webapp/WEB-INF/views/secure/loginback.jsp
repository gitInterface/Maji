<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
        window.onload = function() {
        document.getElementById('loginForm').addEventListener('submit', function(event) {
            event.preventDefault();
            var account = document.getElementById('account').value;
            var password = document.getElementById('password').value;

            axios.post('${pageContext.request.contextPath}/api/admin/login', {
                account: account,
                password: password
            }).then(function(response) {
                Swal.fire('登入成功!', response.data, 'success')
                    .then(function() {
                        // 重定向到首頁或其他頁面
                        window.location.href = '/secure/productview';
                    });
            }).catch(function(error) {
                Swal.fire('登入失敗!', error.response.data, 'error');
            });
        });
    }
    </script>
    <style>
        /* 背景圖片 */
        body{
            background-image: url('${pageContext.request.contextPath}/image/index-background.jpg');
            background-repeat: no-repeat;
            background-size: cover;
        }
        /* 登入邊框和陰影效果 */
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
        /* 登入標題 */
        .login-title {
            text-align: center;
            margin-bottom: 20px;
        }
        /* input css*/
        .form-control {
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container"> 
            <h2 class="login-title">登入</h2>
            <form id="loginForm">
                <div class="mb-3">
                    <label for="text" class="form-label">帳號</label>
                    <input type="text" class="form-control" id="account" name="account" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">密碼</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <button type="submit" class="btn btn-warning btn-block">登入</button>
            </form>
        </div>
    </div>
</body>
</html>