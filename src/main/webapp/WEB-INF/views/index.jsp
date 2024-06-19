<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首頁</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            const textArray = ["歡迎來到我們的網站", "這裡有很多有趣的內容", "請隨意瀏覽！"];
            let textIndex = 0;
            let charIndex = 0;
            const typingSpeed = 100;
            const erasingSpeed = 50;
            const delayBetweenTexts = 2000;
            const typedTextElement = document.getElementById('typed-text');

            function type() {
                if (charIndex < textArray[textIndex].length) {
                    typedTextElement.textContent += textArray[textIndex].charAt(charIndex);
                    charIndex++;
                    setTimeout(type, typingSpeed);
                } else {
                    setTimeout(erase, delayBetweenTexts);
                }
            }

            function erase() {
                if (charIndex > 0) {
                    typedTextElement.textContent = textArray[textIndex].substring(0, charIndex - 1);
                    charIndex--;
                    setTimeout(erase, erasingSpeed);
                } else {
                    textIndex++;
                    if (textIndex >= textArray.length) {
                        textIndex = 0;
                    }
                    setTimeout(type, typingSpeed);
                }
            }

            setTimeout(type, typingSpeed);

            // 選取隨機四樣商品並呈現
            fetchRandomProducts();
        });

        function fetchRandomProducts() {
            axios.get('${pageContext.request.contextPath}/api/products/random')
                .then(function(response) {
                    const products = response.data;
                    const productsContainer = document.getElementById('products-container');

                    products.forEach(product => {
                        const productCard = document.createElement('div');
                        productCard.className = 'product-card';

                        const productImage = document.createElement('img');
                        productImage.src = 'data:image/png;base64,' + product.pictureBase64;
                        productCard.appendChild(productImage);

                        const productName = document.createElement('h5');
                        productName.textContent = product.productName;
                        productCard.appendChild(productName);

                        const productDescription = document.createElement('p');
                        productDescription.textContent = product.discription;
                        productCard.appendChild(productDescription);

                        const productPrice = document.createElement('p');
                        productPrice.textContent = 'Price: $' + product.price;
                        productCard.appendChild(productPrice);

                        const productTag = document.createElement('p');
                        productTag.textContent = 'Tag:' + product.tag;
                        productCard.appendChild(productTag);

                        productsContainer.appendChild(productCard);
                    });
                })
                .catch(function(error) {
                    console.error('Error fetching products:', error);
                });
        }
    </script>
    <style>
        /* 中心容器樣式 */
        .center-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0; 
            background-image: url('${pageContext.request.contextPath}/image/index-background.jpg');
            background-size: cover;
            background-position: center;
        }

        /* p typed-text css */
        .typed-text {
            font-size: 24px;
            font-weight: bold;
            white-space: nowrap;
            overflow: hidden;
            border-right: .15em solid orange;
            animation: caret 1s steps(1) infinite;
            background-color: rgba(255, 255, 255, 0.8); 
            padding: 10px;
            border-radius: 5px;
        }

        /* 設置光標的閃爍效果 */
        @keyframes caret {
            50% {
                border-color: transparent;
            }
        }

        /* 商品容器 */
        .products-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            padding: 20px;
        }

        /* 商品卡片呈現 */
        .product-card {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin: 10px;
            width: calc(25% - 40px);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            text-align: center;
        }

        /* 商品卡片圖片 */
        .product-card img {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>

    <div class="center-container">
        <p class="typed-text" id="typed-text"></p>
    </div>
    <br>
    <h3 style="text-align: center;">商品推薦</h3>
    
    <div class="container">
        <div class="products-container" id="products-container"></div>
    </div>
</body>
</html>