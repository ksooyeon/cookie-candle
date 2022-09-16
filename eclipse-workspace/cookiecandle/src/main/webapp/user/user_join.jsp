<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<head>
<style type="text/css">
fieldset {
	
	margin: 10px auto;
	width: 700px;
	border: 1px solid #d7d5d5;
}

#join label {
	width: 150px;
	float: left;
	margin-right: 1px;
	padding-left: 10px;
}
input {
	height:22px;
    border: 1px solid #d7d5d5;

 	
}
#join ul li {
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

#idCheck, #postSearch {
	font-size: 13px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 10px;
	padding: 2px 10px;
	border: 1px solid black;
	border-radius : 3px;
	background-color: #fcd158;
}

#idCheck:hover, #postSearch:hover {
	background: white;
}
#joinBtn{
	background-color: #4a5164;
	color: #fff;
	font-weight: bold; 	
	height: 40px;
	width: 700px;
}
#Btn{
text-align: center;
}


</style>
</head>

<h2 style="text-align: center;">회원가입</h2>
<form action="index.jsp?workgroup=user&work=user_join_action" method="post" id="join">

<input type="hidden" name="idCheckResult" id="idCheckResult" value="0">

<fieldset>
	<ul>
		<li>
			<label for="id">아이디</label>
			<input type="text" name="id" id="id"><span id="idCheck">아이디 중복 체크</span>
			<div id="idMsg" class="error">아이디를 입력해 주세요.</div>
			<div id="idRegMsg" class="error">아이디는 영문자로 시작되는 영문자,숫자의 4~16자리로 입력해 주세요.</div>
			<div id="idCheckMsg" class="error">아이디 중복 검사를 반드시 실행해 주세요.</div>
		</li>
		<li>
			<label for="passwd">비밀번호</label>
			<input type="password" name="passwd" id="passwd" size="50">
			<div id="passwdMsg" class="error">비밀번호를 입력해 주세요.</div>
			<div id="passwdRegMsg" class="error">비밀번호는 영문자,숫자를 포함하여 6~16 자리로 입력해주세요.</div>
		</li>
		<li>
			<label for="repasswd">비밀번호 확인</label>
			<input type="password" name="repasswd" id="repasswd" size="50">
			<div id="repasswdMsg" class="error">비밀번호 확인을 입력해 주세요.</div>
			<div id="repasswdMatchMsg" class="error">비밀번호와 비밀번호 확인이 서로 맞지 않습니다.</div>
		</li>
		<li>
			<label for="name">이름</label>
			<input type="text" name="name" id="name" size="50">
			<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
		</li>
		<li>
			<label for="email">이메일</label>
			<input type="text" name="email" id="email" size="50">
			<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
			<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
		</li>
		<li>
			<label for="phone">전화번호</label>
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
			<div id="phoneRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
		</li>
		<li>
			<label>우편번호</label>
			<input type="text" name="zipcode" id="zipcode" size="7" readonly="readonly">
			<span id="postSearch">우편번호 검색</span>
			<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
		</li>
		<li>
			<label for="add1">기본주소</label>
			<input type="text" name="add1" id="add1" size="50" readonly="readonly">
			<div id="add1Msg" class="error">기본주소를 입력해 주세요.</div>
		</li>
		<li style="padding-bottom: 0px; border-bottom: none;">
			<label for="add2">상세주소</label>
			<input type="text" name="add2" id="add2" size="50">
			<div id="add2Msg" class="error">상세주소를 입력해 주세요.</div>
		</li>
	</ul>
	
</fieldset>
<div id="Btn">
<button type="submit" id="joinBtn">회원가입</button>
</div>
</form>

<script type="text/javascript">
$("#id").focus();
//회원가입 제출버튼 
$("#join").submit(function() {
	var submitResult=true;
	
	//에러 관련 메세지 안보이게 설정
	$(".error").css("display","none");
	//아이디 검증 영문,소문자 4~16자
	var idReg= /^[a-z]+[a-z0-9]{3,15}$/g;
	//아이디가 입력값이 없을때
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		submitResult=false;
		//아이디 검증값 맞지않을때 에러메세지 출력
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		submitResult=false;
		//아이디 중복 검사 프로그램을 실행안했을때
	} else if($("#idCheckResult").val()=="0") {
		$("#idCheckMsg").css("display","block");
		submitResult=false;
	}
	//비밀번호 검증 영문,소문자 6~16자
	var passwdReg=/(?=.*\d)(?=.*[a-zA-ZS]).{6,16}/;
	//비밀번호 입력값이 없을때
	if($("#passwd").val()=="") {
		$("#passwdMsg").css("display","block");
		submitResult=false;
		//비밀번호 검증값 맞지않을때
	} else if(!passwdReg.test($("#passwd").val())) {
		$("#passwdRegMsg").css("display","block");
		submitResult=false;
	} 
	//비밀번호 확인 비어있는지 확인
	if($("#repasswd").val()=="") {
		$("#repasswdMsg").css("display","block");
		submitResult=false;
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

$("#idCheck").click(function() {
	//아이디 관련 에러메세지가 보여되지 않도록 설정
	$("#idMsg").css("display", "none");
	$("#idRegMsg").css("display", "none");
	
	var idReg= /^[a-z]+[a-z0-9]{3,15}$/g;;
	//아이디가 입력값이 없을때
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		return;
		//아이디 입력값 검증
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		return;
	}
	
	//팝업창을 이용해서 아이디 중복검사 페이지 전달
	window.open("<%=request.getContextPath()%>/user/user_id_check.jsp?id="+$("#id").val()
			,"idcheck","width=450,height=100,left=700,top=400");
});

//아이디 입력태그의 입력값이 바뀐경우 실행되는 이벤트
$("#id").change(function() {
	//아이디 중복 검사 미실행 처리 - 아이디 입력값 바꼈을때
	$("#idCheckResult").val("0");
});


</script>

<!-- 다음 주소 API 팝업 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

$("#postSearch").click(function() {	
    new daum.Postcode({
        oncomplete: function(data) {
        	join.zipcode.value=data.zonecode;
    		join.add1.value=data.roadAddress;
        }
    }).open();
});
</script>
