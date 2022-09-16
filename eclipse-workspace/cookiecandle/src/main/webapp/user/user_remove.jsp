<%@page import="coocan.com.dao.UserDAO"%>
<%@page import="coocan.com.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/user/logincheck.jspf" %>
<% 
	//패스워드값 받아옴
	String passwd=Utility.encrypt(request.getParameter("passwd"));	

	//비정상적인 요청(GET)에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}	
	//받아온 비밀번호와 로그인된 유저의 비밀번호가 다를때
	if(!passwd.equals(userLogin.getPasswd()))
	{
		session.setAttribute("message", "비밀번호가 틀립니다");
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=user&work=user_password&action=remove';");
		out.println("</script>");
		return;	
	}
	//아이디의 정보를 받아와서 상태정보를 탈퇴회원(8)으로 변경
	UserDAO.getDAO().updateStatus(userLogin.getUid(), 8);
	
	//페이지이동 시키고 로그아웃시킴
	out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=user&work=user_logout';");
		out.println("</script>");
	
%>