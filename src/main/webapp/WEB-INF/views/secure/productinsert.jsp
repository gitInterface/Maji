<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品新增(後台)</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
    // 清除表單內容
    function clearForm() {
        var inputs = document.getElementsByTagName("input");
        var textareas = document.getElementsByTagName("textarea");
        for(var i=0; i<inputs.length; i++) {
            if(inputs[i].type=="text" || inputs[i].type=="file") {
                inputs[i].value="";
            }
        }
        for(var i=0; i<textareas.length; i++) {
            textareas[i].value="";
        }
        // 清空圖片預覽
        document.getElementById('imagePreview').src = '';
        document.getElementById('imagePreview').style.display = "none";
    }

    // 建立圖片預覽
    function previewImage(event) {
        var reader = new FileReader();
        reader.onload = function(){
            var output = document.getElementById('imagePreview');
            output.style.display = "block";
            output.src = reader.result;
        };
        reader.readAsDataURL(event.target.files[0]);
    }
    
    // 送出Form表單
    function submitForm(event) {
        event.preventDefault();
        var formData = new FormData(event.target);

        axios.post('http://localhost:8080/api/products/insert', formData)
        .then(function (response) {
            Swal.fire({
                title: '新增成功!',
                text: response.data,
                icon: 'success',
                confirmButtonText: 'OK'
            }).then(function() {
                clearForm();
            });
         })
         .catch(function (error) {
            Swal.fire({
                title: '新增失敗!',
                text: error.response.data,
                icon: 'error',
                confirmButtonText: 'OK'
            });
         });
    }
    
    window.onload = function(){
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
    }
    </script>
    <style>
        /* 標題 */
        h3 {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        /* 表單外框 */
        .formDiv {
            max-width: 600px;
            margin: 0 auto;
            border: 3px solid orange;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 30px 30px 25px 2px rgba(0, 0, 0, 0.1);
        }
        /* 圖片預覽 */
        .form-group img {
            max-width: 100%;
            max-height: 300px;
            display: block;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/headerback.jsp" %>
    <h3>商品表單</h3>

    <div class="formDiv">
        <form id="productForm" onsubmit="submitForm(event)" enctype="multipart/form-data">
            <div class="form-group">
                <label for="name">商品名稱 :</label>
                <input type="text" class="form-control" id="name" name="name">
            </div>
            <div class="form-group">
                <label for="discription">商品說明 :</label>
                <textarea class="form-control" id="discription" name="discription"></textarea>
            </div>
            <div class="form-group">
                <label for="picture">圖片 :</label>
                <input type="file" class="form-control" id="picture" name="picture" onchange="previewImage(event)">
                <img id="imagePreview" src="" alt="Image Preview" style="display: none;">
            </div>
            <div class="form-group">
                <label for="price">售價 :</label>
                <input type="text" class="form-control" id="price" name="price">
            </div>
            <div class="form-group">
                <label for="tags">標籤 :</label>
                <select class="form-control" id="tags" name="tags">
                </select>
            </div>
            <div class="form-group text-center">
                <button type="submit" class="btn btn-warning">新增</button>
                <button type="button" class="btn btn-dark" onclick="clearForm()">清空</button>
            </div>
        </form>
    </div>

</body>
</html>