<%@page import="coocan.com.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>

<%	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}

	String[] checkPid=request.getParameterValues("checkPno");
	
	for(String id:checkPid) {
		ProductDAO.getDAO().deleteProduct(id);
	}
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='admin_index.jsp?workgroup=admin&work=product_mng';");
	out.println("</script>");
%>