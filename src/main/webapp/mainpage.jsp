<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>독서 커뮤니티</title>
    <link rel="stylesheet" href="mainpage.css">
</head>
<body>
    <div class="container">
        <a href="noticelist.jsp" class="box notice">공지사항</a>
        <a href="reviewlist.jsp" class="box review">독후감</a>
        <div class="recommendation">
            <img src="book.jpg" alt="추천 책 이미지">
            <p>오늘의 추천 책</p>
        </div>
        <a href="gallerylist.jsp" class="box gallery">사진게시판</a>
    </div>

   
</body>
</html>
