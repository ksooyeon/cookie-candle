<%@page import="coocan.com.dao.ReviewDAO"%>
<%@page import="coocan.com.dto.ReviewDTO"%>
<%@page import="coocan.com.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String product=request.getParameter("product");
	String rTitle=Utility.escapeTag(request.getParameter("rTitle"));
	String rContent=Utility.escapeTag(request.getParameter("rContent"));
	String rUid=request.getParameter("rUid");
	
	ReviewDTO review = new ReviewDTO();
	review.setrTitle(rTitle);
	review.setrContent(rContent);
	review.setpNum(Integer.parseInt(product));
	review.setrUid(rUid);//TO-DO 로그인 한 정보 들어가게 바꿔라
	
	ReviewDAO.getDAO().insertReview(review);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=review&work=review_list'");
	out.println("</script>");
%>