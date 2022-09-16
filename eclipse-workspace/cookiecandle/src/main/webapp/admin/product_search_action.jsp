<%@page import="coocan.com.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>

<% 
	if(request.getMethod().equals("POST")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='admin_index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}

	String pname = request.getParameter("pname");
	String[] category = request.getParameterValues("category");
	String sdate = request.getParameter("startdate");
	String edate = request.getParameter("enddate"); 
	
	ProductDAO.getDAO().selectProductList(pname, category, sdate, edate);
%>