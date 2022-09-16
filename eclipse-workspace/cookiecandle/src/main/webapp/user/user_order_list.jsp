<%@page import="java.util.List"%>
<%@page import="coocan.com.dao.OrderDAO"%>
<%@page import="coocan.com.dto.OrderDTO"%>
<%@page import="coocan.com.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/user/logincheck.jspf"%>
<%
	//0:입금전(default) 3:배송준비 4:배송중 5:배송완료

	
	
	List<OrderDTO> orderList=OrderDAO.getDAO().selectOrderList(userLogin.getUid());
	
	
	
%>
<style type="text/css">

table {
	margin: 0 auto;
	border: 1px solid #d7d5d5;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #d7d5d5;
	padding: 3px;
	text-align: center;
	font-size: 12px;
}

th {
	background-color: #fcd158;
	color: black; 
}

.order_no { width: 80px; }
.order_id { width: 80px; }
.order_address { width: 300px; }
.order_pay { width: 80px; }
.order_date { width: 150px; }
.order_status { width: 80px; }
</style>



<table>
	<tr>
		<th>주문번호</th>
		<th>주문자 아이디</th>
		<th>주소</th>
		<th>결제수단</th>
		<th>주문일자</th>
		<th>상태</th>
	</tr>
	<% if(orderList.isEmpty()) { //주문 목록이 비어있을때 %>
	<tr>
	<td colspan="6">주문한 상품이 없습니다</td>
	</tr>
<% } %>
	
	
	<% for(OrderDTO order:orderList) { //주문수만큼 정보 for문으로 반복 %>
	<tr>
		<td class="order_no"><%=order.getOno() %></td>
		<td class="order_id"><%=order.getUid() %></td>
		<td class="order_address">[<%=order.getZipcode() %>]<%=order.getAdd1() %> <%=order.getAdd2() %></td>
		<td class="order_pay"><%=order.getPayment() %></td>
		<td class="order_date"><%=order.getDate() %></td>
		<!-- 단계에 따른 상태변화 -->
		<td class="order_status"><% if(order.getStatus()==0){ %>입금전
		<% } else if(order.getStatus()==3) { %>배송준비
		<% } else if(order.getStatus()==4) { %>배송중
		<% } else if(order.getStatus()==5) {%>배송완료</td>
		

	</tr>
		<% } %>
	<% } %>
</table>