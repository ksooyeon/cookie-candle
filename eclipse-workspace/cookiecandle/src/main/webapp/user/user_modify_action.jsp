<%@page import="coocan.com.dao.UserDAO"%>
<%@page import="coocan.com.util.Utility"%>
<%@page import="coocan.com.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//비정상적인 요청(GET)방식에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
	return;
	}
	
	//아이디 전달
	String id=request.getParameter("id");
	//비밀번호를 암호화하여 전달하고 변환하여 저장
	String passwd=Utility.encrypt(request.getParameter("passwd"));
	//이름 전달
	String name=request.getParameter("name");
	//이메일 전달
	String email=request.getParameter("email");
	//휴대폰 번호 전달
	String phone=request.getParameter("phone1")+"-"
		+request.getParameter("phone2")+"-"+request.getParameter("phone3");
	//우편번호
	String zipcode=request.getParameter("zipcode");
	//기본주소
	String add1=request.getParameter("add1");
	//상세주소
	String add2=Utility.stripTag(request.getParameter("add2"));
	
	//DTO 객체를 생성해 전달값변경
	UserDTO user=new UserDTO();
	user.setUid(id);
	user.setPasswd(passwd);
	user.setName(name);
	user.setEmail(email);
	user.setPhone(phone);
	user.setZipcode(zipcode);
	user.setAdd1(add1);
	user.setAdd2(add2);
	
	//UserDAO에서 update실행
	UserDAO.getDAO().updateUser(user);
	
	//변경된 권한 세션에 저장
	session.setAttribute("userLogin", UserDAO.getDAO().selectUser(id));
	
	//로그인 입력페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=user&work=user_mypage';");
	out.println("</script>");
	
%>