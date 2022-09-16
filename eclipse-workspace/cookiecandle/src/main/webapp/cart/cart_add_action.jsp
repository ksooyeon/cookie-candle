<%@page import="coocan.com.dao.CartDAO"%>
<%@page import="coocan.com.dto.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/user/logincheck.jspf"%>
    
<%

	String uid=userLogin.getUid();
	
	int pno = 0;
	if(request.getParameter("pno") != null) 
		pno = Integer.parseInt(request.getParameter("pno"));
	
	int quantity = 0;
	if(request.getParameter("result") != null) 
		quantity = Integer.parseInt(request.getParameter("result"));

	CartDTO cart=new CartDTO();
	
	cart.setUid(uid);
	cart.setPid(pno);
	cart.setQuantity(quantity);
	
	CartDAO.getDAO().insertCart(cart);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=cart&work=cart_list'");
	out.println("</script>");
	
	%>