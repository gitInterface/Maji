<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品詳細頁面</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            var productId = new URLSearchParams(window.location.search).get('productId');
            loadProductDetail(productId);
        });

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

        function loadProductDetail(productId) {
            axios.get('${pageContext.request.contextPath}/api/products/' + productId)
                .then(function(response) {
                    var product = response.data;
                    $('#product-image').attr('src', 'data:image/png;base64,' + product.pictureBase64);
                    $('#product-name').text(product.productName);
                    $('#product-description').text(product.discription);
                    $('#product-price').text('Price: $' + product.price);
                    $('#product-tag').text('Tag: ' + product.tag);
                }).catch(function(error) {
                    console.log(error);
                });
        }

        function addToCart() {
            const userID = "<c:out value='${sessionScope.loggedInUser.userID}' />";
            const productID = new URLSearchParams(window.location.search).get('productId');
            const numbers = document.getElementById('product-quantity').value;
            axios.post('${pageContext.request.contextPath}/api/cart/add', {
                userID: parseInt(userID),
                productID: parseInt(productID),
                numbers: parseInt(numbers)
            })
            .then(function(response) {
                Swal.fire('成功!', response.data, 'success');
            })
            .catch(function(error) {
                Swal.fire('失敗!', '發生錯誤，請稍後再試', 'error');
            });
        }
    </script>
    <style>
        .product-detail {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 50px auto;
            max-width: 1000px;
            gap: 20px;
        }
        .product-detail img {
            max-width: 100%;
            height: auto;
            max-width: 500px;
            margin-bottom: 20px;
        }
        .product-info {
            max-width: 500px;
        }
        .product-info h2 {
            font-size: 28px;
            margin-bottom: 20px;
        }
        .product-info p {
            font-size: 16px;
            margin-bottom: 10px;
        }
        .product-info h3 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .product-info input[type="number"] {
            width: 100px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <br><br><br><br><br>
    <div class="container product-detail">
        <img id="product-image" alt="Product Image">
        <div class="product-info">
            <h2 id="product-name"></h2>
            <p id="product-tag"></p>
            <p id="product-description"></p>
            <h3 id="product-price"></h3>
            <input type="number" id="product-quantity" value="1" min="1">
            <button class="btn btn-warning" onclick="addToCart()">添加到購物車</button>
        </div>
    </div>

    <%@ include file="/includes/footer.jsp" %>
</body>
</html>