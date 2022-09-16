<%@page import="coocan.com.util.Utility"%>
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
	padding-bottom: 10px;
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

	String pass=request.getParameter("passwd");
	String id=request.getParameter("id");
	String passwd=Utility.encrypt(request.getParameter("passwd"));
	String name=request.getParameter("name");
	String choice=request.getParameter("choice");
	String email=request.getParameter("email");
	String phone=request.getParameter("phone1")+"-"
			+request.getParameter("phone2")+"-"+request.getParameter("phone3");
	
	
	UserDTO userinfo=UserDAO.getDAO().pwd_search(id,name, email,phone,choice);
	UserDTO user=UserDAO.getDAO().selectUser(id);
	if(userinfo==null || user.getStatus()==8){
		out.println("<script type='text/javascript'>");
		out.println("alert('일치하는 회원정보가 없습니다')");
		out.println("location.href='index.jsp?workgroup=user&work=user_pwdfind';");
		out.println("</script>");
			return;
	}
	
	if(user!=null && user.getStatus()!=8){
		user.setPasswd(passwd);
		UserDAO.getDAO().updatePwd(passwd, id);
	}
	
	
%>

<h1>비밀번호 찾기</h1>
<div id="infowin">
	<div id="info">
	<% if(choice.equals("email")){  //라디오 박스에서 값이 email 이면 이름과 이메일로 검색 %>
	
			<p style="font-weight: bold;">임시비밀번호 발급이 완료 되었습니다.</p>
			<p>아이디:<%=id %></p>
			<p>이름:<%=name %></p>
			<p>이메일:<%=email %></p>
			<p>회원님의 임시비밀번호는 <span style="color: blue; font-weight: bold;"><%=pass %></span>입니다</p>		
	<% } else { //라디오 박스 값이 phone 이면 이름과 전화번호로 검색 %>
			<p style="font-weight: bold;">임시비밀번호 발급이 완료 되었습니다.</p>
			<p>아이디:<%=id %></p>
			<p>이름:<%=name %></p>
			<p>전화번호:<%=phone %></p>
			<p>회원님의 임시비밀번호는 <span style="color: blue; font-weight: bold;"><%=pass %></span>입니다</p>
	<% } %>	
	</div>
	
</div>

<div id="link">
	<a href="index.jsp?workgroup=user&work=user_login">로그인하러가기</a>&nbsp;&nbsp;
	<a href="index.jsp?workgroup=user&work=user_pwdfind">다시입력</a>&nbsp;&nbsp;
	</div>
