<%@page import="coocan.com.dao.UserDAO"%>
<%@page import="coocan.com.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("id")==null) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}

	//아이디 전달값을 반환받아 저장
	String id=request.getParameter("id");
	
	//아이디 전달받아서 USER 테이블에서 회원정보 검색하는 DAO 클래스 selectUser메소드
	UserDTO user=UserDAO.getDAO().selectUser(id);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
<style type="text/css">
div {
	text-align: center;
	margin: 10px;
}

.id { 
	font-weight: bold;
	color: green; 
}
</style>
</head>
<body>
	<% if(user==null) {//전달받은 아이디가 중복되지 않은 경우 %>
		<div>입력된 <span class="id">[<%=id %>]</span>는 사용 가능한 아이디입니다.</div>
		<div>
			<button type="button" onclick="selectId();">아이디 사용하기</button>
		</div>
		
		<script type="text/javascript">
		function selectId() {
			//opener : 팝업창의 부모창을 표현하기 위한 자바스트립트 객체
			//부모창의 아이디 입력태그의 입력값 변경
			opener.join.id.value="<%=id%>";
			//부모창의 아이디 사용 가능 여부를 구분하는 입력태그의 입력값 변경
			opener.join.idCheckResult.value="1";
			window.close();//창닫기 - 팝업창 종료
		}
		</script>
	<% } else {//전달받은 아이디가 중복된 경우 %>
		<div id="message">
			입력된 <span class="id">[<%=id %>]</span>는 이미 사용중인 아이디입니다.<br>
			다른 아이디를 입력하고 [확인] 버튼을 눌러주세요.
		</div>
		<div>
			<%-- form 태그의 action 속성이 생략된 경우 현재 요청 JSP 문서를 요청 --%>
			<%-- form 태그의 method 속성이 생략된 경우 [get] 방식으로 요청 --%>
			<form name="checkForm">
				<input type="text" name="id">
				<button type="button" onclick="idCheck();">확인</button>
			</form>
		</div>
		
		<script type="text/javascript">
		function idCheck() {
			var id=checkForm.id.value;
			if(id=="") {
				document.getElementById("message").innerHTML="아이디를 입력해 주세요.";
				document.getElementById("message").style="color: red";
				return;
			}
			
			var idReg=/^[a-z]+[a-z0-9]{3,15}$/g;
			if(!idReg.test(id)) {
				document.getElementById("message").innerHTML="아이디는 영문자로 시작되는 영문자,숫자의 4~16범위의 문자로만 작성 가능합니다.";
				document.getElementById("message").style="color: red";
				return;
			}
			
			checkForm.submit();
		}
		</script>
	<% } %>
</body>
</html>






