<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>更新用戶訊息</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const userId = urlParams.get('userId');
        let url = '/api/users/'+ userId;

        axios.get(url)
            .then(response => {
                const user = response.data;
                document.getElementById('email').textContent = user.email;
                document.getElementById('password').value = user.password;
                document.getElementById('name').value = user.name;
                document.getElementById('gender').value = user.gender;
                document.getElementById('phone').value = user.phone;
                document.getElementById('birth').value = new Date(user.birth).toISOString().split('T')[0];
            
                // 設置圖片
                const profilePicture = document.getElementById('profilePicture');
                if (user.image != null) {
                    profilePicture.src = 'data:image/png;base64,' + user.image;
                } else {
                    profilePicture.src = '${pageContext.request.contextPath}/image/user-icon.png';
                }
            })
            .catch(error => {
                console.error('Error fetching user data:', error);
            });
        
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

        document.getElementById('image').addEventListener('change', function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profilePicture').src = e.target.result; // 更新圖片的 src
                };
                reader.readAsDataURL(file); // 讀取文件並觸發 onload 事件
            }
        });

        document.getElementById('updateForm').onsubmit = function(event) {
            event.preventDefault();

            // 前端驗證
            if (!validateForm()) {
                return;
            }

            const updatedUser = {
                password: document.getElementById('password').value,
                name: document.getElementById('name').value,
                gender: document.getElementById('gender').value,
                phone: document.getElementById('phone').value,
                birth: document.getElementById('birth').value,
                // 獲取 base64 編碼的圖片數據
                image: document.getElementById('profilePicture').src.split(',')[1],
            };
            
            let url = '/api/users/' + userId;
            axios.put(url, updatedUser)
                .then(response => {
                    Swal.fire('更新成功!', '用戶資料已更新', 'success')
                    .then(() => {
                        window.location.href = '/user/userview?userId=' + userId;
                    });
                })
                .catch(error => {
                    Swal.fire('更新失敗!', '發生錯誤，請稍後再試', 'error');
                });
        };

        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const name = document.getElementById('name').value;
            const phone = document.getElementById('phone').value;
            const birth = document.getElementById('birth').value;

            if (name.trim() === '') {
                Swal.fire('驗證錯誤', '姓名不能為空', 'error');
                return false;
            }

            const phonePattern = /^[0-9]{10}$/;
            if (!phonePattern.test(phone)) {
                Swal.fire('驗證錯誤', '電話號碼格式不正確', 'error');
                return false;
            }

            if (new Date(birth) > new Date()) {
                Swal.fire('驗證錯誤', '生日不能是未來的日期', 'error');
                return false;
            }

            if (password !== confirmPassword) {
                Swal.fire('驗證錯誤', '密碼和確認密碼不一致', 'error');
                return false;
            }

            return true;
        }
    };
    </script>
    <style>
    .form-container {
        border: 1px solid #ddd;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 2px 2px 12px #aaa;
        max-width: 600px;
        margin: 20px auto;
    }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>

    <div class="container mt-5 form-container">
        <h2>更新會員資料</h2>
        <form id="updateForm">
            <div class="form-group">
                <label for="email">Email</label>
                <span id="email" class="form-control"></span>
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
                    <option value="男性">男性</option>
                    <option value="女姓">女性</option>
                    <option value="其他">其他</option>
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
            <div class="form-group">
                <label for="profilePicture">用戶圖片</label>
                <div>
                    <img id="profilePicture" width="50px" height="50px" alt="user info">
                </div>
                <input type="file" class="form-control-file" id="image" name="image">
            </div>
            <button type="submit" class="btn btn-dark">更新</button>
        </form>
    </div>
</body>
</html>
