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
        
    </script>
    <style>
    .nav-item{
        text-align: center;
        padding:20px;
      }
    .source{
        margin-left: 15%;
    }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
          <!-- 神農logo -->
          <a class="navbar-brand" href="#">
            <img src="${pageContext.request.contextPath}/image/maji-logo.png" alt="神農生活logo" width="150px">
          </a>
          <!-- 漢堡toggler -->
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav source">
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
            </ul>
          </div>
        </div>
      </nav>
</body>
</html>