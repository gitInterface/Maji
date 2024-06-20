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
            const textArray = ["歡迎來到我們的網站", "這是一個模仿網站", "關於神農生活的小電商", "請隨意瀏覽！"];
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
                        const colDiv = document.createElement('div');
                        colDiv.className = 'col-md-3 mb-4';

                        const productCard = document.createElement('div');
                        productCard.className = 'card h-100';

                        const productImage = document.createElement('img');
                        productImage.className = 'card-img-top';
                        productImage.src = 'data:image/png;base64,' + product.pictureBase64;
                        productCard.appendChild(productImage);

                        const cardBody = document.createElement('div');
                        cardBody.className = 'card-body';

                        const productName = document.createElement('h5');
                        productName.className = 'card-title';
                        productName.textContent = product.productName;
                        cardBody.appendChild(productName);

                        const productDescription = document.createElement('p');
                        productDescription.className = 'card-text';
                        productDescription.textContent = product.discription;
                        cardBody.appendChild(productDescription);

                        const productPrice = document.createElement('p');
                        productPrice.className = 'card-text';
                        productPrice.textContent = 'Price: $' + product.price;
                        cardBody.appendChild(productPrice);

                        const productTag = document.createElement('p');
                        productTag.className = 'card-text';
                        productTag.textContent = 'Tag: ' + product.tag;
                        cardBody.appendChild(productTag);

                        productCard.appendChild(cardBody);
                        colDiv.appendChild(productCard);
                        productsContainer.appendChild(colDiv);
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
        <div class="row products-container" id="products-container"></div>
    </div>

    <%@ include file="/includes/footer.jsp" %>
</body>
</html>