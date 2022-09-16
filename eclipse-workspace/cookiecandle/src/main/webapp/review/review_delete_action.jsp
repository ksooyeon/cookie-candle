<%@page import="coocan.com.dao.ReviewDAO"%>
<%@page import="coocan.com.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	
	ReviewDTO review=ReviewDAO.getDAO().selectReviewView(num);
	
	ReviewDAO.getDAO().deleteReview(num);
	
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=review&work=review_list';");
	out.println("</script>");	
%>








