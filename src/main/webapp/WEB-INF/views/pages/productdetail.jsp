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
            // 實現添加到購物車的邏輯
        }
    </script>
    <style>
        .product-detail {
            margin: 50px auto;
            max-width: 600px;
            text-align: center;
        }
        .product-detail img {
            max-width: 100%;
            height: auto;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <br><br><br><br><br>
    <div class="container product-detail">
        <img id="product-image" alt="Product Image">
        <h2 id="product-name"></h2>
        <p id="product-tag"></p>
        <p id="product-description"></p>
        <h3 id="product-price" style="font-weight: bold;"></h3>
        <input type="number" id="product-quantity" value="1" min="1">
        <button class="btn btn-warning" onclick="addToCart()">添加到購物車</button>
    </div>

    <%@ include file="/includes/footer.jsp" %>
</body>
</html>