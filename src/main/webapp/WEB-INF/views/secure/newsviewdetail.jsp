<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>消息詳情(後台)</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
        // 取得URL參數中的newsID
        var urlParams = new URLSearchParams(window.location.search);
        var newsID = urlParams.get('newsID');

        // 頁面加載時獲取消息詳情並顯示
        window.onload = function() {
            axios.get('${pageContext.request.contextPath}/api/news/' + newsID)
                .then(function(response) {
                    var news = response.data;
                    document.getElementById('adminAccount').textContent = news.admin.account;
                    document.getElementById('title').textContent = news.title;
                    document.getElementById('content').textContent = news.content;
                    if (news.pictureBase64) {
                        document.getElementById('picture').src = 'data:image/png;base64,' + news.pictureBase64;
                    }else{
                        document.getElementById('picture').style.display = 'none';
                    }
                    var createdAt = new Date(news.createdAt);
                    var formattedDate = createdAt.getFullYear() + '-' + 
                                        ('0' + (createdAt.getMonth() + 1)).slice(-2) + '-' + 
                                        ('0' + createdAt.getDate()).slice(-2) + ' ' + 
                                        ('0' + createdAt.getHours()).slice(-2) + ':' + 
                                        ('0' + createdAt.getMinutes()).slice(-2) + ':' + 
                                        ('0' + createdAt.getSeconds()).slice(-2);
                    document.getElementById('createdAt').textContent = formattedDate;
                }).catch(function(error) {
                    console.log(error);
                });
        };
    </script>
    <style>
        .news-detail {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
        .news-detail h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .news-detail img {
            max-width: 100%;
            height: auto;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/headerback.jsp" %>

    <div class="container news-detail">
        <h2>消息詳情</h2>
        <p><strong>建立時間：</strong><span id="createdAt"></span></p>
        <p style="float: right;"><strong>管理者帳號：</strong><span id="adminAccount"></span></p>
        <p><strong>標題：</strong><span id="title"></span></p>
        <div class="text-center">
            <img id="picture" alt="News Image" class="img-fluid">
        </div>
        <p><strong>內容：</strong><span id="content"></span></p>
    </div>
</body>
</html>
