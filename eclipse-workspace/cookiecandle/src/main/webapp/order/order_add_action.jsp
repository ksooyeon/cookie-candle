

<%@page import="coocan.com.dto.UserDTO"%>
<%@page import="coocan.com.dao.OrderDAO"%>
<%@page import="coocan.com.dto.OrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <%@include file="/user/logincheck.jspf"%>
<%

	
	String uid=userLogin.getUid();
	String add1=request.getParameter("add1");
	String add2=request.getParameter("add2");
	String zipcode=request.getParameter("zipcode");
	String payment=request.getParameter("payment");

	
	// String add2=Utility.stripTag(request.getParameter("add2"))
	
			
	//DTO 객체를 생성하여 반환받은 전달값으로 필드값 변경
	OrderDTO order=new OrderDTO();
	
	order.setUid(uid);
	order.setAdd1(add1);
	order.setAdd2(add2);
	order.setZipcode(zipcode);
	order.setPayment(payment);


	OrderDAO.getDAO().insertOrder(order);
	
	//세션에 저장된 권한 관련 정보(회원정보) 변경
	//session.setAttribute("loginMember", MemberDAO.getDAO().selectMember(id));
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=user&work=user_mypage';");
	out.println("</script>");
	
	%>