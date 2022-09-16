<%@page import="coocan.com.dao.ProductDAO"%>
<%@page import="coocan.com.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pname=request.getParameter("pname");
	List<ProductDTO> productList=ProductDAO.getDAO().selectProductSearch(pname);
%>

<style type="text/css">
.search-box-main {
	width: 1300;
    padding-top: 30px;
    margin-left: 660px;
    margin-bottom: 10px;
    
}

.search-box {
	display: flex;
	width: 600px;
	height: 50px;
}

.search-box {
	border: 1px solid #efefef;
}

.search-box button {
	border: 1px solid #efefef;
	cursor: pointer;
}

.search-box-text {
	width: 600px;
	border: 1px solid #efefef;
}
</style>

<!-- 메인 메뉴 검색창  -->
	<form action="index.jsp?workgroup=product&work=product_searchDetail" method="post" id="searchform">
		<div class="search-box-main">
			<div class="search-box">
				<input type="text" name="pname" placeholder="검색" class="search-box-text">
				<button type="submit">search</button>
			</div>
		</div>
	</form>







