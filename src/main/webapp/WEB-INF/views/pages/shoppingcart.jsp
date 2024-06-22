<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>購物車</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
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
                
        document.addEventListener('DOMContentLoaded', function() {
            loadCartItems();

            function loadCartItems() {
                axios.get('${pageContext.request.contextPath}/api/cart/user')
                    .then(function(response) {
                        const cartItems = response.data;
                        const cartContainer = document.getElementById('cart-container');
                        cartContainer.innerHTML = ''; // 清空容器
                       
                        let totalAmount = 0;

                        cartItems.forEach(item => {
                            const row = document.createElement('tr');

                            const checkBox = document.createElement('td');
                            checkBox.innerHTML = '<input type="checkbox" class="cart-item-check" data-price='+(item.product.price*item.numbers)+' onchange="updateTotal()">';
                            row.appendChild(checkBox);

                            const productImage = document.createElement('td');
                            productImage.innerHTML = '<img src="data:image/png;base64,' + item.product.pictureBase64 + '"alt="商品照" style="width: 50px;">';
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

                            const deleteButton = document.createElement('td');
                            const deleteBtn = document.createElement('button');
                            deleteBtn.className = 'btn btn-danger';
                            deleteBtn.textContent = '刪除';
                            deleteBtn.setAttribute('data-cart-id', item.cartID); // 添加 data-cart-id 屬性
                            deleteBtn.addEventListener('click', function() {
                                deleteCartItem(item.cartID);
                            });
                            deleteButton.appendChild(deleteBtn);
                            row.appendChild(deleteButton);

                            cartContainer.appendChild(row);

                            // totalAmount += item.product.price * item.numbers;
                        });

                        document.getElementById('total-amount').textContent = totalAmount;
                    })
                    .catch(function(error) {
                        console.error('Error fetching cart items:', error);
                    });
            }

            window.deleteCartItem = function(cartID) {
                axios.delete('${pageContext.request.contextPath}/api/cart/delete/' + cartID)
                    .then(function(response) {
                        loadCartItems();
                    })
                    .catch(function(error) {
                        console.error('Error deleting cart item:', error);
                    });
            }

            window.updateTotal = function() {
                let totalAmount = 0;
                document.querySelectorAll('.cart-item-check:checked').forEach(function(checkbox) {
                    totalAmount += parseFloat(checkbox.getAttribute('data-price'));
                });
                document.getElementById('total-amount').textContent = totalAmount;
            }

            window.proceedToCheckout = function() {
                 // 創建一個空數組來存儲選中的購物車項目
                const selectedItems = [];

                // 查找所有被選中的復選框
                document.querySelectorAll('.cart-item-check:checked').forEach(function(checkbox) {
                    // 找到復選框所在的表格行
                    const row = checkbox.closest('tr');

                    const cartID = row.querySelector('.btn-danger').getAttribute('data-cart-id');
                    selectedItems.push(cartID);
                });

                // 如果沒有選擇任何商品，顯示提示訊息
                if (selectedItems.length === 0) {
                    Swal.fire('未選擇商品', '請選擇至少一件商品進行結帳', 'warning');
                    return;
                }
                // 將選中的購物車項目ID存儲到 localStorage 中
                localStorage.setItem('selectedCartItems', JSON.stringify(selectedItems));
                // 導向結帳頁面
                window.location.href = '${pageContext.request.contextPath}/pages/checkout';
            }
        });
    </script>
    <style>
        .cart-container {
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
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <br><br><br><br><br>
    <div class="container cart-container">
        <h2>購物車</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>選擇</th>
                    <th>商品照</th>
                    <th>商品名稱</th>
                    <th>金額</th>
                    <th>數量</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="cart-container"></tbody>
        </table>
        <div class="total-amount">
            總金額: <span id="total-amount">0</span> 元
        </div>
        <div style="text-align: right; margin-top: 20px;">
            <button class="btn btn-warning checkout-button" onclick="proceedToCheckout()" style="font-weight: bold;">結帳</button>
        </div>
    </div>

    <%@ include file="/includes/footer.jsp" %>
</body>
</html>