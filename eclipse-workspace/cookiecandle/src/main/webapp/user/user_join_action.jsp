<%@page import="coocan.com.dao.UserDAO"%>
<%@page import="coocan.com.dto.UserDTO"%>
<%@page import="coocan.com.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//비정상적인 요청(GET)방식에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
	return;
	}
	
	//아이디 전달
	String id=request.getParameter("id");
	//비밀번호를 암호화하여 전달하고 변환하여 저장
	String passwd=Utility.encrypt(request.getParameter("passwd"));
	//이름 전달
	String name=request.getParameter("name");
	//이메일 전달
	String email=request.getParameter("email");
	//휴대폰 번호 전달
	String phone=request.getParameter("phone1")+"-"
		+request.getParameter("phone2")+"-"+request.getParameter("phone3");
	//우편번호
	String zipcode=request.getParameter("zipcode");
	//기본주소
	String add1=request.getParameter("add1");
	//상세주소
	String add2=Utility.stripTag(request.getParameter("add2"));
	
	//DTO 객체를 생성해 전달값변경
	UserDTO user=new UserDTO();
	user.setUid(id);
	user.setPasswd(passwd);
	user.setName(name);
	user.setEmail(email);
	user.setPhone(phone);
	user.setZipcode(zipcode);
	user.setAdd1(add1);
	user.setAdd2(add2);
	
	//UserDAO에서 insert로 삽입
	UserDAO.getDAO().insertUser(user);

	
%>

<head>
<style type="text/css">

#celebrate{
	width: 500px;
	border: 1px solid #d7d5d5;
	margin: 0 auto;
	padding-bottom: 10px;
	text-align: center;

}


span{
	font-weight: bold;
}

#finishBtn{
	background-color: #4a5164;
	color: #fff;
	font-weight: bold; 	
	height: 40px;
	width: 500px;
	text-align: center;
}
.wrap{
	display: flex;
	justify-content: center;
}
.box{
	border: 1px solid black;
	float: left;
	border: 1px solid #d7d5d5;
	height: auto;
}
p{
	margin-left: 10px;
	padding-bottom: 5px;
}
</style>
</head>
<div id="celebrate">
<p><span style="color: blue; font-size: 20px;">회원가입을 축하합니다.</span></p>
<p><span><%=name %></span>님은 <span>[일반 회원]</span> 이십니다</p>
</div>
<div class="wrap">
	<div class="box" style="width: 150px; border-right: none">
		<p>아이디</p>
		<p>이름</p>
		<p>이메일</p>
		<p>전화번호</p>
	</div>
	<div class="box" style="width: 350px; border-left: none">
		<p><%=id %></p>
		<p><%=name %></p>
		<p><%=email %></p>
		<p><%=phone %></p>
	</div>
</div>
<br>
<div style="text-align: center;">
<button type="submit" id="finishBtn" onclick="location.href='index.jsp?workgroup=main&work=main_page';">완료</button>
</div>





