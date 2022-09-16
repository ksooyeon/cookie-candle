<%@page import="coocan.com.dao.CartDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="coocan.com.dto.CartDTO"%>
<%@page import="coocan.com.dao.UserDAO"%>
<%@page import="coocan.com.dao.ProductDAO"%>
<%@page import="coocan.com.dto.UserDTO"%>
<%@page import="coocan.com.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/user/logincheck.jspf"%>

<%
	//PRODUCT 테이블에 저장된 모든 제품정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	String uid=userLogin.getUid();
	//uid = session.getattribute("user.getId")
	List<CartDTO> cartList = CartDAO.getDAO().selectUserCartList(uid);
	List<ProductDTO> productList = new ArrayList<ProductDTO>();
	UserDTO user=UserDAO.getDAO().selectUser(uid);
	
	List<Integer> quantityList = new ArrayList<>();
	int sumPrice = 0;
	for (CartDTO cart : cartList) {
		   ProductDTO product = ProductDAO.getDAO().selectProduct(cart.getPid());
		   productList.add(product);
		   
		   quantityList.add( cart.getQuantity());
		   sumPrice += product.getPrice()* cart.getQuantity();
		   
		  
		}
	
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
  </head>
  <body style="background-color:#F3F3F3">
  
  
 
  
  
  
  
  <div class="container">
  

  <h2 class="text-center m-5" >결제하기</h2>

 
  
  <div class="position-relative   m-4">
  <div class="progress" style="height: 1px;">
    <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" ></div>
  </div>
  <button type="button" class="position-absolute top-0 start-0 translate-middle btn btn-sm btn-primary rounded-pill" style="width: 2rem; height:2rem;">1</button>
  
  <button type="button" class="position-absolute top-0 start-100 translate-middle btn btn-sm btn-primary rounded-pill" style="width: 2rem; height:2rem;">2</button>
</div>
 
 
 
 
 <!-- content -->
 
  <form action="index.jsp?workgroup=order&work=order_add_action" name="orderForm" method="post" id="join">
 
 <div class="row m-3 justify-content-center">
 
 	<div class="col-6 bg-white h-100">
        <p></p>
        
        <p class="fs-5 fw-bold">주문 상품 정보</p>
 <% for(int i = 0; i < productList.size(); i++) {
                	ProductDTO product = productList.get(i);
                	Integer quantity = quantityList.get(i);
                	 %>
<table class="table table-borderless table-sm">

  <tbody>
    <tr>
      <td scope="row" > <div class="p-3 mb-2 bg-warning text-light text-center" >  <%=product.getPname() %>  </div> </td>
      <td> <div class="p-3 mb-2 bg-warning text-light text-center" >  <%=quantity %>개  </div>  </td>
      <td></td>
      <td> <div class="p-3 mb-2 bg-warning text-light text-center" >  <%=(productList.get(i).getPrice()*quantityList.get(i))%>원  </div> </td>
    </tr>

</tbody>
</table>
<%} %>
     </div>&nbsp;&nbsp;&nbsp;
 	
    
     <div class="col-4 bg-white">
        
        <p class="fs-5 fw-bold"></p>
        
        <p class="fs-6 fw-bold">사랑합니다</p>
        <p class="fs-6 fw-bold">총 주문 금액은 <%=sumPrice %>원 입니다.</p>
       
       <p class="fs-6  fw-bold">감사합니다!!</p>
     </div>
 	
 </div>

 
 
 <div class="row m-3 justify-content-center">
 
    <div class="col-6 bg-white">
    
   
        <p></p>
        <p class="fs-5 fw-bold">주문자 정보</p>
        <div class="row">
            <div class="col">
              <input type="text" class="form-control" placeholder="이름"   aria-label="name" id="name" name="name" readonly="readonly" value="<%=user.getName() %>"  >
            </div>
            <div class="col">
              <input type="text" class="form-control" placeholder="연락처" aria-label="phone" id="phone" name="phone"  readonly="readonly"  value="<%=user.getPhone() %>" >
            </div>
          </div>
          <p></p>
          <div class="row">
            <div class="col">
              <input type="text" class="form-control" placeholder="이메일"  aria-label="email" id="email" name="email" readonly="readonly"  value="<%=user.getEmail() %>" >
            
            </div>
    </div>
    
    <p></p>
   
   
     
</div>

&nbsp;&nbsp;&nbsp;

<div class=" col-4 bg-white h-100" >
    <p></p>
    <p class="fs-5 fw-bold">결제 수단</p>

     <select class="form-select" aria-label="Default select example" name="payment" id="payment">
  <option selected>결제선택</option>
  <option value="신용카드">신용카드</option>
  <option value="가상계좌">가상계좌</option>
  <option value="카카오페이">카카오페이</option>
  <option value="PAYCO">PAYCO</option>
  <option value="무통장입금">무통장입금</option>
  </select>
 
 <br>
 
</div>





 </div>
 
 



 
<div class="row m-3 justify-content-center">
 
    <div class="col-6 bg-white">
<p></p>
<p class="fs-5 fw-bold">배송 정보</p>



  <p></p>
  <div class="row w-50">
    <div class="col">
      <input type="text" class="form-control" placeholder="우편번호"  readonly="readonly" aria-label="zipcode" id="zipcode" name="zipcode">
    </div>
    <div class="col">
    <button type="button" class="btn btn-warning" id=postSearch>주소찾기</button>
    <p></p>
</div>
</div>
    <div class="row">
        <div class="col">
          <input type="text" class="form-control" placeholder="기본주소" readonly="readonly" aria-label="add1" id=add1 name="add1">
        
        </div>
</div>
<p></p>

<div class="row">
    <div class="col">
      <input type="text" class="form-control" placeholder="상세주소" aria-label="add2" id=add2 name="add2">
    
    </div>
</div>
<p></p>



    </div>&nbsp;&nbsp;&nbsp;


    <div class="col-4 bg-white h-100">
     
  

    
   

    <p></p>
    <div class="d-grid">
        <button class="btn btn-warning" type="submit">결제하기</button>
        
      </div>
    <p></p>
</div>
 

</div>


 </form>
 </div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$("#postSearch").click(function() {	
    new daum.Postcode({
        oncomplete: function(data) {
        	join.zipcode.value=data.zonecode;;
        	join.add1.value=data.roadAddress;
        }
    }).open();
});




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


