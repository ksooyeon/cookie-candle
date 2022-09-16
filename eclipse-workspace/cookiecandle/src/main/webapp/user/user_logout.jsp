<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//세션에 관련된 정보들 무효화 처리
	session.invalidate();
	
	//로그인 페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=user&work=user_login';");
	out.println("</script>");
%>