<%@page import="java.util.List"%>
<%@page import="coocan.com.dto.ProductDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="coocan.com.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style type="text/css">
.candlemain-img {
	margin-left: 0px;
	margin-bottom: 5px;
	text-align: center;
}
</style> 

<%
	//PRODUCT 테이블에 저장된 모든 제품정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<ProductDTO> productList=ProductDAO.getDAO().selectProductList("Candle");
%>

<div class="candlemain-img"><img src="img/candlemain4.png" width="1300" height="180" ></div>

<div id="productList">
	<% for(ProductDTO product:productList) { %>
	<div class="candle-item">
		<a href="index.jsp?workgroup=product&work=product_detail&pno=<%=product.getPno()%>">
			<img src="<%=request.getContextPath()%>/img/<%=product.getImg1()%>" class="candle-img">
		</a>
		<div class="candle-name">
			<a href="index.jsp?workgroup=product&work=product_detail&pno=<%=product.getPno()%>"><%=product.getPname() %></a>
			<p><%=DecimalFormat.getInstance().format(product.getPrice()	)%>원</p>
		</div>
	</div>
	<% } %>
	<div style="clear: both;"></div>
</div>
