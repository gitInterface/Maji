<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>結帳</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
        window.onload=function(){
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
        }

        document.addEventListener('DOMContentLoaded', function() {
            const selectedItems = JSON.parse(localStorage.getItem('selectedCartItems'));

            if (!selectedItems || selectedItems.length === 0) {
                Swal.fire('錯誤', '未選擇商品', 'error').then(function() {
                    window.location.href = '${pageContext.request.contextPath}/pages/shoppingcart.jsp';
                });
                return;
            }

            loadCheckoutItems(selectedItems);

            function loadCheckoutItems(selectedItems) {
                axios.post('${pageContext.request.contextPath}/api/cart/checkoutItems', selectedItems)
                    .then(function(response) {
                        const checkoutItems = response.data;
                        const checkoutContainer = document.getElementById('checkout-container');
                        checkoutContainer.innerHTML = ''; // 清空容器

                        let totalAmount = 0;

                        checkoutItems.forEach(item => {
                            const row = document.createElement('tr');

                            const productImage = document.createElement('td');
                            productImage.innerHTML = '<img src="data:image/png;base64,' + item.product.pictureBase64 + '" alt="Product Image" style="width: 50px;">';
                            row.appendChild(productImage);

                            const productName = document.createElement('td');
                            productName.textContent = item.product.productName;
                            row.appendChild(productName);

                            const productPrice = document.createElement('td');
                            productPrice.textContent = item.product.price;
                            row.appendChild(productPrice);

                            const productQuantity = document.createElement('td');
                            productQuantity.textContent = item.numbers;
                            row.appendChild(productQuantity);

                            checkoutContainer.appendChild(row);

                            totalAmount += item.product.price * item.numbers;
                        });

                        document.getElementById('total-amount').textContent = totalAmount;
                    })
                    .catch(function(error) {
                        console.error('Error fetching checkout items:', error);
                    });
            }

            window.proceedToPayment = function() {
                const address = document.getElementById('shipping-address').value;
                if (!address || address.includes(" ")) {
                    Swal.fire('錯誤', '請填寫運送地址', 'error');
                    return;
                }

                // 在這裡實現付款邏輯
                const selectedCartItems = JSON.parse(localStorage.getItem('selectedCartItems'));
                
                axios.post('${pageContext.request.contextPath}/api/cart/deleteSelected', selectedCartItems)
                    .then(function(response) {
                        Swal.fire('成功', '訂單已成立', 'success').then(function() {
                            localStorage.removeItem('selectedCartItems');
                            window.location.href = '${pageContext.request.contextPath}/';
                        });
                    })
                    .catch(function(error) {
                        Swal.fire('失敗', '訂單成立失敗，請稍後再試', 'error');
                    });
            }
        });
    </script>
    <style>
        .checkout-container {
            margin-top: 50px;
        }
        .table {
            width: 100%;
            margin: auto;
        }
        .table th, .table td {
            text-align: center;
        }
        .total-amount {
            text-align: right;
            font-weight: bold;
            margin-top: 20px;
        }
        .form-group {
            margin-top: 20px;
        }
        .proceed-button {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <br><br><br><br><br>
    <div class="container checkout-container">
        <h2>結帳</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>商品照</th>
                    <th>商品名稱</th>
                    <th>金額</th>
                    <th>數量</th>
                </tr>
            </thead>
            <tbody id="checkout-container"></tbody>
        </table>
        <div class="total-amount">
            總金額: <span id="total-amount">0</span> 元
        </div>
        <div class="form-group">
            <label for="shipping-address">運送地址</label>
            <input type="text" class="form-control" id="shipping-address" placeholder="請輸入您的運送地址" required>
        </div>
        <p style="color: red;">請填寫完整詳細地址，如未填寫詳細，後果自負</p>
        <p style="color: red;">請勿添加空格</p>
        <div class="proceed-button">
            <button class="btn btn-warning" onclick="proceedToPayment()" style="font-weight: bold;">前往付款</button>
        </div>
    </div>


    <%@ include file="/includes/footer.jsp" %>
</body>
</html>