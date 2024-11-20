<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String username=(String) session.getAttribute("username");
	if(username!=null) {
		//사용자 정보를 DB에서 삭제하는 로직 추가
	}
	session.invalidate();
	response.setContentType("application/json; charset=UTF-8");
	response.getWriter().write("{ \"success\": true }");
%>