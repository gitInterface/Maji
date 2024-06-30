<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>最新消息</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
        let currentPage = 0; // 當前頁碼

        window.onload = function() {
            getAllNews(currentPage);
        };

        // 獲取最新消息
        function getAllNews(page) {
            axios.get('${pageContext.request.contextPath}/api/news/all', {
                params: {
                    page: page,
                    size: 6
                }
            })
            .then(function(response) {
                var newsPage = response.data;
                var newsList = newsPage.content;
                var newsContainer = document.getElementById('newsContainer');
                newsContainer.innerHTML = '';
                newsList.forEach(function(news) {
                    var newsElement = document.createElement('div');
                    newsElement.className = 'col-md-4 mb-4';
                    var innerHTML = '<div class="card h-100 animate__animated animate__flipInY">';
                    innerHTML += '<div class="card-body">';
                    innerHTML += '<h5 class="card-title"><a href="javascript:void(0);" style="color:gray" onclick="viewNews(' + news.newsID + ')">' + news.title + '</a></h5>';
                    // 圖片
                    if (news.pictureBase64) {
                        innerHTML += '<img src="data:image/png;base64,' + news.pictureBase64 + '" class="card-img-top" alt="News Image">';
                    }
                    // 格式化日期
                    var createdAt = new Date(news.createdAt);
                    var formattedDate = createdAt.getFullYear() + '-' + 
                                        ('0' + (createdAt.getMonth() + 1)).slice(-2) + '-' + 
                                        ('0' + createdAt.getDate()).slice(-2) + ' ' + 
                                        ('0' + createdAt.getHours()).slice(-2) + ':' + 
                                        ('0' + createdAt.getMinutes()).slice(-2) + ':' + 
                                        ('0' + createdAt.getSeconds()).slice(-2);
                    innerHTML += '<p class="card-text"><small class="text-muted">建立時間：' + formattedDate + '</small></p>';
                    innerHTML += '<div class="d-flex justify-content-center"><button class="btn btn-dark" onclick="viewNews(' + news.newsID + ')">查看</button></div>';
                    innerHTML += '</div></div>';
                    newsElement.innerHTML = innerHTML;
                    newsContainer.appendChild(newsElement);
                });

                // 更新分頁按鈕
                updatePagination(newsPage.totalPages, newsPage.number);
            }).catch(function(error) {
                console.log(error);
            });
        }

        // 查看消息
        function viewNews(newsID) {
            window.location.href = '${pageContext.request.contextPath}/pages/newsdetail?newsID=' + newsID;
        }

        // 更新分頁按鈕
        function updatePagination(totalPages, currentPage) {
            var paginationContainer = document.getElementById('paginationContainer');
            paginationContainer.innerHTML = '';

            for (let i = 0; i < totalPages; i++) {
                let button = document.createElement('button');
                button.className = 'btn btn-light';
                button.innerText = i + 1;
                button.onclick = function() {
                    getAllNews(i);
                };
                if (i === currentPage) {
                    button.className += ' active';
                }
                paginationContainer.appendChild(button);
            }
        }   
    </script>
    <style>
        .pagination {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }
        .pagination button {
            margin: 0 5px;
        }
        .pagination button.active {
            font-weight: bold;
            background-color: #ffc107;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <br><br><br><br><br>
    <div class="container">
        <h2>最新消息</h2>
        <div class="row" id="newsContainer"></div>
        <div class="pagination" id="paginationContainer"></div>
    </div>

    <%@ include file="/includes/footer.jsp" %>
</body>
</html>
