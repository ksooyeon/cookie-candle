<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
	
	request.setCharacterEncoding("utf-8");

	String workgroup=request.getParameter("workgroup");
	if(workgroup==null) workgroup="main";
	
	String work=request.getParameter("work");
	if(work==null) work="main_page";
	
	String contentPath=workgroup+"/"+work+".jsp";


%>   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link href="css/menu_dropdown.css" rel="stylesheet" type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="header">
		<jsp:include page="header.jsp"/>
	</div>
	
	<%-- Content 영역 : 요청에 대한 결과 출력 --%>
	<div id="content">
	<jsp:include page="<%=contentPath %>"/>		
	</div>
	
	<%-- Footer 영역 : 저작권,약관,개인정보 보호정책,회사주소등 --%>
	<div id="footer">
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>