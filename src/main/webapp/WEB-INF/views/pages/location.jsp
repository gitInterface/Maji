<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>店鋪位置</title>
    <%@ include file="/includes/libs.jsp" %>
    <!-- 加入 Google Maps JavaScript API -->
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCIofoiSikUT0EC_u7XLPKF6NIzsYph1Ug&callback=initMap&libraries=marker" async defer></script>
    <script>
        // 初始化地圖
        function initMap() {
            // 地圖選項
            var mapOptions = {
                zoom: 12,
                center: {lat: 25.0330, lng: 121.5654}, // 設定地圖中心為台北
                mapId: 'august-emitter-425913-k0',
            };
            // 創建地圖
            var map = new google.maps.Map(document.getElementById('map'), mapOptions);

            // 地點陣列
            var locations = [
                {address: "台北市中山區玉門街1號", lat: 25.0684, lng: 121.5206, link: "https://www.google.com.tw/maps/place/10491%E5%8F%B0%E5%8C%97%E5%B8%82%E4%B8%AD%E5%B1%B1%E5%8D%80%E7%8E%89%E9%96%80%E8%A1%971%E8%99%9F/@25.0700642,121.5204828,17z/data=!4m15!1m8!3m7!1s0x3442a94f37348ea9:0xa8ee38918a912c67!2zMTA0OTHlj7DljJfluILkuK3lsbHljYDnjonploDooZcx6Jmf!3b1!8m2!3d25.0692554!4d121.5204522!16s%2Fg%2F11c26zrmkv!3m5!1s0x3442a94f37348ea9:0xa8ee38918a912c67!8m2!3d25.0692554!4d121.5204522!16s%2Fg%2F11c26zrmkv?entry=ttu"},
                {address: "台北市中山區南京西路14號4樓", lat: 25.0523, lng: 121.5191, link: "https://www.google.com/maps/place/%E7%A5%9E%E8%BE%B2%E7%94%9F%E6%B4%BB+MAJI+TREATS/@25.0524088,121.5187478,17z/data=!3m1!5s0x3442a96eb1a06b9f:0xb4ed5f7d2949bca!4m9!1m2!2m1!1zMTA0OTHlj7DljJfluILkuK3lsbHljYDljZfkuqzopb_ot68xNOiZnzTmqJM!3m5!1s0x3442a988652cdf75:0x8e0184d06d670718!8m2!3d25.0521315!4d121.520677!15sCiwxMDQ5MeWPsOWMl-W4guS4reWxseWNgOWNl-S6rOilv-i3rzE06JmfNOaok1o5IjcxMDQ5MSDlj7DljJcg5biCIOS4reWxsSDljYAg5Y2X5LqsIOilvyDot68gMTQg6JmfIDQg5qiTkgEFc3RvcmU"},
                {address: "日本〒545-8545 Osaka, Abeno Ward, Abenosuji, 1 Chome−1−43 あべのハルカス近鉄本店タワー館10階", lat: 34.6476, lng: 135.5135, link: "https://www.google.com/maps/place/%E7%A5%9E%E8%BE%B2%E7%94%9F%E6%B4%BB+%E8%BF%91%E9%89%84%E3%81%82%E3%81%B9%E3%81%AE%E3%83%8F%E3%83%AB%E3%82%AB%E3%82%B9%E5%BA%97/@29.5427247,119.5029244,5z/data=!4m9!1m2!2m1!1z56We6L6y55Sf5rS7IOi_kemJhOOBguOBueOBruODj-ODq-OCq-OCueW6lw!3m5!1s0x6000dd8c1acff605:0x49b12ec593c43d73!8m2!3d34.6461457!4d135.513652!15sCivnpZ7ovrLnlJ_mtLsg6L-R6YmE44GC44G544Gu44OP44Or44Kr44K55bqXIgOIAQFaYgov56We6L6yIOeUn-a0uyDov5HpiYQg44GC44G544GuIOODj-ODq-OCq-OCuSDlupciL-elnui-siDnlJ_mtLsg6L-R6YmEIOOBguOBueOBriDjg4_jg6vjgqvjgrkg5bqXkgEJZ2lmdF9zaG9w"}
            ];

            // 創建標記
            locations.forEach(function(location) {
                const marker = new google.maps.marker.AdvancedMarkerElement({
                    map: map,
                    position: {lat: location.lat, lng: location.lng},
                    title: location.address
                });

                // 顯示地址資訊視窗，並加入連結到 Google Maps
                const infowindow = new google.maps.InfoWindow({
                    content: '<div>' + location.address + '<br><a href="' + location.link + '" target="_blank">查看 Google Maps 資訊</a></div>'
                });

                marker.addListener('click', function() {
                    infowindow.open({
                        anchor: marker,
                        map,
                        shouldFocus: false,
                    });
                });

            });
        }
    </script>
    <style>
        #map {
            height: 450px;
            width: 50%;
            margin: auto;
        }
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

    <div id="map"></div>

    <h3 style="text-align: center;">門市資訊</h3>
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-4 location-info">
                <img src="${pageContext.request.contextPath}/image/location-日本.png">
                <h5><b>神農生活 近鉄あべのハルカス店</b></h5>
                <p><span>地址:</span>
                <a href="https://www.google.com/maps/place/%E7%A5%9E%E8%BE%B2%E7%94%9F%E6%B4%BB+%E8%BF%91%E9%89%84%E3%81%82%E3%81%B9%E3%81%AE%E3%83%8F%E3%83%AB%E3%82%AB%E3%82%B9%E5%BA%97/@29.5427247,119.5029244,5z/data=!4m9!1m2!2m1!1z56We6L6y55Sf5rS7IOi_kemJhOOBguOBueOBruODj-ODq-OCq-OCueW6lw!3m5!1s0x6000dd8c1acff605:0x49b12ec593c43d73!8m2!3d34.6461457!4d135.513652!15sCivnpZ7ovrLnlJ_mtLsg6L-R6YmE44GC44G544Gu44OP44Or44Kr44K55bqXIgOIAQFaYgov56We6L6yIOeUn-a0uyDov5HpiYQg44GC44G544GuIOODj-ODq-OCq-OCuSDlupciL-elnui-siDnlJ_mtLsg6L-R6YmEIOOBguOBueOBriDjg4_jg6vjgqvjgrkg5bqXkgEJZ2lmdF9zaG9w" target="_blank">
                    <b>日本〒545-8545 Osaka, Abeno Ward, Abenosuji, 1 Chome−1−43 あべのハルカス近鉄本店タワー館10階</b>
                </a></p>
                <p><span>電話:</span>
                <b>06-6624-111</b></p>
                <p><span>營業時間:</span>
                <b>Mon.— Sun. 10:00-20:00</b></p>
            </div>
            <div class="col-md-4 location-info">
                <img src="${pageContext.request.contextPath}/image/location-圓山.png">
                <h5><b>神農市場 圓山花博店</b></h5>
                <p><span>地址:</span>
                <a href="https://www.google.com.tw/maps/place/104%E5%8F%B0%E5%8C%97%E5%B8%82%E4%B8%AD%E5%B1%B1%E5%8D%80%E7%8E%89%E9%96%80%E8%A1%971%E8%99%9F/@25.0700642,121.5204828,17z/data=!4m7!1m4!3m3!1s0x3442a94f37348ea9:0xa8ee38918a912c67!2zMTA05Y-w5YyX5biC5Lit5bGx5Y2A546J6ZaA6KGXMeiZnw!3b1!3m1!1s0x3442a94f37348ea9:0xa8ee38918a912c67" target="_blank">
                    <b>台北市中山區玉門街1號</b>
                </a></p>
                <p><span>電話:</span>
                <b>02-2597-7126 客服電話:02-2597-7112#116</b></p>
                <p><span>營業時間:</span>
                <b>Mon.—Fri. 11:30-19:00
                    Sat.—Sun.11:30-20:00</b></p>
            </div>
            <div class="col-md-4 location-info">
                <img src="${pageContext.request.contextPath}/image/location-誠品.png">
                <h5><b>神農生活 誠品南西店</b></h5>
                <p><span>地址:</span>
                <a href="https://www.google.com/maps/place/%E7%A5%9E%E8%BE%B2%E7%94%9F%E6%B4%BB+MAJI+TREATS/@25.0524088,121.5187478,17z/data=!3m1!5s0x3442a96eb1a06b9f:0xb4ed5f7d2949bca!4m9!1m2!2m1!1zMTA0OTHlj7DljJfluILkuK3lsbHljYDljZfkuqzopb_ot68xNOiZnzTmqJM!3m5!1s0x3442a988652cdf75:0x8e0184d06d670718!8m2!3d25.0521315!4d121.520677!15sCiwxMDQ5MeWPsOWMl-W4guS4reWxseWNgOWNl-S6rOilv-i3rzE06JmfNOaok1o5IjcxMDQ5MSDlj7DljJcg5biCIOS4reWxsSDljYAg5Y2X5LqsIOilvyDot68gMTQg6JmfIDQg5qiTkgEFc3RvcmU" target="_blank">
                    <b>台北市中山區南京西路14號4樓</b>
                </a></p>
                <p><span>電話:</span>
                <b>02-2563-0818 客服專線:02-2597-7112#116</b></p>
                <p><span>營業時間:</span>
                <b>Mon.—Thurs.11:00-22:00
                    Fri.—Sun. 11:00-22:30</b></p>
            </div>
        </div>
    </div>
</body>
</html>