<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>自有餐廳</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">

    </script>
    <style>
        .location-info {
            margin-bottom: 30px;
        }
        .location-info img {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <br><br><br><br><br>
    <h3 style="text-align: center;">自有餐廳</h3>

    <div class="container-fluid mt-4">
        <div class="row">
            <div class="col-md-3 location-info">
                <img src="${pageContext.request.contextPath}/image/restaurant-誠品.png">
                <h5><b>食習 Have a Seat</b></h5>
                <p><span>地址:</span>
                <a href="#" target="_blank">
                    <b>台北市中山區南京西路14號4樓（誠品南西店）</b>
                </a></p>
                <p><span>電話:</span>
                <b>02-2511-2926</b></p>
                <p><span>營業時間:</span>
                <b> Mon.—Thurs.11:00-22:00
                    Fri.—Sat. 11:00-22:30
                    Sun. 11:00-22:00</b></p>
            </div>
            <div class="col-md-3 location-info">
                <img src="${pageContext.request.contextPath}/image/restaurant-桃園.png">
                <h5><b>小山丘littlehill.life</b></h5>
                <p><span>地址:</span>
                <a href="#" target="_blank">
                    <b>桃園市龍潭區華南路一段131號</b>
                </a></p>
                <p><span>電話:</span>
                <b>03-489-2017</b></p>
                <p><span>營業時間:</span>
                <b>11:30—14:30 17:30—21:30</b></p>
            </div>
            <div class="col-md-3 location-info">
                <img src="${pageContext.request.contextPath}/image/restaurant-日本家庭料理.png">
                <h5><b>食習 台湾の家庭料理　近鉄あべのハルカス店</b></h5>
                <p><span>地址:</span>
                <a href="#" target="_blank">
                    <b>
                        日本〒545-8545 Osaka, Abeno Ward, Abenosuji, 1 Chome−1−43 あべのハルカス近鉄本店タワー館10階</b>
                </a></p>
                <p><span>電話:</span>
                <b></b></p>
                <p><span>營業時間:</span>
                <b></b></p>
            </div>
            <div class="col-md-3 location-info">
                <img src="${pageContext.request.contextPath}/image/restaurant-日本茶市場.png">
                <h5><b>Oolong market 茶市場　近鉄あべのハルカス店</b></h5>
                <p><span>地址:</span>
                <a href="#" target="_blank">
                    <b>
                        日本〒545-8545 Osaka, Abeno Ward, Abenosuji, 1 Chome−1−43 あべのハルカス近鉄本店タワー館10階</b>
                </a></p>
                <p><span>電話:</span>
                <b></b></p>
                <p><span>營業時間:</span>
                <b></b></p>
            </div>
        </div>
    </div>

    <%@ include file="/includes/footer.jsp" %>
</body>
</html>