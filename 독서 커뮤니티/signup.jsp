<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	//입력값 받아오기
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	String name=request.getParameter("name");
	String nickname=request.getParameter("nickname");
	String gender=request.getParameter("gender");
	
	List<String> errors=new ArrayList<>();		//에러 목록을 담을 배열
	
	if(username==null || username.trim().isEmpty()) {		//아이디를 입력하지 않았을 경우
		errors.add("아이디를 입력하세요.");
	}
	if(password==null || password.trim().isEmpty()) {		//비밀번호를 입력하지 않았을 경우
		errors.add("비밀번호를 입력하세요.");
	}
	if(name==null || name.trim().isEmpty()) {		//이름을 입력하지 않았을 경우
		errors.add("이름을 입력하세요.");
	}
	if(nickname==null || nickname.trim().isEmpty()){		//닉네임을 입력하지 않았을 경우
		errors.add("닉네임을 입력하세요.");
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
	<title>회원가입_backend</title>
	<script>
		window.onload=function() {
			<% if(hasError) { %>		//회원가입 중 에러가 있을 경우
				alert("<%=errorMessage%>");
				window.location.href="signup.html";
			<% }
			else { %>		//회원가입 중 에러가 없을 경우
				alert("회원가입이 성공적으로 완료되었습니다. 로그인 페이지로 이동합니다.");
				window.location.href="login.html";
			<% } %>
		};
	</script>
</head>
<body>
</body>
</html>