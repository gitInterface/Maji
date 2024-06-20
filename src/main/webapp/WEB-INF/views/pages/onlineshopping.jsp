    <%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html lang="zh">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>線上購物</title>
        <%@ include file="/includes/libs.jsp" %>
        <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            // 初始加載第0頁商品
            loadProducts(0);

            // 加載指定頁數的商品
            function loadProducts(page) {
                // 發送GET請求獲取分頁商品數據
                axios.get('${pageContext.request.contextPath}/api/products/paginated', {
                    params: {
                        page: page, // 當前頁數
                        size: 10    // 每頁顯示的商品數量
                    }
                })
                .then(function(response) {
                    const products = response.data.content; // 獲取商品數據
                    const productsContainer = document.getElementById('products-container');
                    productsContainer.innerHTML = ''; // 清空商品容器

                    // 遍歷每個商品並生成商品卡片
                    products.forEach(product => {
                        const productCard = document.createElement('div');
                        productCard.className = 'col-md-3 product-card'; // 使用Bootstrap的col-md-3類來實現響應式布局

                        // 創建並添加商品圖片
                        const productImage = document.createElement('img');
                        productImage.src = 'data:image/png;base64,' + product.pictureBase64;
                        productCard.appendChild(productImage);

                        // 創建並添加商品名稱
                        const productName = document.createElement('h5');
                        productName.textContent = product.productName;
                        productCard.appendChild(productName);

                        // 創建並添加商品價格
                        const productPrice = document.createElement('p');
                        productPrice.textContent = 'Price: $' + product.price;
                        productCard.appendChild(productPrice);

                        // 創建並添加商品標籤
                        const productTag = document.createElement('p');
                        productTag.textContent = 'Tag: ' + product.tag;
                        productCard.appendChild(productTag);

                        // 創建並添加查看詳情的鏈接按鈕
                        const productLink = document.createElement('a');
                        productLink.href = '${pageContext.request.contextPath}/pages/productdetail?productId=' + product.productID;
                        productLink.className = 'btn btn-warning'; // 使用Bootstrap的btn btn-warning類來實現按鈕樣式
                        productLink.textContent = '查看詳情';
                        productCard.appendChild(productLink);

                        // 將商品卡片添加到商品容器中
                        productsContainer.appendChild(productCard);
                    });

                    // 渲染分頁控件
                    renderPagination(response.data.totalPages, page);
                })
                .catch(function(error) {
                    console.error('Error fetching products:', error);
                });
            }

            // 渲染分頁控件
            function renderPagination(totalPages, currentPage) {
                const paginationContainer = document.getElementById('pagination');
                paginationContainer.innerHTML = ''; // 清空分頁容器

                const nav = document.createElement('nav');
                nav.setAttribute('aria-label', 'Page navigation');

                const ul = document.createElement('ul');
                ul.className = 'pagination justify-content-center'; // 使用Bootstrap的pagination和justify-content-center類來實現分頁控件樣式

                // 創建上一頁的按鈕
                const prevLi = document.createElement('li');
                prevLi.className = 'page-item ' + (currentPage === 0 ? 'disabled' : ''); // 當前頁為0時禁用上一頁按鈕
                const prevLink = document.createElement('a');
                prevLink.className = 'page-link';
                prevLink.href = 'javascript:void(0)';
                prevLink.onclick = function() { loadProducts(currentPage - 1); };
                prevLink.textContent = 'Previous';
                prevLi.appendChild(prevLink);
                ul.appendChild(prevLi);

                // 創建分頁按鈕
                for (let i = 0; i < totalPages; i++) {
                    const li = document.createElement('li');
                    li.className = 'page-item ' + (currentPage === i ? 'active' : ''); // 當前頁的按鈕設置為激活狀態
                    const link = document.createElement('a');
                    link.className = 'page-link';
                    link.href = 'javascript:void(0)';
                    link.onclick = function() { loadProducts(i); };
                    link.textContent = i + 1;
                    li.appendChild(link);
                    ul.appendChild(li);
                }

                // 創建下一頁的按鈕
                const nextLi = document.createElement('li');
                nextLi.className = 'page-item ' + (currentPage === totalPages - 1 ? 'disabled' : ''); // 當前頁為最後一頁時禁用下一頁按鈕
                const nextLink = document.createElement('a');
                nextLink.className = 'page-link';
                nextLink.href = 'javascript:void(0)';
                nextLink.onclick = function() { loadProducts(currentPage + 1); };
                nextLink.textContent = 'Next';
                nextLi.appendChild(nextLink);
                ul.appendChild(nextLi);

                nav.appendChild(ul);
                paginationContainer.appendChild(nav); // 將分頁控件添加到分頁容器中
            }
        });

        </script>
        <style>
        /* 分頁樣式 */
        .pagination .page-item .page-link {
            color: #FFA500; /* 橘色文字 */
        }

        /* 分頁樣式 */
        .pagination .page-item.active .page-link {
            background-color: #FFA500; /* 橘色背景 */
            border-color: #FFA500; /* 橘色邊框 */
            color: white; /* 白色文字 */
        }

        /* 商品容器 */
        .products-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
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
        <br><br><br><br><br>
        <div class="container">
            <h3 style="text-align: center;">商品列表</h3>
            <div class="row products-container" id="products-container"></div>
            <div id="pagination"></div>
        </div>

        <%@ include file="/includes/footer.jsp" %>
    </body>
    </html>