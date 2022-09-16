<%@page import="coocan.com.dao.UserDAO"%>
<%@page import="coocan.com.dto.UserDTO"%>
<%@page import="coocan.com.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	//일반회원:0(default), 휴면회원:8, 관리자:9
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	//아이디값 전달받아 저장
	String id=request.getParameter("id");
	//비밀번호 암호화 해서 전달받은후 저장
	String passwd=Utility.encrypt(request.getParameter("passwd"));
	//아이디 전달받아서 저장된 회원정보 검색 DAO
	UserDTO user=UserDAO.getDAO().selectUser(id);
	
	//검색 아이디 회원정보가 없거나 휴면회원 일때 인증실패
	if(user==null || user.getStatus()==8) {
		session.setAttribute("message", "입력된 아이디가 존재하지 않습니다.");
		session.setAttribute("id", id);
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=user&work=user_login';");
		out.println("</script>");
			return;
		}
	//전달된 비밀번호와 회원 비밀번호 다를때 인증실패
	if(!passwd.equals(user.getPasswd())){
		session.setAttribute("message", "입력된 아이디가 잘못 되었거나 비밀번호가 맞지 않습니다.");
		session.setAttribute("id", id);
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=user&work=user_login';");
		out.println("</script>");
		return;
	}
	
	//회원 권한 저장
	session.setAttribute("userLogin", UserDAO.getDAO().selectUser(id));
	
	
	
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=main&work=main_page';");
		out.println("</script>");
	
	

	
%>