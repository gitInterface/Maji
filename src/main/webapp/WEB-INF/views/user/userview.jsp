<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用戶訊息</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const userId = urlParams.get('userId');
            
            axios.get('/api/users/current')
                .then(function(response) {
                    const currentUserId = response.data.userID;
                    if (currentUserId != userId) {
                        Swal.fire('無權訪問', '您無權查看此用戶的資料', 'error')
                        .then(() => {
                            window.location.href = '/user/userview?userId=' + currentUserId;
                        });
                        return;
                    }
            })

            let url = '/api/users/'+userId;
            axios.get(url)
                .then(function(response) {
                    const user = response.data;
                    document.getElementById('email').textContent = user.email;
                    document.getElementById('name').textContent = user.name;
                    document.getElementById('gender').textContent = user.gender;
                    document.getElementById('phone').textContent = user.phone;
                    // 格式化日期
                    const birthDate = new Date(user.birth).toISOString().split('T')[0];
                    const createdAtDate = new Date(user.createdAt).toISOString().split('T')[0];
                    document.getElementById('birth').textContent = birthDate;
                    document.getElementById('createdAt').textContent = createdAtDate;

                    // 設定修改button's href
                    document.getElementById('updateButton').onclick = function() {
                        window.location.href = '/user/userupdate?userId=' + userId;
                    };

                    // 設定用戶圖片
                    const profilePicture = document.getElementById('profilePicture');
                    if (user.image != null) {
                        profilePicture.src = 'data:image/png;base64,' + user.image;
                    } else {
                        profilePicture.src = '${pageContext.request.contextPath}/image/user-icon.png';
                    }
                })
                .catch(function(error) {
                    console.error("Error fetching user data:", error);
                });
        }
    </script>
    <style>
    .container {
        max-width: 600px;
        margin-top: 50px;
        border: 1px solid #ddd;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .user-info {
        margin-bottom: 15px;
    }
    .user-info label {
        font-weight: bold;
    }
    .user-info p {
        margin: 0;
    }
    .profile-picture {
        position: absolute;
        top: 50px;
        right: 100px;
    }
    .profile-picture img {
        border-radius: 50%;
        object-fit: cover;
        box-shadow: 4px 4px 0px rgba(0, 0, 0, 0.2);
    }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <br><br><br><br><br>
    <div class="container position-relative">
        <h2 class="mb-4">會員資料</h2>
        <div class="user-info row">
            <label class="col-sm-2">Email:</label>
            <p class="col-sm-8" id="email"></p>
        </div>
        <div class="user-info row">
            <label class="col-sm-2">姓名:</label>
            <p class="col-sm-8" id="name"></p>
        </div>
        <div class="user-info row">
            <label class="col-sm-2">性別:</label>
            <p class="col-sm-8" id="gender"></p>
        </div>
        <div class="user-info row">
            <label class="col-sm-2">電話:</label>
            <p class="col-sm-8" id="phone"></p>
        </div>
        <div class="user-info row">
            <label class="col-sm-2">生日:</label>
            <p class="col-sm-8" id="birth"></p>
        </div>
        <div class="user-info row">
            <label class="col-sm-2">註冊時間:</label>
            <p class="col-sm-8" id="createdAt"></p>
        </div>
        <div class="profile-picture">
            <img id="profilePicture" width="50px" height="50px" alt="user info">
        </div>
        <button id="updateButton" class="btn btn-warning" style="font-weight: bold;">修改</button>
    </div>
</body>
</html>
