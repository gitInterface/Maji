<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>關於品牌</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">

    </script>
    <style>
    .container .title{
        font-size: 30px;
    }
    .container p{
        font-size: 18px;
    }
    .container .list{
        font-size: 18px;
    }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6">
                <img src="${pageContext.request.contextPath}/image/about-img.png" class="img-fluid" alt="About Image">
            </div>
            <div class="col-md-6">
                <b class="title">走進來，裝進生活</b>
                <p>神農生活maji treats販售的是台灣溫度，從具有地⽅特⾊的節氣物<br>
                    產、風⼟故事好食、傳統市場醬料、到風格選物等，感受⼀種好感的<br>
                    ⽣活富⾜與美好能量，同時，為了傳遞更多的生活想法和地方故事，<br>
                    即以「⾛進來，裝進⽣活」之品牌宣⾔，實踐超市的美好可能。</p>
                <p>神農生活は台湾味あるものを販売し、台湾の良いものが集う一つの<br>
                    プラットフォームを構築しています。地方の特色ある季節の農産品<br>
                    や、風土にまつわるストーリーと食べ物、昔ながらの市場で販売し,<br>
                    ているソース、スタイリッシュなギフトなどを取り扱っています。<br>
                    生活の中のささやかなものからも、豊かさや美しいエネルギーを感<br>
                    じることができます。</p>
            </div>
        </div>
    </div>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6">
                <img src="${pageContext.request.contextPath}/image/about-img2.png" class="img-fluid" alt="About Image">
            </div>
            <div class="col-md-6">
                <b class="title">以「L.E.S.S.」佐以生活提案練習美好</b>
                <p>神農生活持續挖掘隱藏民間的好物，並建立自己的選品原則，將<br>
                    「Less is more.」的生活主張植入其中，強調LOCAL(地方性)、<br>
                    ESSENTIAL(必要性)、SEASONAL(季節性)、 SUITABLE(合宜性)的理念，<br>
                    為顧客尋求更美好的商品內涵，除了日常不可缺少的好食材之外， <br>
                    更重視以「生活提案」與生活者產生共鳴，期望最終能獲得認同。</p>
                <ul class="list">
                    <li>LOCAL 地方性　
                        推廣在地職人、地方好物，並與值得信賴的生產者作為合作夥伴。</li>
                    <li>ESSENTIAL必要性　
                        重視食材的基礎，避免過多的加工及包裝，以日常所需的食品及用品進入顧客生活。</li>
                    <li>SEASONAL 季節性
                        享用時令食材，簡單即能豐富，跟著節氣過生活。</li>
                    <li>SUITABLE合宜性　
                        提供合適的商品、合宜的價格，不過多選擇的理想生活。</li>
                    <li>Local 地域性
                        信頼できる地域の生産者や職人と連携し、地方の名産品をセレクトする</li>
                    <li>Essential 必要性
                        原材料を重視し、生活に本当に必要なものを提案する</li>
                    <li>Seasonal 季節性
                        旬の食材を楽しむ</li>
                    <li>Suitable 適切性
                        シンプルだけど、心豊かになる
                        季節感のある生活にする</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>