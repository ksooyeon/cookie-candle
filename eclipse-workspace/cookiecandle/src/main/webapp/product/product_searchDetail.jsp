<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="coocan.com.dao.ProductDAO"%>
<%@page import="coocan.com.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getParameter("pname")==null) {
		out.println("<script type='text/javascript'>");
		out.println("<!DOCTYPE html>"); //출력스트림으로 문자열(HTML 태그)을 전달하여 문서파일 작성
		out.println("<html>");
		out.println("<head>");
		out.println("<meta charset='UTF-8'>");
		out.println("location.href='index.jsp?workgroup=product&work=product_searchDetail';");
		out.println("</head>");
		out.println("<body>");
		out.println("<div>검색 결과가 없습니다.</div>");
		out.println("</body>");
		out.println("</html>");
		out.println("</script>");
		return;			
	}

//전달값을 반환받아 저장
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

	<form action="index.jsp?workgroup=product&work=product_searchDetail" method="post" id="searchform">
		<div class="search-box-main">
			<div class="search-box">
				<input type="text" name="pname" placeholder="검색" class="search-box-text">
				<button type="submit">search</button>
			</div>
		</div>
	</form>

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