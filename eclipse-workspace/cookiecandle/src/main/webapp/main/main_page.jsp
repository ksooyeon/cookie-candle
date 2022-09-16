<%@page import="java.text.DecimalFormat"%>
<%@page import="coocan.com.dao.ProductDAO"%>
<%@page import="coocan.com.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
   List<ProductDTO> productList=ProductDAO.getDAO().selectNineProductList();
	//System.out.println("productList = "+productList.size());
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
  <!--캐러셀 밑에 버튼 영역-------------------------------------------------------------------->
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <!--캐러셀 이미지 영역----------------------------------------------------------------------->
  <div class="carousel-inner" id="mainImg">
    <div class="carousel-item active" data-bs-interval="10000">
      <a href="index.jsp?workgroup=product&work=product_detail&pno=24"><img src="img/candlemain1.PNG" class="d-block w-100"></a>
      <div class="carousel-caption d-none d-md-block">
      </div>
    </div>
    <div class="carousel-item" data-bs-interval="2000">
      <a href="index.jsp?workgroup=product&work=product_detail&pno=22"><img src="img/candlemain2.PNG" class="d-block w-100"></a>
      <div class="carousel-caption d-none d-md-block">
      </div>
    </div>
     <div class="carousel-item">
      <a href="index.jsp?workgroup=product&work=product_detail&pno=25"><img src="img/candlemain3.PNG" class="d-block w-100"></a>
      <div class="carousel-caption d-none d-md-block">
      </div>
    </div>
  </div>
  <!--캐러셀 양쪽 화살표 영역---------------------------------------------------------------->
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>


<div>
	<div class="info-main">
		<img src="icon/info-main.png">
	</div>
</div>

<div class="best-prd-title">WEEKLY BEST ITEMS</div>

<!-- candle img START -->
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
	
	<!----------------------------------------------------------------------
	 <div class="candle-item">
		<a href="#"><img class="candle-img" src="img/pimg1-2.jpg"></a>
		<div class="candle-name">
			<a href="#">갈색병 캔들</a>
			<p>12,500원</p>
		</div>
	</div>
	
	<div class="candle-item">
		<a href="#"><img class="candle-img" src="img/pimg1-3.jpg"></a>
		<div class="candle-name">
			<a href="#">갈색병 캔들</a>
			<p>12,500원</p>
		</div>
	</div>
	
	<div class="candle-item">
		<a href="#"><img class="candle-img" src="img/pimg1-4.jpg"></a>
		<div class="candle-name">
			<a href="#">갈색병 캔들</a>
			<p>12,500원</p>
		</div>
	</div>
	 -->
	 <% } %>
	<div style="clear: both;"></div>
	
		
</div>	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
