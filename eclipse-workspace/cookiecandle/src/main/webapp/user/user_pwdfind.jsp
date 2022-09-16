<%@page import="coocan.com.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 
 
 	
 %>
<style type="text/css">

h2{
	text-align: center;
	padding-bottom: 10px;
}
fieldset {
	
	margin: 10px auto;
	width: 700px;
	border: 1px solid #d7d5d5;
}

#pwdfind label {
	width: 150px;
	float: left;
	margin-right: 10px;
	padding-left: 10px;
}
input {
	height:22px;
    border: 1px solid #d7d5d5;
 	
}
#pwdfind ul li {
	list-style-type: none;
	margin: 15px auto;
	border-bottom: 1px solid #efefef;
	padding-bottom: 10px;
	
}



.error {
	color: red;
	position: relative;
	left: 160px;
	display: none;
}
#findBtn{
	background-color: #4a5164;
	color: #fff;
	font-weight: bold; 	
	height: 40px;
	width: 700px;
}
#Btn{
text-align: center;
}
input[type="radio"] {
	width:13px;
	height:13px; 
	margin:0 0 2px; 
	padding-right: 5px;
}
</style>

<h2>비밀번호 찾기</h2>
<form action="index.jsp?workgroup=user&work=user_pwdfind_action" method="post" id="pwdfind">


<fieldset>
	<ul>
	
		<li>
			<input type="hidden" name="passwd" id="pass" value=<%=Utility.newPassword() %>>
			<label for="id">아이디</label>
			<input type="text" name="id" id="id">
			<div id="idMsg" class="error">아이디를 입력해 주세요.</div>
		</li>
		<li>
			<label for="name">이름</label>
			<input type="text" name="name" id="name">
			<div id="nameMsg" class="error">이름을 입력해 주세요.	</div>
		</li>
		<li>
			<label for="radiobox">인증 방법</label>
			<input type="radio"   value="email" name="choice"  checked="checked" /> 이메일 
			<input type="radio"   value="phone" name="choice" /> 전화번호 

		</li>
		<li id="email" style="padding-bottom: 0px; border-bottom: none;" >
			<label for="email" id="email">이메일</label>
			<input type="email" name="email" id="email">
			<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
		</li>
		
		<li id="phone" style="padding-bottom: 0px; border-bottom: none;" >
			<label for="phone"  >전화번호</label>
			<select name="phone1" style="width:100px;height:25px;">
				<option value="010" selected>&nbsp;010&nbsp;</option>
				<option value="011">&nbsp;011&nbsp;</option>
				<option value="016">&nbsp;016&nbsp;</option>
				<option value="017">&nbsp;017&nbsp;</option>
				<option value="018">&nbsp;018&nbsp;</option>
				<option value="019">&nbsp;019&nbsp;</option>
			</select>
			- <input type="text" name="phone2" id="phone2" size="10" maxlength="4">
			- <input type="text" name="phone3" id="phone3" size="10" maxlength="4">
			<div id="phoneMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
		</li>
		
	</ul>
	
</fieldset>
<div id="Btn">
<button type="submit" id="findBtn">비밀번호 찾기</button>
</div>
</form>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
$("#id").focus();

$('li#phone').hide();

$("input[name='choice']").change(function () {
	if($("input[name='choice']:checked").val() == 'email'){
	$('li#email').show();
	$('li#phone').hide();
	}
	else if($("input[name='choice']:checked").val() == 'phone'){
	$('li#phone').show();
	$('li#email').hide();
	}
})

$("#pwdfind").submit(function() {
	var submitResult=true;
	
	//에러 관련 메세지 안보이게 설정
	$(".error").css("display","none");
	//아이디 비어있는지 확인
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		submitResult=false;
	}
	//이름 비어있는지 확인
	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
	}
	if($("input[name='choice']:checked").val() == 'email'){
	//이메일 입력값 없을떄
	if($("input[id='email']").val()==""){	
		$("#emailMsg").css("display","block");
		submitResult=false;
	}

}
	return submitResult;
});
	
	



</script>
