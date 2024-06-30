<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增消息(後台)</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
         document.addEventListener('DOMContentLoaded', function() {
            const newsForm = document.getElementById('newsForm');
            if (newsForm) {
                newsForm.addEventListener('submit', function(event) {
                    event.preventDefault();
                    addNews();
                });
            }

            const pictureInput = document.getElementById('picture');
            if (pictureInput) {
                pictureInput.addEventListener('change', function(event) {
                    const file = event.target.files[0];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            const pictureInput = document.getElementById('picturePreview');
                            pictureInput.style.display = "block";
                            pictureInput.src = e.target.result;
                        };
                        reader.readAsDataURL(file);
                    }
                });
            }
        });

        function addNews() {
            const titleElement = document.getElementById('title');
            const contentElement = document.getElementById('content');
            const pictureInput = document.getElementById('picture');

            if (!titleElement || !contentElement) {
                console.error('Title or content element not found.');
                return;
            }

            const formData = new FormData();
            formData.append('title', titleElement.value);
            formData.append('content', contentElement.value);

            if (pictureInput && pictureInput.files.length > 0) {
                const file = pictureInput.files[0];
                const reader = new FileReader();
                reader.onloadend = function() {
                    formData.append('picture', reader.result.split(',')[1]);
                    sendFormData(formData);
                };
                reader.readAsDataURL(file);
            } else {
                sendFormData(formData);
            }
        }

        function sendFormData(formData) {
            const adminID = "<c:out value='${sessionScope.loggedInAdmin.adminID}' />";
            formData.append('adminID', adminID);

            axios.post('${pageContext.request.contextPath}/api/news/add', formData)
                .then(function(response) {
                    Swal.fire('成功', '最新消息已新增', 'success')
                        .then(function() {
                             // 清空表單
                            document.getElementById('newsForm').reset();
                             // 清空圖片預覽
                            document.getElementById('picturePreview').src = '';
                            document.getElementById('picturePreview').style.display = 'none';
                            // window.location.href = '${pageContext.request.contextPath}/secure/newsview';
                        });
                })
                .catch(function(error) {
                    Swal.fire('失敗', '新增最新消息失敗，請稍後再試', 'error');
                });
        }
    </script>
    <style>
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-control {
            width: 100%;
        }
        .form-label {
            font-weight: bold;
        }
        #picturePreview {
            width: 100%;
            max-height: 300px;
            object-fit: contain;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/headerback.jsp" %>

    <div class="container">
        <h2 class="text-center">新增最新消息</h2>
        <form id="newsForm">
            <div class="form-group">
                <label for="title" class="form-label">標題</label>
                <input type="text" id="title" class="form-control" maxlength="100" required>
            </div>
            <div class="form-group">
                <label for="content" class="form-label">內容</label>
                <textarea id="content" class="form-control" rows="5" required></textarea>
            </div>
            <div class="form-group">
                <label for="picture" class="form-label">圖片</label>
                <input type="file" id="picture" class="form-control">
                <img id="picturePreview" alt="圖片預覽" style="display: none;">
            </div>
            <button type="submit" class="btn btn-warning btn-block">新增</button>
        </form>
    </div>
</body>
</html>