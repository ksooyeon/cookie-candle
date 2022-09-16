<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/user/logincheck.jspf" %>


<style type="text/css">
h1{
	
	text-align: center;
	width : 600px;
	margin: 0 auto;
	padding-bottom: 10px;
	border: 2px solid #d7d5d5;
	font-weight: bold;
	background-color: #fcd158;
}
hr{
	border: 1px solid #d7d5d5;
}
#detail {
	width: 600px;
	margin: 0 auto;
	text-align: left;
	border: 2px solid #d7d5d5;
	
}
p{
	margin: 5px;
	padding-bottom: 5px;
}

#link {
	font-size: 1.1em;
	text-align: center;
	padding-top: 10px
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
</style>

<h1>내정보</h1>
<div id="detail">
	<p>아이디 = <%=userLogin.getUid() %></p>
	<hr>
	<p>이름 = <%=userLogin.getName() %></p>
	<hr>
	<p>이메일 = <%=userLogin.getEmail() %></p>
	<hr>
	<p>전화번호 = <%=userLogin.getPhone() %></p>
	<hr>
	<p>주소 = [<%=userLogin.getZipcode() %>]<%=userLogin.getAdd1() %> <%=userLogin.getAdd2() %></p>
	
</div>

<div id="link">

	<!-- 누른 결과에 따라 주문 목록창 또는 회원정보변경 또는 회원탈퇴창 이동전 비밀번호 인증창으로 이동 -->
	<a href="index.jsp?workgroup=user&work=user_order_list">주문목록</a>&nbsp;&nbsp;
	<a href="index.jsp?workgroup=user&work=user_password&action=modify">회원정보변경</a>&nbsp;&nbsp;
	<a href="index.jsp?workgroup=user&work=user_password&action=remove">회원탈퇴</a>&nbsp;&nbsp;
	
</div>
