<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品列表(後台)</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
    let currentPage = 0; // 當前加載的頁數
    const pageSize = 10; // 每次加載的商品數量
    let loading = false; // 是否正在加載中
    let hasMore = true; // 是否還有更多產品可以加載

    window.onload = function() {
        // 初始頁面加載商品
        fetchProducts();
        
        // 監聽滾動事件以觸發加載更多產品
        window.addEventListener('scroll', function() {
            if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 500 && hasMore && !loading) {
                fetchProducts();
            }
        });

        function fetchProducts() {
            if (loading) return; // 如果已經在加載中則返回
            loading = true; // 設置為加載中
            var page = 'http://localhost:8080/api/products/paginated?page='+currentPage+'&size='+pageSize
            axios.get(page)
                .then(function(response) {
                    renderProducts(response.data.content); // 渲染產品
                    currentPage++; // 增加頁數
                    hasMore = !response.data.last; // 更新是否還有更多產品
                    loading = false; // 加載完成，設置為不在加載中
                })
                .catch(function(error) {
                    console.error("Error fetching products:", error); // 處理錯誤
                    loading = false; // 加載失敗，設置為不在加載中
                });
        }

        function renderProducts(products) {
            var productsContainer = document.getElementById('productsContainer'); // 產品容器
            var template = document.getElementById('product-template'); // 產品模板

            products.forEach(function(product) {
                console.log("Product data:", product);

                // 克隆模板內容
                var clone = template.content.cloneNode(true);

                // 設置圖片
                var img = clone.querySelector('.card-img-top');
                if (product.pictureBase64) {
                    img.src = 'data:image/png;base64,' + product.pictureBase64;
                } else {
                    img.src = ''; // 如果沒有圖片數據，設置為空
                }
                img.alt = product.productName;

                // 設置標題
                var title = clone.querySelector('.card-title');
                title.textContent = product.productName;

                // 設置描述
                var description = clone.querySelector('.card-text');
                description.textContent = product.discription;

                // 設置價格
                var price = clone.querySelector('.price');
                price.textContent = product.price;

                // 設置標籤
                var tag = clone.querySelector('.tag');
                tag.textContent = product.tag;

                // 添加點擊事件以跳轉到商品詳情頁面
                clone.querySelector('.card').onclick = function() {
                    let url = '/backend/productupdate?productID='+product.productID;
                    window.location.href = url;
                };

                // 添加刪除按鈕事件
                var closeButton = clone.querySelector('.close-btn');
                closeButton.onclick = function(event) {
                    event.stopPropagation(); // 阻止事件冒泡，避免觸發點擊卡片的事件
                    console.log("Product ID to delete:", product.productID); // 打印 productID
                    Swal.fire({
                        title: '確定要刪除嗎？',
                        text: "這個操作不能被撤銷！",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: '是的，刪除它！',
                        cancelButtonText: '取消'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // 使用字符串拼接確認 URL
                            var deleteUrl = 'http://localhost:8080/api/products/delete/' + product.productID;
                            console.log("Delete URL:", deleteUrl); // 打印 URL 以確認
                            axios.delete(deleteUrl)
                                .then(function(response) {
                                    console.log("Delete response:", response); // 打印返回的 response
                                    if (response.status === 200) {
                                        Swal.fire(
                                            '已刪除！',
                                            '你的產品已被刪除。',
                                            'success'
                                        );
                                        // 向上查找包含 close-btn 的 .col-md-4 並移除
                                        productsContainer.removeChild(closeButton.closest('.col-md-4'));
                                    } else {
                                        Swal.fire(
                                            '刪除失敗！',
                                            '無法刪除產品。',
                                            'error'
                                        );
                                    }
                                })
                                .catch(function(error) {
                                    console.log("Delete error:", error); // 打印返回的 error
                                    Swal.fire(
                                        '刪除失敗！',
                                        '無法刪除產品。',
                                        'error'
                                    );
                                });
                        }
                    });
                };

                // 添加到容器
                productsContainer.appendChild(clone);
            });
        }

        // 搜尋商品
        window.searchProducts = function() {
            var searchQuery = document.getElementById('searchInput').value.toLowerCase();
            var searchUrl = 'http://localhost:8080/api/products/search?query=' + searchQuery;
            axios.get(searchUrl)
                .then(function(response) {
                    var productsContainer = document.getElementById('productsContainer');
                    productsContainer.innerHTML = ''; // 清空當前的產品列表
                    renderProducts(response.data);
                })
                .catch(function(error) {
                    console.error("Error searching products:", error);
                });
        };

        // 監聽 Enter 鍵按下事件
        document.getElementById('searchInput').addEventListener('keypress', function(event) {
            if (event.key === 'Enter') {
                event.preventDefault();
                searchProducts();
            }
        });

    }
    </script>
    <style>
    /*商品Card小叉叉*/
    .close-btn {
        position: absolute;
        top: 10px;
        right: 10px;
        cursor: pointer;
        color: red;
        font-size: 25px;
    }
    /*搜尋欄外框，中間正上方*/
    .search-container {
    display: flex;
    justify-content: center;
    margin-top: 20px;
    }
    .search-container button {
        margin-left: 10px; /* 按鈕與搜尋欄之間的間距 */
    }
    /* 搜尋欄 */
    .search-bar {
        flex: 1;
        max-width: 600px; /* 設置最大寬度 */
        min-width: 300px; /* 設置最小寬度 */
    }

    
    </style>
</head>
<body>
    <%@ include file="/includes/headerback.jsp" %>
    <!-- 搜尋欄-->
    <div class="search-container">
        <input type="text" id="searchInput" class="form-control search-bar" placeholder="搜尋商品...">
        <button class="btn btn-primary ml-2" onclick="searchProducts()">搜尋</button>
    </div>
    
    <!-- 商品表框-->
    <div class="container mt-5">
        <h3>Product List</h3>
        <div class="row" id="productsContainer">
            <!-- 產品卡片將顯示在這裡 -->
        </div>
    </div>

    <!-- 模板 -->
    <template id="product-template">
        <div class="col-md-4 mb-4">
            <div class="card">
                <span class="close-btn">&times;</span>
                <img class="card-img-top" alt="Product Image">
                <div class="card-body">
                    <h5 class="card-title"></h5>
                    <p class="card-text"></p>
                    <p class="card-text"><strong>Price:</strong> $<span class="price" style="font-size: 25px;"></span></p>
                    <p class="card-text"><strong>Tag:</strong> <span class="tag"></span></p>
                </div>
            </div>
        </div>
    </template>
    
</body>
</html>