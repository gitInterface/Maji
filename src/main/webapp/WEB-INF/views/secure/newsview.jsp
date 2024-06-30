<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>最新消息(後台)</title>
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
                    var newsElement = document.createElement('tr');
                    var innerHTML = '<td>' + news.admin.account + '</td>';
                    innerHTML += '<td>' + news.title + '</td>';
                    // 圖片
                    // if (news.pictureBase64) {
                    //     innerHTML += '<td><img src="data:image/png;base64,' + news.pictureBase64 + '" alt="News Image" style="width: 50px;"></td>';
                    // } else {
                    //     innerHTML += '<td></td>';
                    // }
                    
                    // 格式化日期
                    var createdAt = new Date(news.createdAt);
                    var formattedDate = createdAt.getFullYear() + '-' + 
                                        ('0' + (createdAt.getMonth() + 1)).slice(-2) + '-' + 
                                        ('0' + createdAt.getDate()).slice(-2) + ' ' + 
                                        ('0' + createdAt.getHours()).slice(-2) + ':' + 
                                        ('0' + createdAt.getMinutes()).slice(-2) + ':' + 
                                        ('0' + createdAt.getSeconds()).slice(-2);
                    innerHTML += '<td>' + formattedDate + '</td>';

                    innerHTML += '<td><button class="btn btn-dark" onclick="viewNews(' + news.newsID + ')">查看</button></td>';
                    innerHTML += '<td><button class="btn btn-warning" onclick="editNews(' + news.newsID + ')">修改</button></td>';
                    innerHTML += '<td><button class="btn btn-danger" onclick="deleteNews(' + news.newsID + ')">刪除</button></td>';

                    newsElement.innerHTML = innerHTML;
                    newsContainer.appendChild(newsElement);
                });

                // 更新分頁按鈕
                updatePagination(newsPage.totalPages, newsPage.number);
            }).catch(function(error) {
                console.log(error);
            });
        }

        // 刪除消息
        function deleteNews(newsID) {
            axios.delete('${pageContext.request.contextPath}/api/news/delete/' + newsID)
                .then(function(response) {
                    Swal.fire('成功', '消息已刪除', 'success').then(function() {
                        getAllNews(currentPage);
                    });
                }).catch(function(error) {
                    Swal.fire('失敗', '刪除消息時發生錯誤', 'error');
                });
        }

        // 編輯消息
        function editNews(newsID) {
            window.location.href = '${pageContext.request.contextPath}/secure/newsupdate?newsID=' + newsID;
        }

        // 查看消息
        function viewNews(newsID) {
            window.location.href = '${pageContext.request.contextPath}/secure/newsviewdetail?newsID=' + newsID;
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
    <%@ include file="/includes/headerback.jsp" %>

    <div class="container">
        <h2>最新消息</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>管理者帳號</th>
                    <th>標題</th>
                    <!-- <th>內容</th> -->
                    <th>建立時間</th>
                    <th>查看</th>
                    <th>修改</th>
                    <th>刪除</th>
                </tr>
            </thead>
            <tbody id="newsContainer"></tbody>
        </table>
        <div class="pagination" id="paginationContainer"></div>
    </div>
</body>
</html>