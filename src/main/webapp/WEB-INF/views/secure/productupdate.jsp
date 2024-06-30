<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品更新(後台)</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
        // 檢查用戶是否已登入
        axios.get('/api/admin/current')
                .then(function(response) {
                    if (!response.data) {
                        // 如果未登入，提示並跳轉到登入頁面
                        Swal.fire({
                            title: '未登入',
                            text: '請先登入以提交意見',
                            icon: 'warning',
                            confirmButtonText: '確定'
                        }).then(function() {
                            window.location.href = '/secure/loginback';
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
                        window.location.href = '/secure/loginback';
                    });
                });
                
        // 預覽圖片功能
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function(){
                var output = document.getElementById('imagePreview');
                output.src = reader.result;
                output.style.display = 'block'; // 顯示圖片
            };
            reader.readAsDataURL(event.target.files[0]);
        }

        // 獲取 URL 中的 productId
        function getProductIdFromUrl() {
            const params = new URLSearchParams(window.location.search);
            return params.get('productID');
        }

        // 獲取商品信息並回填表單
        function loadProductDetails() {
            const productID = getProductIdFromUrl();
            let url = 'http://localhost:8080/api/products/'+productID;
            axios.get(url)
                .then(function(response) {
                    const product = response.data;
                    document.getElementById('productID').value = product.productID;
                    document.getElementById('name').value = product.productName;
                    document.getElementById('discription').value = product.discription;
                    document.getElementById('tags').value = product.tag;
                    document.getElementById('price').value = product.price;
                    console.log(product.pictureBase64);// 檢查圖片數據
                    const imagePreview = document.getElementById('imagePreview');
                    console.log(imagePreview); // 確認 imagePreview 是否存在
                    if (product.pictureBase64) {
                        imagePreview.src = 'data:image/png;base64,' + product.pictureBase64;
                        imagePreview.style.display = 'block'; // 顯示圖片
                    }
                })
                .catch(function(error) {
                    console.error("Error loading product details:", error);
                });
        }

        // 提交表單更新商品信息
        function submitForm(event) {
            event.preventDefault();
            const formData = new FormData(event.target);
            axios.post('http://localhost:8080/api/products/update', formData)
            .then(function(response) {
                Swal.fire({
                    title: '更新成功！',
                    text: response.data,
                    icon: 'success',
                    confirmButtonText: 'OK'
                }).then(function() {
                    // 重定向到 productview.jsp
                    window.location.href = '/secure/productview';
                });
            })
            .catch(function(error) {
                console.error("Error updating product:", error);
                Swal.fire('更新失敗！', '無法更新商品資訊。', 'error');
            });
        }

        // 頁面加載時獲取商品詳細信息
        window.onload = function() {
            loadProductDetails();

            // 從Tag資料表中獲取值
            axios.get('http://localhost:8080/pages/tag/gettags')
            .then(function (response) {
                // 獲取標籤數據
                var tags = response.data;
                // 獲取下拉選單元素
                var select = document.getElementsByName('tags')[0];
                // 清空下拉選單中的選項
                select.innerHTML = '';
                // 將每個標籤添加為選項
                tags.forEach(function(tag) {
                    var option = document.createElement('option');
                    option.value = tag.tag;
                    option.textContent = tag.tag;
                    select.appendChild(option);
                });
            })
            .catch(function (error) {
                console.error(error);
            });
        };
    </script>
    <style>
        .form-container {
            max-width: 600px;
            margin: auto;
            border:3px solid orange;
            border-radius: 20px;
            padding:20px;
        }
        #imagePreview {
            max-width: 300px;
            max-height: 300px;
            margin-top: 20px;
            margin: auto;
        }
        .buttonDiv{
            text-align: center;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/headerback.jsp" %>
    <div class="container mt-5 form-container">
        <h3>商品表單</h3>
        <form id="productForm" onsubmit="submitForm(event)" enctype="multipart/form-data">
            <input type="hidden" name="productID" id="productID" value="${product.productID}">
            <div class="form-group">
                <label for="name">商品名稱：</label>
                <input type="text" class="form-control" id="name" name="name" value="${product.productName}" required>
            </div>
            <div class="form-group">
                <label for="discription">商品說明：</label>
                <textarea class="form-control" id="discription" name="discription" rows="3" required>${product.discription}</textarea>
            </div>
            <div class="form-group">
                <label for="tag">標籤：</label>
                <select class="form-control" id="tags" name="tags" value="${product.tag}" required>
                </select>
            </div>
            <div class="form-group">
                <label for="price">價格：</label>
                <input type="number" class="form-control" id="price" name="price" value="${product.price}" required>
            </div>
            <div class="form-group">
                <label for="picture">圖片：</label>
                <input type="file" class="form-control-file" id="picture" name="picture" onchange="previewImage(event)">
                <img id="imagePreview" src="data:image/png;base64,${product.pictureBase64}" alt="Image Preview" style="display:block;">
            </div>
            <div class="buttonDiv">
                <button type="submit" class="btn btn-warning">修改</button>
            </div>
        </form>
    </div>
</body>
</html>