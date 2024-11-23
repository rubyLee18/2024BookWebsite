<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%
int id = Integer.parseInt(request.getParameter("id"));
String loggedInUsername = (String) session.getAttribute("username");
String reviewAuthorUsername = "";
String reviewAuthorNickname = "";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookcom?useUnicode=true&characterEncoding=utf8", "root", "1116");
    
    // 조회수 증가
    String updateSql = "UPDATE reviews SET views = views + 1 WHERE id = ?";
    pstmt = conn.prepareStatement(updateSql);
    pstmt.setInt(1, id);
    pstmt.executeUpdate();
    pstmt.close();  // pstmt를 재사용하기 전에 명시적으로 닫아줍니다.

    // 글 정보 가져오기
    String sql = "SELECT r.*, u.nickname FROM reviews r JOIN users u ON r.author = u.username WHERE r.id = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, id);
    rs = pstmt.executeQuery();
    
    if (rs.next()) {
        reviewAuthorUsername = rs.getString("author");
        reviewAuthorNickname = rs.getString("nickname");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>독후감</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div id="header-container"></div>
    <h1>독후감</h1>
    <h2><%= rs.getString("title") %></h2>
    <p>번호: <%= rs.getInt("id") %> | 작성일: <%= rs.getTimestamp("created_at") %> | 작성자: <%= reviewAuthorNickname %> | 조회수: <%= rs.getInt("views") %></p>
    <div class="content">
        <p><%= rs.getString("content") %></p>
    </div>
    <div class="button-group">
        <button onclick="location.href='reviewlist.jsp'">목록</button>
        <% if ((loggedInUsername != null && loggedInUsername.equals(reviewAuthorUsername)) || "admin".equals(loggedInUsername)) { %>
            <button onclick="location.href='reviewedit.jsp?id=<%= rs.getInt("id") %>'">수정</button>
            <button onclick="location.href='deleteReview.jsp?id=<%= rs.getInt("id") %>'">삭제</button>
        <% } %>
    </div>
</body>
</html>
<%
    } else {
        out.println("<script>alert('존재하지 않는 게시물입니다.'); history.back();</script>");
    }
} catch (Exception e) {
    e.printStackTrace();
    out.println("<script>alert('오류가 발생했습니다. 다시 시도해 주세요.'); history.back();</script>");
} finally {
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
}
%>
