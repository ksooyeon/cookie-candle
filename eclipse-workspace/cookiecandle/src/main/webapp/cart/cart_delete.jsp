<%@page import="coocan.com.dao.CartDAO"%>
<%@page import="coocan.com.dto.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@include file="/user/logincheck.jspf"%>
<%


	//전달값을 반환받아 저장

	int pid=Integer.parseInt(request.getParameter("pid"));
	String uid=request.getParameter("uid");


	
	
	//BoardDTO 객체를 생성하고 필드값 변경
	CartDTO cart=new CartDTO();
	cart.setPid(pid);
	cart.setUid(uid);
	
	
	
	
	//게시글을 전달받아 BOARD 테이블에 저장된 게시글을 변경하는 DAO 클래스의 메소드 호출

	
	CartDAO.getDAO().deleteCart(pid,uid);
	
	//세션에 저장된 권한 관련 정보(회원정보) 변경
	//	session.setAttribute("loginMember", MemberDAO.getDAO().selectMember(id));
	
	
	
	//페이지 이동
	//out.println("<script type='text/javascript'>");
	//out.println("location.href='index.jsp?workgroup=board&work=board_detail&num="+num
	//	+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
	//out.println("</script>");
	
	%>