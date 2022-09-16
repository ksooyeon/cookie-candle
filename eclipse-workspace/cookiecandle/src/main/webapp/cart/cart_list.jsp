
<%@page import="java.util.ArrayList"%>
<%@page import="coocan.com.dto.CartDTO"%>
<%@page import="coocan.com.dto.UserDTO"%>
<%@page import="coocan.com.dao.CartDAO"%>
<%@page import="coocan.com.dao.ProductDAO"%>
<%@page import="coocan.com.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/user/logincheck.jspf"%>

<%
	//PRODUCT 테이블에 저장된 모든 제품정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	String uid = userLogin.getUid();
	
	//uid = session.getattribute("user.getId")
	List<CartDTO> cartList = CartDAO.getDAO().selectUserCartList(uid);
	List<ProductDTO> productList = new ArrayList<ProductDTO>();
	
	List<Integer> quantityList = new ArrayList<>();
	
	
	for (CartDTO cart : cartList) {
		   ProductDTO product = ProductDAO.getDAO().selectProduct(cart.getPid());
		   productList.add(product);
		   
		   quantityList.add(cart.getQuantity());
	}
	
	int allPrice = 0;
%> 


<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <title>Hello, world!</title>
     <style type="text/css">
    body {
  margin: 0;
}

* {
  box-sizing: border-box;
}

p,
span {
  margin: 0;
}

a {
  color: black;
}

#pimg {
  display: block;
  width: auto;
  height: 80px;
  margin: auto;
}

.cart {
  width: 80%;
  margin: auto;
  padding: 30px;
}

.cart ul {
  background-color: whitesmoke;
  padding: 30px;
  margin-bottom: 50px;
  border: whitesmoke solid 1px;
  border-radius: 5px;
  font-size: 13px;
  font-weight: 300;
}

.cart ul :first-child {
  color: limegreen;
}

table {
  border-top: solid 1.5px black;
  border-collapse: collapse;
  width: 100%;
  font-size: 14px;
}

thead {
  text-align: center;
  font-weight: bold;
}

tbody {
  font-size: 12px;
}

td {
  padding: 15px 0px;
  border-bottom: 1px solid lightgrey;
}

.cart__list__detail :nth-child(3) {
  vertical-align: top;
}

.cart__list__detail :nth-child(3) a {
  font-size: 12px;
}

.cart__list__detail :nth-child(3) p {
  margin-top: 6px;
  font-weight: bold;
}



.cart__list__option {
  vertical-align: top;
  padding: 20px;
}


.cart__list__option p::after {
  content: "";
  width: 90%;
  height: 1px;
  background-color: lightgrey;
  left: 0px;
  top: 25px;
  position: absolute;
}



.cart__list__detail :nth-child(4),
.cart__list__detail :nth-child(5),
.cart__list__detail :nth-child(6) {
  border-left: 2px solid whitesmoke;
}

.cart__list__detail :nth-child(5),
.cart__list__detail :nth-child(6) {
  text-align: center;
}

.price {
  font-weight: bold;
}

.cart__mainbtns {
  width: 420px;
  height: 200px;
  padding-top: 40px;
  display: block;
  margin: auto;
}

.cart__bigorderbtn {
  width: 200px;
  height: 50px;
  font-size: 16px;
  margin: auto;
  border-radius: 5px;
}

.cart__bigorderbtn.left {
  background-color: white;
  border: 1px lightgray solid;
}

.cart__bigorderbtn.right {
  background-color: yellow;
  color: black;
  border: none;
}
    
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
   <section class="cart">
	<div class="position-relative m-4">
	  <div class="progress" style="height: 1px;">
	    <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
	  </div>
	  <button type="button" class="position-absolute top-0 start-0 translate-middle btn btn-sm btn-primary rounded-pill" style="width: 2rem; height:2rem;">1</button>
	  
	  <button type="button" class="position-absolute top-0 start-100 translate-middle btn btn-sm btn-secondary rounded-pill" style="width: 2rem; height:2rem;">2</button>
	</div>
	
<form action="index.jsp?workgroup=order&work=order_list" method="post" id="cartForm">
		
        <table id="cart__list" class="cart__list">
           
                <thead>
                    <tr>
                        <td></td>
                        <td colspan="2">상품정보</td>
                        <td>수량</td>
                        <td>상품금액</td>
                        <td>배송비</td>
                    </tr>
                </thead>
                <% for(int i = 0; i < productList.size(); i++) {
                	ProductDTO product = productList.get(i);
                	Integer quantity = quantityList.get(i);
                	allPrice += (productList.get(i).getPrice()*quantityList.get(i));
                %>
                <tbody>
                    <tr class="cart__list__detail">
                        <td>
                        </td>
                        <td><img id="pimg" src="<%=request.getContextPath()%>/img/<%=product.getImg1()%>" alt="" width="auto"></td>
                        <td>
                            <p><%=product.getPname() %></p>
                            <span class="price" ><%=product.getPrice() %>원</span>
                            
                        </td>
                        <td class="cart__list__option">
              			  <div class="p-3 mb-2 bg-warning text-dark text-center" >
                            <p class="fs-6" ><%=quantity %>개</p>
                           </div>
                        </td>
                        <td><span><%=(productList.get(i).getPrice()*quantityList.get(i))%>원</span><br>
                            <button type="submit" class="btn btn-warning btn-sm" >주문하기</button>
                        </td>
                       
                        <td>무료</td>
                    </tr>
                     <% } %>
                </tbody>
                <tfoot>
                    <tr>
                        <td class="fw-bold" colspan="3">
                            
                            
                        </td>
                        <td></td>
                        <td class="fw-bold"></td>
                        <td class="fw-bold">총 금액: <%=allPrice %>원</td>
                    </tr>
                </tfoot>
            
        </table>
        
       
        
        <div class="cart__mainbtns">
          <!--  <p style="margin-left:9rem; margin-bottom:1rem;">총액 :원</p>  -->
          <button type="button" onclick="location.href='index.jsp?workgroup=product&work=product_all'" class="cart__bigorderbtn left" >쇼핑 계속하기</button>
            <button type="submit" class="btn btn-warning btn-lg" ">주문하기</button>
            
        </div>
        </form>
        
    </section>
 

 <script type="text/javascript">

      $(document).on('change','#allCheck',function(e){
    	  let checkItem = $("input[name=checkP]");
          if($(this).prop("checked")) { 
        	  checkItem.prop("checked",true); 
          } else {
        	  checkItem.prop("checked",false);
          }
      });
      let checkItem = $("input[name=checkP]");
      $("#allCheck").prop("checked",true);
      checkItem.prop("checked",true); 
 


      

 
 </script>
 
    <!-- Optional JavaScript; choose one of the two! -->

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <!-- Option 2: Separate Popper and Bootstrap JS -->
    <!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    -->
  </body>
</html>