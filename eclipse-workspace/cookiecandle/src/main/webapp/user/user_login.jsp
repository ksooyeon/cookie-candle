<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
	
	String id=(String)session.getAttribute("id");
	if(id==null) {
		id="";
	} else {
		session.removeAttribute("id");
	}
%>

<head>
<link href="css/userlogin.css" rel="stylesheet" type="text/css">
</head>
<body>

<div class="container">	
	<h2>로그인회원</h2>
	<form action="index.jsp?workgroup=user&work=user_login_action" method="post" id="login">
	<fieldset>
		<div class=login>
			<label  for="id"></label> 
			<input type="text" name="id" id="id" placeholder="아이디" size="38" value="<%=id %>" >
		</div>
		<div class=login>
			<label  for="passwd"></label> 
			<input  type="password" name="passwd" id="passwd" placeholder="비밀번호" size="38">
		</div>
		<button id="loginbtn">로그인</button>
		<div id="tool">
		<a href="index.jsp?workgroup=user&work=user_join">회원가입</a> |
		<a href="index.jsp?workgroup=user&work=user_idfind">아이디 찾기</a> |
		<a href="index.jsp?workgroup=user&work=user_pwdfind">비밀번호 찾기</a> 
	</div>
	</fieldset>
	<div id="message"><%=message  %></div>
	</form>
</div>
</body>

<script type="text/javascript">
$("#id").focus();

$("#loginbtn").click(function() {
	if($("#id").val()=="") {
		$("#message").text("아이디를 입력해 주세요.");
		$("#id").focus();
		return false;
	}
	
	if($("#passwd").val()=="") {
		$("#message").text("비밀번호를 입력해 주세요.");
		$("#passwd").focus();
		return false;
	}
	
	$("#login").submit();
});
</script>






