<%@page import="coocan.com.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	//세션에 저장된 권한 관련 정보(회원정보)를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
--%> 
<%
	//세션에 저장된 로그인 정보
	UserDTO userLogin=(UserDTO)session.getAttribute("userLogin");
%>
<div id="cookie_header">
	<div class="main_box">
		<div class="common hleft">
			<div class="hcontent">
				</div>
				<div id="mySidebar" class="sidebar">
	  			<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
	 			<a href="index.jsp">HOME</a>
	  			<a href="index.jsp?workgroup=product&work=product_all">ALL</a>
	 			<a href="index.jsp?workgroup=product&work=product_candle">Candle</a>
	  			<a href="index.jsp?workgroup=product&work=product_candleHolder">Candle Holder</a>
	  			<a href="index.jsp?workgroup=product&work=product_candleCare">Candle Care</a>
	  			<a href="index.jsp?workgroup=notice&work=notice_list">Community</a>
			</div>
	
			<div id="main">
	 		 <button class="openbtn" onclick="openNav()">☰</button>  
		</div>
				
		</div>
		<div class="common hcenter">
			<div class="hcontent">
				<a href="index.jsp" id="main_logo">Cookie Candle</a>
			</div>
		</div>
		<div class="common hright">
			<div class="hcontent">
				<%if(userLogin==null) { //로그인정보 없음(비회원) %>
				<a href="index.jsp?workgroup=user&work=user_login" class="right_btn">로그인</a>
				<a href="index.jsp?workgroup=user&work=user_join" class="right_btn">회원가입</a>
			<% } else { //회원일경우
					if(userLogin.getStatus() == 9) { // 관리자일 경우 %>
						<a href="admin_index.jsp?workgroup=admin&work=admin_home" class="right_btn">관리자</a>
				<% } %>
				<a href="index.jsp?workgroup=user&work=user_mypage" class="right_btn">내정보</a>
				<a href="index.jsp?workgroup=user&work=user_logout" class="right_btn">로그아웃</a>
			<% } %>
				<a href="index.jsp?workgroup=cart&work=cart_list" class="right_btn"><img src="icon/shoppingcart_icon.png"></a>
				<a href="index.jsp?workgroup=product&work=product_search" class="right_btn"><img src="icon/serch_icon.png"></a>
			</div>
		</div>
	</div>
	<div id="menu_bar">
		<ul class="main1">
			<li><a href="index.jsp?workgroup=product&work=product_all">ALL</a></li>
			<li><a href="index.jsp?workgroup=product&work=product_candle">Candle</a></li>
			<li><a href="index.jsp?workgroup=product&work=product_candleHolder">Candle Holder</a></li>
			<li><a href="index.jsp?workgroup=product&work=product_candleCare">Candle Care</a></li>
			<li class="li_community">
				<a href="index.jsp?workgroup=notice&work=notice_list">Community</a>
				<ul class="main2" id="main2">
        			<li class="main2_depth" id="main2_depth"><a href="index.jsp?workgroup=notice&work=notice_list">notice</a></li>
        			<li class="main2_depth" id="main2_depth"><a href="index.jsp?workgroup=review&work=review_list">review</a></li>
        			<li class="main2_depth" id="main2_depth"><a href="index.jsp?workgroup=question&work=question_list">q&a</a></li>
        		</ul>                       
			</li>
		</ul>
	</div>
</div>

<script type="text/javascript">
function openNav() {
	  document.getElementById("mySidebar").style.width = "250px";
	  document.getElementById("main").style.marginLeft = "250px";
	}

	function closeNav() {
	  document.getElementById("mySidebar").style.width = "0";
	  document.getElementById("main").style.marginLeft= "0";
	}
</script>