<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>意見箱</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
        window.onload = function() {
            // 檢查用戶是否已登入
            axios.get('/api/users/current')
                .then(function(response) {
                    if (!response.data) {
                        // 如果未登入，提示並跳轉到登入頁面
                        Swal.fire({
                            title: '未登入',
                            text: '請先登入以提交意見',
                            icon: 'warning',
                            confirmButtonText: '確定'
                        }).then(function() {
                            window.location.href = '/portal/login';
                        });
                    }
                })
                .catch(function(error) {
                    // 如果發生錯誤，假設用戶未登入
                    Swal.fire({
                        title: '未登入',
                        text: '請先登入以提交意見',
                        icon: 'warning',
                        confirmButtonText: '確定'
                    }).then(function() {
                        window.location.href = '/portal/login';
                    });
                });

            document.getElementById('feedbackTitle').addEventListener('input', function() {
                if (this.value.length > 100) {
                    Swal.fire('字數超過限制', '標題最多100個字', 'warning');
                }
            });

            document.getElementById('feedbackContent').addEventListener('input', function() {
                if (this.value.length > 1000) {
                    Swal.fire('字數超過限制', '意見內容最多1000個字', 'warning');
                }
            });

            document.getElementById('feedbackForm').onsubmit = function(event) {
                event.preventDefault();

                axios.get('/api/users/current')
                .then(function(response) {
                    const userID = response.data.userID;

                    const feedback = {
                        title: document.getElementById('feedbackTitle').value,
                        content: document.getElementById('feedbackContent').value,
                        userID: userID
                    };

                    return axios.post('/api/feedback/submit', feedback);
                })
                .then(function(response) {
                    Swal.fire('提交成功!', response.data, 'success');
                })
                .catch(function(error) {
                    Swal.fire('提交失敗!', '請稍後再試', 'error');
                });
            }    
        }
    </script>
    <style>
        .feedback-container {
            margin-top: 50px;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <br><br><br><br><br>
    <div class="container feedback-container">
        <form id="feedbackForm">
            <!-- 標題 -->
            <div class="mb-3">
                <label for="feedbackTitle" class="form-label">標題</label>
                <input type="text" class="form-control" id="feedbackTitle" maxlength="100" required aria-label="標題">
            </div>
            <!-- 意見內容 -->
            <div class="mb-3">
                <label for="feedbackContent" class="form-label">意見內容</label>
                <textarea class="form-control" id="feedbackContent" rows="10" maxlength="1000" required></textarea>
            </div>
            <button type="submit" class="btn btn-warning"><b>送出</b></button>
        </form>
    </div>
    
    <%@ include file="/includes/footer.jsp" %>
</body>
</html>