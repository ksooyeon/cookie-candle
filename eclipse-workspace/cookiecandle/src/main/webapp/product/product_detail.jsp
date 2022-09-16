<%@page import="coocan.com.dto.UserDTO"%>
<%@page import="coocan.com.dao.ReviewDAO"%>
<%@page import="coocan.com.dto.ReviewDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="coocan.com.dao.ProductDAO"%>
<%@page import="coocan.com.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//PRODUCT 테이블에 저장된 모든 제품정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	int pno=Integer.parseInt(request.getParameter("pno"));
	ProductDTO product= ProductDAO.getDAO().selectProduct(pno);
	
	List<ReviewDTO> reviewList=ReviewDAO.getDAO().selectReviewProductList(pno);
	
	UserDTO userLogin=(UserDTO)session.getAttribute("userLogin");

%>
<link href="css/product_detail.css" rel="stylesheet" type="text/css">

 	<div class="main-detail-box">
 		<div class="detail-box">
 			<div class="detail-pimg">
 			<img src="<%=request.getContextPath()%>/img/<%=product.getImg1()%>">
 			<div>
 				<img src="">
 				<img src="">
 			</div>
 		</div>
 		<div class="detail-group">
 			<div class="detail-title">
 				<p><%=product.getPname() %></p>
 				<p><%=DecimalFormat.getInstance().format(product.getPrice())%>원</p>
 				<hr>
 			</div>
 			<div class="detail-info">
 				<ul>
 					<li><b>원산지</b> 대한민국</li>
 					<li><b>구매헤택</b> 250 포인트 적립예정</li>
 					<li><b>배송방법</b> 택배</li>
 					<li><b>배송비</b> 무료배송</li>
 				</ul>
 			</div>
 			
 			<!-- 수량 변화해서 장바구니로 보내기 -->
 			<form name="cartForm" id="cartForm" method="post" action="index.jsp?workgroup=cart&work=cart_add_action">
 			<input type="hidden" name="pno" value="<%=pno%>"></input>
			 <div class="qnty-box">
					 <div class="qnty-box-result">
						<button type="button" id="sub">-</button>
						<input id="result" name="result" value="1" ></input>
						<button type="button" id="add">+</button>				
			 			<input type="hidden" id="priceResult" name="priceResult" value="<%=product.getPrice()%>" readonly>
					 <div class="qnty-box-price">
						<span>총 상품금액</span>
						<input id="totalPrice" name="totalPrice" style="border: none;" readonly>원</input>
					</div>
				 	
			 </div>
			 </div>
 				<button type="submit" class="btn black" id="payBtn">구매하기</button>
 				<button type="submit" class="btn" id="cartBtn" >장바구니</button>
			</form>
 		</div>
 		</div>
 	    
 	    <!-- 
 		<ul class="menu-tab">
 			<li>상세정보</li>
 			<li>구매평</li>
 			<li>Q&A</li>
 		</ul>
 	    -->
 		<div class="line-box"></div>
 		
 		<div class="menu-tab">
 			<div><a href="#prd-menu-tab"> 상세정보 </a></div>
 			<div><a href="#qes-review"> 구매평 </a></div>
 		</div>
 		
 		<img src="<%=request.getContextPath()%>/img/<%=product.getImg2()%>" class="img2" id="prd-menu-tab">
 		
 		<!-- 리뷰영역 -->
 		<div id="qes-review">
 			<div class="review-text" style="font-family: NanumBarunGothicLight;">상품을 구매한 분들이 작성한 리뷰입니다.</div>
 			
 			<div>
 			<%if(userLogin==null) { %>
			<button type="button" onclick="location.href='index.jsp?workgroup=user&work=user_login';" class="btn black" id="reviewBtn">구매평 작성</button> <% } else { %> 
 			<button type="button" onclick="location.href='index.jsp?workgroup=review&work=review_write';" class="btn black" id="reviewBtn">구매평 작성</button> 
 			<%} %>
 			</div>
 			
 			<div class="qna-table" style="font-family: NanumBarunGothicLight;">
 				<ul class="header">
 					<li>제목</li>
 					<li>작성자</li>
 					<li>등록일</li>
 				</ul>
 				<%for(ReviewDTO review:reviewList) { %>
 				<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)" class="prd-review-box">
 				<ul class="body">
	 					<li><%=review.getrTitle()%></li>
	 					<li><%=review.getrUid() %></li>
	 					<li><%=review.getrDate().substring(0,11)%></li>
 				</ul>
 				</a><div style="DISPLAY: none" class="prd-review-text">
					<%=review.getrContent() %> 
				</div>
 				<%} %>
 			</div>
 		</div>
 		
 	</div>

 <script type="text/javascript">
 var qnty=1;
 var price=$("#priceResult").val();
 $("#totalPrice").val(qnty*price);
 

 $("#result").val(qnty);
 
 

 $("#add").click(function() {
 	qnty++;
 	$("#result").val(qnty);
 	$("#totalPrice").val(qnty*price);
 });

 $("#sub").click(function() {
 	qnty--;
 	$("#result").val(qnty);
 	$("#totalPrice").val(qnty*price);

 });

 //여기는 초기값




 $("#payBtn").click(function() {
 	$("#productForm").attr("action","/product/product_result1.jsp");
 	$("#productForm").submit();
 });
 



  </script>	
 	








