<%@page import="coocan.com.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="/user/logincheck.jspf"%>
<head>
<style type="text/css">
fieldset {
	margin: 10px auto;
	width: 700px;
	border: 1px solid #d7d5d5;
}

#modify label {
	width: 150px;
	float: left;
	margin-right: 1px;
	padding-left: 10px;
}

input {
	height: 22px;
	border: 1px solid #d7d5d5;
}

#modify ul li {
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

.Notice {
	color: blue;
	position: relative;
	left: 160px;
}

#postSearch {
	font-size: 13px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 10px;
	padding: 2px 10px;
	border: 1px solid black;
	border-radius : 3px;
	background-color: #fcd158;
}

#postSearch:hover {
	background: white;
}

#modifyBtn {
	background-color: #4a5164;
	color: #fff;
	font-weight: bold;
	height: 40px;
	width: 700px;
}

#Btn {
	text-align: center;
}
</style>
</head>
<%
	//패스워드값 받아옴
	String passwd = Utility.encrypt(request.getParameter("passwd"));
//받아온 비밀번호와 로그인된 유저의 비밀번호가 다를때
	if (!passwd.equals(userLogin.getPasswd())) {
		session.setAttribute("message", "비밀번호가 틀립니다");
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=user&work=user_password&action=remove';");
		out.println("</script>");
		return;
}
%>


<form action="index.jsp?workgroup=user&work=user_modify_action"
	method="post" id="modify">
	<h2 style="text-align: center;">회원정보변경</h2>
	<fieldset>
		<ul>
			<li><label for="id">아이디</label> <!-- 아이디는 변경하면 안되므로 아이디값을 받아와서 readonly 처리 -->
				<input type="text" name="id" id="id" value="<%=userLogin.getUid()%>"
				readonly="readonly"></li>
			<li><label for="passwd">비밀번호</label> <input type="password"
				name="passwd" id="passwd" size="50">
				<div id="passwdMsg" class="Notice">비밀번호를 변경하지 않을경우 입력하지마세요.</div>
				<div id="passwdRegMsg" class="error">비밀번호는 영문자,숫자를 포함하여 6~16
					자리로 입력해주세요.</div></li>
			<li><label for="repasswd">비밀번호 확인</label> <input type="password"
				name="repasswd" id="repasswd" size="50">
				<div id="repasswdMatchMsg" class="error">비밀번호와 비밀번호 확인이 서로 맞지
					않습니다.</div></li>
			<li><label for="name">이름</label> <input type="text" name="name"
				id="name" value="<%=userLogin.getName()%>">
				<div id="nameMsg" class="error">이름을 입력해 주세요.</div></li>
			<li><label for="email">이메일</label> <input type="text"
				name="email" id="email" value="<%=userLogin.getEmail()%>">
				<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
				<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div></li>
			<li><label for="phone">전화번호</label> <%-- 폰번호는 배열로 받아서 - 잘라서 배열처리 --%>
				<%
				String[] phone = userLogin.getPhone().split("-");
				%> <select
				name="phone1" style="width: 100px; height: 25px;">
					<option value="010" <%if (phone[0].equals("010")) {%> selected
						<%}%>>&nbsp;010&nbsp;</option>
					<option value="011" <%if (phone[0].equals("011")) {%> selected
						<%}%>>&nbsp;011&nbsp;</option>
					<option value="016" <%if (phone[0].equals("016")) {%> selected
						<%}%>>&nbsp;016&nbsp;</option>
					<option value="017" <%if (phone[0].equals("017")) {%> selected
						<%}%>>&nbsp;017&nbsp;</option>
					<option value="018" <%if (phone[0].equals("018")) {%> selected
						<%}%>>&nbsp;018&nbsp;</option>
					<option value="019" <%if (phone[0].equals("019")) {%> selected
						<%}%>>&nbsp;019&nbsp;</option>
			</select> - <input type="text" name="phone2" id="phone2" size="10"
				maxlength="4" value="<%=phone[1]%>"> - <input type="text"
				name="phone3" id="phone3" size="10" maxlength="4"
				value="<%=phone[2]%>">
				<div id="phoneMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
				<div id="phoneRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해
					주세요.</div></li>
			<li><label>우편번호</label> <input type="text" name="zipcode"
				id="zipcode" size="7" readonly="readonly"
				value="<%=userLogin.getZipcode()%>"> <span id="postSearch">우편번호
					검색</span>
				<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div></li>
			<li><label for="add1">기본주소</label> <input type="text"
				name="add1" id="add1" size="50" readonly="readonly"
				value="<%=userLogin.getAdd1()%>">
				<div id="add1Msg" class="error">기본주소를 입력해 주세요.</div></li>
			<li style="padding-bottom: 0px; border-bottom: none;"><label
				for="add2">상세주소</label> <input type="text" name="add2" id="add2"
				size="50" value="<%=userLogin.getAdd2()%>">
				<div id="add2Msg" class="error">상세주소를 입력해 주세요.</div></li>
		</ul>

	</fieldset>
	<div id="Btn">
		<button type="submit" id="modifyBtn">정보변경</button>
	</div>
</form>

<script type="text/javascript">
$("#id").focus();
//정보변경 제출버튼 
$("#modify").submit(function() {
	var submitResult=true;
	
	//에러 관련 메세지 안보이게 설정
	$(".error").css("display","none");
	
	//비밀번호 검증 영문,소문자 6~16자
	var passwdReg=/(?=.*\d)(?=.*[a-zA-ZS]).{6,16}/;
		//비밀번호 검증값 맞지않을때
	} else if(!passwdReg.test($("#passwd").val())) {
		$("#passwdRegMsg").css("display","block");
		submitResult=false;
	} 
	//비밀번호 검증과 비밀번호 일치하는지 확인
	} else if($("#passwd").val()!=$("#repasswd").val()) {
		$("#repasswdMatchMsg").css("display","block");
		submitResult=false;
	}
	//이름 비어있는지 확인
	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
	}
	//이메일 검사 @ 포함
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	//이메일 입력값 없을떄
	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
		submitResult=false;
		//이메일 검증과 맞지않을때
	} else if(!emailReg.test($("#email").val())) {
		$("#emailRegMsg").css("display","block");
		submitResult=false;
	}
	//휴대전화 자리수 검사
	var phone2Reg=/\d{3,4}/;
	var phone3Reg=/\d{4}/;
	if($("#phone2").val()=="" || $("#phone3").val()=="") {
		$("#phoneMsg").css("display","block");
		submitResult=false;
	} else if(!phone2Reg.test($("#phone2").val()) || !phone3Reg.test($("#phone3").val())) {
		$("#phoneRegMsg").css("display","block");
		submitResult=false;
	}
	//우편번호 비어있는지 확인
	if($("#zipcode").val()=="") {
		$("#zipcodeMsg").css("display","block");
		submitResult=false;
	}
	//기본주소 비어있는지 확인
	if($("#add1").val()=="") {
		$("#add1Msg").css("display","block");
		submitResult=false;
	}
	//상세주소 비어있는지 확인
	if($("#add2").val()=="") {
		$("#add2Msg").css("display","block");
		submitResult=false;
	}
	
	return submitResult;
});

</script>
<!-- 다음 주소 API 팝업 -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

$("#postSearch").click(function() {	
    new daum.Postcode({
        oncomplete: function(data) {
        	join.zipcode.value=data.zonecode;;
    		join.add1.value=data.roadAddress;
        }
    }).open();
});
</script>
