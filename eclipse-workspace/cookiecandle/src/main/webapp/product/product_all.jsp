<%@page import="coocan.com.dto.ProductDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="coocan.com.dao.*"%>
<%@page import="coocan.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 카테고리를 전달받아 PRODUCT 테이블에 저장된 해당 카테고리의 제품목록을 검색하여 
클라이언트에게 전달하는 JSP 문서 --%>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<%

	//PRODUCT 테이블에 저장된 모든 제품정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<ProductDTO> productList=ProductDAO.getDAO().selectProductList("ALL");
%>

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