<%@page import="coocan.com.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>

<%	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}

	String[] checkBid = request.getParameterValues("checkBno");
	String category = request.getParameter("board_category");
	
	for(String id: checkBid) {
		BoardDAO.getDAO().deleteBoard(id, category);
	}
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='admin_index.jsp?workgroup=admin&work=board_mng';");
	out.println("</script>");
%>