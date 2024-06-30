<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>導覽列(後台)</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('logoutButton').addEventListener('click', function() {
                axios.post('${pageContext.request.contextPath}/api/admin/logout')
                    .then(function(response) {
                        Swal.fire('登出成功!', response.data, 'success')
                            .then(function() {
                                window.location.href = '${pageContext.request.contextPath}/secure/loginback';
                            });
                    })
                    .catch(function(error) {
                        Swal.fire('登出失敗!', '發生錯誤，請稍後再試', 'error');
                    });
            });
        });
    </script>
    <style>
    .nav-item{
        text-align: center;
        padding:20px;
      }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
          <!-- 神農logo -->
          <a class="navbar-brand" href="/secure/productview">
            <img src="${pageContext.request.contextPath}/image/maji-logo.png" alt="神農生活logo" width="150px">
          </a>
          <!-- 漢堡toggler -->
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav">
              <li class="nav-item">
                <a href="/secure/productview" class="nav-link">
                  <b>商品列表</b><br>
                  <span>product list</span></a>
                </a>
              </li>
              <li class="nav-item">
                <a href="/secure/productinsert" class="nav-link">
                  <b>新增商品</b><br>
                  <span>product insert</span></a>
                </a>
              </li>
              <li class="nav-item">
                <a href="/secure/newsview" class="nav-link">
                  <b>最新消息</b><br>
                  <span>news list</span></a>
                </a>
              </li>
              <li class="nav-item">
                <a href="/secure/newsinsert" class="nav-link">
                  <b>新增消息</b><br>
                  <span>news insert</span></a>
                </a>
              </li>
            </ul>
            <ul class="navbar-nav ml-auto"> 
              <li class="nav-item"> 
                <button class="btn btn-danger" id="logoutButton"><b>登出</b></button>
              </li> 
          </ul> 
          </div>
        </div>
      </nav>
</body>
</html>