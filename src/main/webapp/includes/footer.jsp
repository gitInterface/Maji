<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>頁尾</title>
    <%@ include file="/includes/libs.jsp" %>
    <script type="text/javascript">

    </script>
    <style>
        .footer {
            background-color: #f8f9fa;
            padding: 20px 0;
            text-align: center;
        }
        .footer img {
            max-width: 100%;
        }
        .footer-nav {
            list-style: none;
            padding: 0;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }
        .footer-nav li {
            margin: 0 15px;
        }
        .footer-nav a {
            text-decoration: none;
            color: black;
            font-weight: bold;
        }
        .footer-nav a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="footer">
        <div>
            <img src="${pageContext.request.contextPath}/image/maji-footer-logo.png" alt="頁尾圖示">
        </div>
        <ul class="footer-nav">
            <li><a href="/pages/aboutbrand"><span>&gt;</span>BRAND</a></li>
            <!-- <li><a href="#"><span>&gt;</span>FAQ</a></li> -->
            <li><a href="/pages/location"><span>&gt;</span>LOCATION</a></li>
            <li><a href="/pages/termsofuse"><span>&gt;</span>TERMS OF USE</a></li>
            <li><a href="/pages/privacypolicy"><span>&gt;</span>PRIVACY POLICY</a></li>
            <li><a href="https://www.104.com.tw/company/1a2x6bixlr" target="_blank">JOIN US</a></li>
        </ul>
    </div>

</body>
</html>