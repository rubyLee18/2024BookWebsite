<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	//입력값 받아오기
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	
	List<String> errors=new ArrayList<>();		//에러 목록을 담을 배열
	
	if(username==null || username.trim().isEmpty()) {
		errors.add("아이디를 입력하세요.");
	}
	if(password==null || password.trim().isEmpty()) {
		errors.add("비밀번호를 입력하세요.");
	}
	
	//이 부분은 나중에 DB로 대체
	boolean loginSuccess=false;
	if(errors.isEmpty()) {
		if("SDG".equals(username) && "q1w2e3r4".equals(password)) {		//임시 아이디: SDG, 비밀번호: q1w2e3r4 일치 시
			loginSuccess=true;		//로그인 성공
			session.setAttribute("username", username);		//세션에 사용자 정보 저장
		}
		else{
			errors.add("아이디 또는 비밀번호가 잘못되었습니다.");
		}
	}
	
	boolean hasError=!errors.isEmpty();		//에러 존재 여부
	String errorMessage="";
	if(hasError) {
		errorMessage=String.join("\\n", errors);
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인_backend</title>
<script>
	window.onload=function() {
		<% if(hasError) { %>		//로그인 실패 시
			alert("<%=errorMessage%>");
			window.location.href="login.html";
		<% }
		else  {%>
			alert("로그인에 성공했습니다. 환영합니다 <%=username%>님!");
			window.location.href="mainpage.html";		//메인 페이지로 이동
		<% } %>
	};

</script>
</head>
<body>
</body>
</html>