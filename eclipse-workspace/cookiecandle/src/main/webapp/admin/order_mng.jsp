<%@page import="java.text.DecimalFormat"%>
<%@page import="coocan.com.dto.OrderListDTO"%>
<%@page import="coocan.com.dto.OrderDTO"%>
<%@page import="coocan.com.dao.OrderDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>

<div class="container px-5 my-5">
	<div class="d-sm-flex align-items-center justify-content-between mb-3">
		<h1 class="h2 mb-0 text-gray-900 font-weight-bold">전체 주문 목록</h1>
	</div><br>
	
	<div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">검색 정보</h6>
        </div>
        <div class="card-body">
        	<form>
			  <div class="form-group row">
			    <label for="inputEmail3" class="col-sm-2 col-form-label">주문 번호</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="order_num" id="order_number">
			    </div>
			  </div>
			  
			  <div class="form-group row">
			    <label for="inputEmail3" class="col-sm-2 col-form-label">주문자 아이디</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="user_id" id="user_id">
			    </div>
			  </div>
			  
			  <div class="form-group row">
			    <label for="inputEmail3" class="col-sm-2 col-form-label">상품명</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="p_name" id="product_name">
			    </div>
			  </div>
			  
			  <div class="form-group row">
			  	<label class="col-sm-2 col-form-label">주문 상태</label>
			    <div class="col-sm-10">
				  <div class="form-check form-check-inline">
					  <input class="form-check-input" type="checkbox" id="allCheck" value="all" checked="checked">
					  <label class="form-check-label" for="allCheck">전체</label>
				  </div>
				  <div class="form-check form-check-inline">
					  <input class="form-check-input statusCheck" type="checkbox" id="inlineCheckbox2" name="o_status" value="0" checked="checked">
					  <label class="form-check-label" for="inlineCheckbox2">입금전</label>
			   	  </div>
				  <div class="form-check form-check-inline">
					  <input class="form-check-input statusCheck" type="checkbox" id="inlineCheckbox3" name="o_status" value="3" checked="checked">
					  <label class="form-check-label" for="inlineCheckbox3">배송준비</label>
				  </div>
				  <div class="form-check form-check-inline">
					  <input class="form-check-input statusCheck" type="checkbox" id="inlineCheckbox4" name="o_status" value="4" checked="checked">
					  <label class="form-check-label" for="inlineCheckbox4">배송중</label>
				  </div>
				  <div class="form-check form-check-inline">
					  <input class="form-check-input statusCheck" type="checkbox" id="inlineCheckbox5" name="o_status" value="5" checked="checked">
					  <label class="form-check-label" for="inlineCheckbox5">배송완료</label>
				  </div>
				</div>
			  </div>
			  
			  <div class="form-group row">
			  	<label class="col-sm-2 col-form-label">주문 기간</label>
			  	<div class="col-sm-10">
				  	<input type="date" class="datePicker" name="startdate" id="startdate" readonly>
				  	~
				  	<input type="date" class="datePicker" name="enddate" id="enddate" readonly>
				 </div>
			  </div>
			  
			  <script type="text/javascript">
			  $('.datePicker').datepicker({
			  		format : "yyyy-mm-dd",
			  		language : "kr",
			  		setDate: new Date(),
			  		todayHighlight : true,
			  		autoclose: true
			  	});
			  	
			  </script>
		
			  <br>
			  <div class="form-group row">
			  	<input type="hidden" id="workgroup" name="workgroup" value="admin">
			  	 <input type="hidden" id="work" name="work" value="order_mng">
			    <div class="col text-center">
			      <% 
				    String order_name = request.getParameter("order_name");
			    	if(order_name == null) order_name = "";
			    	
			    	String p_name = request.getParameter("p_name");
			    	if(p_name == null) p_name = "";
			    	
			    	String user_id = request.getParameter("user_id");
			    	if(user_id == null) user_id = "";
			    	
			    	
			    	String[] oStatus = new String[4];
			    	if(request.getParameterValues("o_status") == null) {
			    		oStatus[0] = "0";
			    		oStatus[1] = "3";
			    		oStatus[2] = "4";
			    		oStatus[3] = "5";
			    	}
			    	else {
			    		oStatus = request.getParameterValues("oStatus");
					}
					String sdate = request.getParameter("startdate");
					if(sdate == null) sdate = "";
					String edate = request.getParameter("enddate");
					if(edate == null) edate = "";
			      %>
			      <button type="submit" class="btn btn-primary" style="margin-right: 10px;">검색</button>
			      <button type="reset" class="btn btn-secondary" style="margin-left: 10px;">초기화</button>
			    </div>
			  </div>
			</form>
      	</div>
    </div>
	
	
</div>

<div class="card shadow mb-4" style="margin: 2em;">
	<form id="orderForm" class="orderForm">
	    <div class="card-header py-3"">
	        <h6 class="font-weight-bold text-primary" style="font-size: 1rem; margin-top: 0.5rem;">주문 목록</h6>
	        
	    </div>
	    <div class="card-body">
	        <div class="table-responsive">
	        	<div id="dateTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
	        		<div class="row">
	        			<div class="col-sm-12">
				            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
				                <thead>
				                    <tr>
				                    	<th>
					                    	<input style="zoom:1.2;" type="checkbox" id="order_allCheck">
					                    </th>
				                        <th>주문번호</th>
				                        <th>주문자</th>
				                        <th>총액</th>
				                        <th>결제수단</th>
				                        <th>배송상태</th>
				                        <th>주문일</th>
				                    </tr>
				                </thead>
				                <tbody>
				                	<%
				                		List<OrderListDTO> orderList = null;
					                	String o_num = request.getParameter("order_num");
				                		if(o_num == null) o_num = "";
				                		
				                		String u_id = request.getParameter("user_id");
				                		if(u_id == null) u_id = "";
				                		
				                		String pro_name = request.getParameter("p_name");
				                		if(pro_name == null) pro_name = "";
				                		
				                		String[] o_status = request.getParameterValues("o_status");
				                		String s_date = request.getParameter("startdate");
				                		String e_date = request.getParameter("enddate");
				                		
					                	if(request.getParameterValues("o_status") == null) {
					                		orderList = OrderDAO.getDAO().selectOrderListNoCondition();
					                		System.out.println(orderList.size());
					                	}
					                	else {
					                		orderList = OrderDAO.getDAO().selectOrderList(o_num, u_id, pro_name, o_status, s_date, e_date);
					                	}
				                		if(orderList.isEmpty()) {
				                	%>
				                	<tr>
				                		<td colspan="8">등록된 주문이 없습니다.</td>
				                	</tr>
				                	<%	} else { 
				                			for(OrderListDTO order : orderList) {
				                	%>
				                                <tr>
							                        <td><input style="zoom:1.2;" type="checkbox" name="checkOno" value="<%=order.getOrderNum()%>" class="ocheck"></td>
							                        <td>
							                        	<button type="button" class="btn btn-link" data-toggle="modal" data-target="#th<%=order.getOrderNum()%>">
							                        		<%=order.getOrderNum() %>
							                        	</button>
							                        	<!-- Modal -->
														  <div class="modal fade" id="th<%=order.getOrderNum()%>" tabindex="-1" role="document" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
														  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
														    <div class="modal-content">
														      
														      <div class="modal-body">
														        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
														          <span aria-hidden="true">&times;</span>
														        </button>
														        <% 
														        	List<OrderListDTO> list = OrderDAO.getDAO().selectOrderNumberList(order.getOrderNum());
														        	for(OrderListDTO tmp : list) {
														        %>
															        <table class="table">
																	  <thead>
																	    <tr>
																	      <th scope="col">상품명</th>
																	      <th scope="col">상품금액</th>
																	      <th scope="col">결제수단</th>
																	      <th scope="col">주문상태</th>
																	      <th scope="col">주문날짜</th>
																	    </tr>
																	  </thead>
																	  <tbody>
																	    <tr>
																	      <td><%=tmp.getPnames() %></td>
																	      <td><%=tmp.getAllPrice() %></td>
																	      <td><%=tmp.getPayment() %></td>
																	      <% if(order.getStatus() == 0) { %>
												                        		<td>입금전</td>
												                        <% } else if(order.getStatus() == 3) { %>
												                        		<td>배송준비</td>
												                        <% } else if(order.getStatus() == 4) { %>
												                        		<td>배송중</td>
												                        <% } else if(order.getStatus() == 5) { %>
												                        		<td>배송완료</td>
												                        <% } %>
																	      <td><%=tmp.getDate() %></td>
																	    </tr>
																	  </tbody>
																	</table>
														        <% } %>	
														      </div>
														      <div class="modal-footer" style="justify-content: center;">
														      	<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
														      </div>
														    </div>
														  </div>
														</div>
							                        </td>
							                        <td><%=order.getuName() %></td>
							                        <td><%=DecimalFormat.getCurrencyInstance().format(order.getAllPrice()) %></td>
							                        <td><%=order.getPayment() %></td>
							                        <% 
							                        	if(order.getStatus() == 0) {
							                        %>
							                        		<td>입금전</td>
							                        <% 
							                        	} else if(order.getStatus() == 3) {
							                        %>
							                        		<td>배송준비</td>
							                        <% 
							                        	} else if(order.getStatus() == 4) {
							                        %>
							                        		<td>배송중</td>
							                        <% 
							                        	} else if(order.getStatus() == 5){
							                        %>
							                        		<td>배송완료</td>
							                        	<% } %>
							                    	<td><%=order.getDate() %></td>
							                    </tr>
							                  
							              <% } %>
							          <% } %>
				                </tbody>
				            </table>
				        </div>
				     </div>
				     
				     <!-- Paging -->
				     <div class="row">
				     	<div class="col-sm-12 col-md-7" style="">
				     		<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
				     			<ul class="pagination">
				     				<li class="paginate_button page-item previous disabled" id="dataTable_previous"><a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
				     				<li class="paginate_button page-item active"><a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
				     				<li class="paginate_button page-item next" id="dataTable_next"><a href="#" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
				     			</ul>
				     		</div>
				     	</div>
				     </div>
	            </div>
	        </div>
	    </div>
    </form>
</div>
                    
<script type='text/javascript'>
	
	$("#allCheck").change(function() {
		if($(this).is(":checked")) {
			$(".statusCheck").prop("checked",true);
		} else {
			$(".statusCheck").prop("checked",false);
		}
	});
	
	$("#order_allCheck").change(function() {
		if($(this).is(":checked")) {
			$(".ocheck").prop("checked",true);
		} else {
			$(".ocheck").prop("checked",false);
		}
	});
    
</script>
