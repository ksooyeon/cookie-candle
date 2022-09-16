<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/user/logincheck.jspf" %>

<head>
<style type="text/css">
#passwordBtn a:hover {
	background-color: white;
}

#passwordForm{
	text-align: center;
}
#message{
	text-align: center;
}
#passwordBtn{
	font-size: 13px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 10px;
	padding: 2px 10px;
	border: 1px solid black;
	border-radius : 3px;
	background-color: #fcd158;
}
</style>
</head>

<%
	//액션 값을 받아와서 어디로 갈지 정함
	String action=request.getParameter("action");

	//비정상적인 요청에 대한 응답 처리
	//액션값이 비었거나 modify(변경)과 remove(삭제)가 아니면 에러페이지 이동 
	if(action==null || !action.equals("modify") && !action.equals("remove")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}
	
	
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
%>

<% if(action.equals("modify")) {  //액션값이(modify) 이면 회원정보변경으로 %>
	<p style="text-align: center;">회원정보변경을 위해 비밀번호를 입력해 주세요.</p>
<% } else {  //액션값이(remove) 이면 회원탈퇴로 %>
	<p style="text-align: center;">회원탈퇴를 위해 비밀번호를 입력해 주세요.</p>
<% } %>

<form method="post" name="passwordForm" id="passwordForm">
	<input type="password" name="passwd">
	<button type="button" onclick="submitCheck();" id="passwordBtn">입력완료</button>
</form>
<p id="message" style="color: red;"><%=message %></p>

<script type="text/javascript">
//비밀번호 입력창으로 초점이동
passwordForm.passwd.focus();

//비밀번호 입력값이 비었으면 경고메세지 출력
function submitCheck() {
	if(passwordForm.passwd.value=="") {
		document.getElementById("message").innerHTML="비밀번호를 입력해 주세요.";
		passwordForm.passwd.focus();
		return;
	}
	
	//입력이 완료 되었으면 각자가 눌렀던 액션으로 URL 정보를 다르게 전달 
	<% if(action.equals("modify")) {//회원 정보 변경일때 %>
		passwordForm.action="index.jsp?workgroup=user&work=user_modify";
	<% } else { //회원 탈퇴일때 %>
		passwordForm.action="index.jsp?workgroup=user&work=user_remove";
	<% } %>
	
	passwordForm.submit();
}
</script>









