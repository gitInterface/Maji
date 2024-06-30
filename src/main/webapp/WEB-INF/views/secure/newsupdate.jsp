<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>消息更新(後台)</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
        // 取得URL參數中的newsID
        var urlParams = new URLSearchParams(window.location.search);
        var newsID = urlParams.get('newsID');

        // 頁面加載時獲取消息詳情並填充表單
        window.onload = function() {
            axios.get('${pageContext.request.contextPath}/api/news/' + newsID)
                .then(function(response) {
                    var news = response.data;
                    document.getElementById('title').value = news.title;
                    document.getElementById('content').value = news.content;
                    if (news.pictureBase64) {
                        document.getElementById('picturePreview').style.display = 'block';
                        document.getElementById('picturePreview').src = 'data:image/png;base64,' + news.pictureBase64;
                    } else {
                        document.getElementById('picturePreview').style.display = 'none';
                    }
                }).catch(function(error) {
                    console.log(error);
                });

            // 添加提交事件的監聽器
            document.getElementById('updateForm').addEventListener('submit', function(event) {
                event.preventDefault();
                updateNews();
            });

            // 添加圖片更改事件的監聽器
            document.getElementById('picture').addEventListener('change', function(event) {
                var reader = new FileReader();
                reader.onload = function() {
                    document.getElementById('picturePreview').style.display = 'block';
                    document.getElementById('picturePreview').src = reader.result;
                };
                reader.readAsDataURL(event.target.files[0]);
            });
        };

        // 更新消息的函数
        function updateNews() {
            var title = document.getElementById('title').value;
            var content = document.getElementById('content').value;
            var picture = document.getElementById('picture').files[0];

            var formData = new FormData();
            formData.append('title', title);
            formData.append('content', content);

            // 如果有選擇圖片，則將圖片文件添加到表單數據中
            if (picture) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var pictureBase64 = e.target.result.split(',')[1];
                    formData.append('picture', pictureBase64);

                    // 在讀取圖片文件後，發送更新请求
                    axios.put('${pageContext.request.contextPath}/api/news/update/' + newsID, formData)
                        .then(function(response) {
                            Swal.fire('成功', '消息已更新', 'success').then(function() {
                                window.location.href = '${pageContext.request.contextPath}/secure/newsview';
                            });
                        }).catch(function(error) {
                            if (error.response.status === 413) {
                                Swal.fire('失敗', '文件大小超過限制！請上傳小於10MB的文件。', 'error');
                            } else {
                                Swal.fire('失敗', '更新消息時發生錯誤', 'error');
                            }
                        });
                };
                reader.readAsDataURL(picture);
            } else {
                // 如果没有選擇圖片，直接發送更新请求
                axios.put('${pageContext.request.contextPath}/api/news/update/' + newsID, formData)
                    .then(function(response) {
                        Swal.fire('成功', '消息已更新', 'success').then(function() {
                            window.location.href = '${pageContext.request.contextPath}/secure/newsview';
                        });
                    }).catch(function(error) {
                        Swal.fire('失敗', '更新消息時發生錯誤', 'error');
                    });
            }
        }
    </script>
    <style>
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/headerback.jsp" %>

    <div class="container">
        <div class="form-container">
            <h2>更新最新消息</h2>
            <form id="updateForm">
                <div class="mb-3">
                    <label for="title" class="form-label">標題</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                </div>
                <div class="mb-3">
                    <label for="content" class="form-label">內容</label>
                    <textarea class="form-control" id="content" name="content" required></textarea>
                </div>
                <div class="mb-3">
                    <label for="picture" class="form-label">圖片</label>
                    <input type="file" class="form-control" id="picture" name="picture">
                    <img id="picturePreview" alt="圖片預覽" style="width: 500px; margin-top: 10px; display: none;">
                </div>
                <button type="submit" class="btn btn-warning btn-block">更新</button>
            </form>
        </div>
    </div>
</body>
</html>