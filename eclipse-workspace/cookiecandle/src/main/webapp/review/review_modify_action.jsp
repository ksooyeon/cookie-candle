<%@page import="coocan.com.dao.ReviewDAO"%>
<%@page import="coocan.com.dto.ReviewDTO"%>
<%@page import="coocan.com.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int product=Integer.parseInt(request.getParameter("product"));
	String rTitle=Utility.escapeTag(request.getParameter("rTitle"));
	String rContent=Utility.escapeTag(request.getParameter("rContent"));
	int rNo=Integer.parseInt(request.getParameter("rNo"));
	
	ReviewDTO review=new ReviewDTO();
	review.setrTitle(rTitle);
	review.setrContent(rContent);
	review.setpNum(product);
	review.setrNo(rNo);
	ReviewDAO.getDAO().updateReview(review);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=review&work=review_list'");
	out.println("</script>");	
%>