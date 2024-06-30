<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>導覽列</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">
    $(document).ready(function() {
      axios.get('/api/users/current')
          .then(function(response) {
              $('#username').text(response.data.name);
              $('#loginButton').hide();
              $('#registerButton').hide();
              $('#logoutButton').show();
              if (response.data.image != null) {
                $('#userIcon').attr('src', 'data:image/png;base64,' + response.data.image); 
              }
              $('#userIcon').show();
          })
          .catch(function(error) {
              $('#username').text('');
              $('#loginButton').show();
              $('#registerButton').show();
              $('#logoutButton').hide();
              $('#userIcon').hide();
          });

      $('#logoutButton').click(function() {
          axios.post('/api/users/logout')
              .then(function(response) {
                  Swal.fire('登出成功!', response.data, 'success').then(() => {
                      window.location.href = '/';
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
      #userIcon{
        border-radius: 50%;
        object-fit: cover;
      }
    </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container-fluid">
      <!-- 神農logo -->
      <a class="navbar-brand" href="/">
        <img src="${pageContext.request.contextPath}/image/maji-logo.png" alt="神農生活logo" width="150px">
      </a>
      <!-- 漢堡toggler -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav nav-source">
          <li class="nav-item">
            <a class="nav-link" aria-current="page" href="/pages/onlineshopping">
              <b>線上購物</b><br>
              <span>online store</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/pages/news">
              <b>最新消息</b><br>
              <span>news</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/pages/aboutbrand">
              <b>關於品牌</b><br>
              <span>about brand</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/pages/location">
              <b>店鋪位置</b><br>
              <span>location</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/pages/restaurant">
              <b>自有餐廳</b><br>
              <span>restaurant</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/pages/feedback">
              <b>意見箱</b><br>
              <span>feedback</span>
            </a>
          </li>
        </ul>
        <form class="d-flex">
          <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success" type="submit">Search</button>
        </form> 
        &nbsp;
        <a href="/portal/register">
          <button class="btn btn-danger" id="registerButton"><b>註冊</b></button>
        </a>
        &nbsp;
        <a href="/portal/login">
          <button class="btn btn-warning" id="loginButton"><b>登入</b></button>
        </a>
        &nbsp;
        <button class="btn btn-danger" id="logoutButton" style="display:none;"><b>登出</b></button>
        &nbsp;&nbsp;
        <div id="userinfo">
          <a href="${pageContext.request.contextPath}/user/userview?userId=${sessionScope.loggedInUser.userID}">
            <img id="userIcon" src="${pageContext.request.contextPath}/image/user-icon.png" alt="user:" style="width:30px; height:30px; display: none;">
            <span id="username" style="color: gray;"></span>
          </a>
        </div>
        &nbsp;
        <a href="/pages/shoppingcart" style="color: gray;">
          <i class="fa fa-shopping-cart"></i>
          <span><b>購物車</b></span>
        </a>
      </div>
    </div>
  </nav>

</body>
</html>