<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate();
	response.setContentType("application/json; charset=UTF-8");
	response.getWriter().write("{ \"success\": true }");
%>
