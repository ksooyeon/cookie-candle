<%@page import="java.text.DecimalFormat"%>
<%@page import="coocan.com.dao.ProductDAO"%>
<%@page import="coocan.com.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>

<div class="container px-5 my-5">
	<div class="d-sm-flex align-items-center justify-content-between mb-3">
		<h1 class="h2 mb-0 text-gray-900 font-weight-bold">상품 관리</h1>
	</div><br>
	
	<div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">검색 정보</h6>
        </div>
        <div class="card-body">
        	 <form action="admin_index.jsp?workgroup=admin&work=product_mng" method="get" enctype="multipart/form-data" id="pdsearchForm" data-sb-form-api-token="API_TOKEN">
			  <div class="form-group row">
			    <label for="inputEmail3" class="col-sm-2 col-form-label">상품명</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="pname" id="product_name">
			    </div>
			  </div>
			  
			  <div class="form-group row">
			  	<label class="col-sm-2 col-form-label">카테고리</label>
			    <div class="col-sm-10">
				  <div class="form-check form-check-inline">
					  <input class="form-check-input" type="checkbox" id="category_allcheck" value="all" checked="checked">
					  <label class="form-check-label" for="category_allcheck">전체</label>
				  </div>
				  <div class="form-check form-check-inline">
					  <input class="form-check-input categoryCheck" type="checkbox" name="pcategory" id="inlineCheckbox2" value="Candle" checked="checked">
					  <label class="form-check-label" for="inlineCheckbox2">Candle</label>
			   	  </div>
				  <div class="form-check form-check-inline">
					  <input class="form-check-input categoryCheck" type="checkbox" name="pcategory" id="inlineCheckbox3" value="Candle Holder" checked="checked">
					  <label class="form-check-label" for="inlineCheckbox3">Candle Holder</label>
				  </div>
				  <div class="form-check form-check-inline">
					  <input class="form-check-input categoryCheck" type="checkbox" name="pcategory" id="inlineCheckbox4" value="Candle Care" checked="checked">
					  <label class="form-check-label" for="inlineCheckbox4">Candle Care</label>
				  </div>
				</div>
			  </div>
			  
			  <div class="form-group row">
			  	<label class="col-sm-2 col-form-label">상품 등록일</label>
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
			  	
			  	//document.getElementById('startdate').value = new Date().toISOString().substring(0,10);
			  	//document.getElementById('enddate').value = new Date().toISOString().substring(0,10);
			  </script>
		
			  <br>
			  <div class="form-group row">
			  	 <input type="hidden" id="workgroup" name="workgroup" value="admin">
			  	 <input type="hidden" id="work" name="work" value="product_mng">
			    <div class="col text-center">
			    <% 
				    String pname = request.getParameter("pname");
			    	if(pname == null) pname = "";
			    	String[] pcategory = new String[3];
			    	if(request.getParameterValues("pcategory") == null) {
			    		pcategory[0] = "candle";
						pcategory[1] = "candle holder";
						pcategory[2] = "candle care";
			    	}
			    	else {
						pcategory = request.getParameterValues("pcategory");
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
	<form id="productForm" class="productForm">
	    <div class="card-header py-3" style="display: inline-flex; width: -webkit-fill-available; justify-content: space-between;">
	        <h6 class="font-weight-bold text-primary" style="font-size: 1rem; margin-top: 0.5rem;">상품 목록</h6>
	        <div style="display: contents;">
		     	<div class="col-sm-12 col-md-7" style="text-align: end;">
		     		<div>
		     			<button type="button" class="btn btn-danger btn-sm headerBtn" id="p_removeCheck" data-toggle="modal" data-target="#remove_modal">삭제</button>
		     			<!-- Modal -->
						<div class="modal fade" id="remove_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
						  <div class="modal-dialog modal-dialog-centered" role="document">
						    <div class="modal-content">
						      
						      <div class="modal-body" style="height: 100px;">
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						        <h6 id="p_check" style="text-align: center; color: black; margin-top: 2em;">선택하신 상품(들)을 삭제하시겠습니까?</h6>
						        	
						      </div>
						      <div class="modal-footer" style="justify-content: center;">
						      	<button type="button" class="btn btn-primary" id="p_remove">삭제</button>
						        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						      </div>
						    </div>
						  </div>
						</div>
						
		     			<button type="button" class="btn btn-info btn-sm headerBtn" id="p_changeCategory" data-toggle="modal" data-target="#cc_modal">카테고리 변경</button>
		     			<!-- Modal -->
						<div class="modal fade" id="cc_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
						  <div class="modal-dialog modal-dialog-centered" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title">카테고리 변경</h5>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body" style="height: 200px;">
						      	<select name="after_category" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" style="margin-top: 2rem;margin-right: 10rem;">
								  <option>카테고리 선택</option>
								  <option value="Candle">Candle</option>
								  <option value="Candle Holder">Candle Holder</option>
								  <option value="Candle Care">Candle Care</option>
								</select>
						        <h6 id="p_check" style="text-align: center; color: black; margin-top: 2em;">해당 카테고리로 변경하시겠습니까?</h6>
						      </div>
						      <div class="modal-footer" style="justify-content: center;">
						      	<button type="button" class="btn btn-primary" id="pc_change">변경</button>
						        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						      </div>
						    </div>
						  </div>
						</div>
						
		     		</div>
		     	</div>
		     </div>
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
					                    	<input style="zoom:1.2;" type="checkbox" id="allCheck">
					                    </th>
					                    <th>상품번호</th>
				                        <th>상품명</th>
				                        <th>판매가</th>
				                        <th>카테고리</th>
				                        <th>등록일</th>
				                    </tr>
				                </thead>
				                <tbody>
				                	<%
					                	List<ProductDTO> productList = null;
				                		String p_name = request.getParameter("pname");
				                		if(p_name == null) p_name = "";
				                		String[] p_category = request.getParameterValues("pcategory");
				                		String s_date = request.getParameter("startdate");
				                		String e_date = request.getParameter("enddate");
				                		
					                	if(request.getParameterValues("pcategory") == null)
					                		productList = ProductDAO.getDAO().selectAllProductList();
					                	else {
					                		productList = ProductDAO.getDAO().selectProductList(p_name, p_category, s_date, e_date);
					                	}
				                		if(productList.isEmpty()) {
				                	%>
				                	<tr>
				                		<td colspan="5">등록된 상품이 없습니다.</td>
				                	</tr>
				                	<%	} else { 
				                			for(ProductDTO product : productList) {
				                	%>
							                    <tr>
							                        <td><input style="zoom:1.2;" type="checkbox" name="checkPno" value="<%=product.getPno()%>" class="pcheck"></td>
							                        <td><%=product.getPno() %></td>
							                        <td><%=product.getPname() %></td>
							                        <td><%=DecimalFormat.getCurrencyInstance().format(product.getPrice()) %></td>
							                        <td><%=product.getKinds() %></td>
							                        <td><%=product.getDate() %></td>
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
			$(".pcheck").prop("checked",true);
		} else {
			$(".pcheck").prop("checked",false);
		}
	});
	
	$("#category_allcheck").change(function() {
		if($(this).is(":checked")) {
			$(".categoryCheck").prop("checked",true);
		} else {
			$(".categoryCheck").prop("checked",false);
		}
	});
	
	 $("#pdsearchForm").submit(function() {
		if($(".form-check-input").is(":checked") == false) {
			$(".form-check-input").prop("checked",true);
		}
	});
	 
	 $(".headerBtn").click(function() {
		 if($(".pcheck").filter(":checked").length==0) {
			alert("선택된 상품이 없습니다.");
			location.reload();
			return;
		}
			 
	 });
	 
	 $("#p_remove").click(function() {
		$("#productForm").attr("action","admin_index.jsp?workgroup=admin&work=product_remove_action");
		$("#productForm").attr("method","post");
		$("#productForm").submit();
	});
	 
	 $("#pc_change").click(function() {
		$("#productForm").attr("action","admin_index.jsp?workgroup=admin&work=product_category_modify_action");
		$("#productForm").attr("method","post");
		$("#productForm").submit();
	});
	 
	 //document.getElementById('enddate').value = new Date().toISOString().substring(0, 10);;
	 
</script>
