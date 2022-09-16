<%@page import="coocan.com.dao.UserDAO"%>
<%@page import="coocan.com.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style type="text/css">
h1{
	text-align: center;	
	font-weight: bold;
}
#infowin{
	text-align: center;
	margin: 10px auto;
	width: 700px;
	border: 1px solid #d7d5d5;

}
#info{
	width: 500px;
	margin: 0 auto;
	
}
#link{
	text-align: center;
	padding-top: 10px;
}
#link a:hover {
	background-color: white;
}
#link a{
	font-size: 13px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 10px;
	padding: 2px 10px;
	border: 1px solid black;
	border-radius : 3px;
	background-color: #fcd158;
}
p{
	padding-bottom: 5px;
}
</style>  
    
<%
	
	
	
	String name=request.getParameter("name");
	String choice=request.getParameter("choice");
	String email=request.getParameter("email");
	String phone=request.getParameter("phone1")+"-"
			+request.getParameter("phone2")+"-"+request.getParameter("phone3");
	
	
	
	//아이디 찾기 DAO
	UserDTO userinfo=UserDAO.getDAO().id_search(name,email,phone, choice);
	if(userinfo==null){
		out.println("<script type='text/javascript'>");
		out.println("alert('일치하는 회원정보가 없습니다')");
		out.println("location.href='index.jsp?workgroup=user&work=user_idfind';");
		out.println("</script>");
			return;
	}else{
		//userinfo가 null이 아니라면 유저의 정보를 받아와서 탈퇴회원이면 로그인화면으로
		UserDTO user=UserDAO.getDAO().selectUser(userinfo.getUid());
		if(user.getStatus()==8){
			out.println("<script type='text/javascript'>");
			out.println("alert('일치하는 회원정보가 없습니다')");
			out.println("location.href='index.jsp?workgroup=user&work=user_idfind';");
			out.println("</script>");
				return;
		}
	}
	
	


	
	
	
	
%>

<h1>아이디 찾기 결과</h1>
<div id="infowin">
	<div id="info">
	
	<% if(choice.equals("email")){  //라디오 박스에서 값이 email 이면 이름과 이메일로 검색 %>
				<p style="font-weight: bold;">아이디 찾기가 완료 되었습니다.</p>
				<p>이름:<%=name %></p>
				<p>이메일:<%=email %></p>
				<p>회원님의 아이디는 <span style="color: blue; font-weight: bold;"><%=userinfo.getUid()%></span>입니다</p>
		<% } else { //라디오 박스에서 값이 phone 일때 %>
			
				<p style="font-weight: bold;">아이디 찾기가 완료 되었습니다.</p>
				<p>이름:<%=name %></p>
				<p>전화번호:<%=phone %></p>
				<p>회원님의 아이디는 <span style="color: blue; font-weight: bold;"><%=userinfo.getUid()%></span>입니다</p>
		<% } %>	
			
	</div>
	
</div>
<div id="link">
	<a href="index.jsp?workgroup=user&work=user_login">로그인하러가기</a>&nbsp;&nbsp;
	<a href="index.jsp?workgroup=user&work=user_idfind">다시입력</a>&nbsp;&nbsp;
</div>

