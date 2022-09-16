<%@page import="coocan.com.dto.UserListDTO"%>
<%@page import="coocan.com.dto.OrderListDTO"%>
<%@page import="coocan.com.dao.UserDAO"%>
<%@page import="coocan.com.dto.UserDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>

<div class="container px-5 my-5">
	<div class="d-sm-flex align-items-center justify-content-between mb-3">
		<h1 class="h2 mb-0 text-gray-900 font-weight-bold">고객 관리</h1>
	</div><br>
	
	<div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">검색 정보</h6>
        </div>
        <div class="card-body">
        	<form>
			  
			  <div class="form-group row">
			  	<label class="col-sm-2 col-form-label">아이디</label>
			  	<div class="col-sm-10">
	            	<input type="text" class="form-control" name="search_id" id="search_id">
				 </div>
			  </div>
			  
			  
			  <div class="form-group row">
			  	<label class="col-sm-2 col-form-label">이름</label>
			  	<div class="col-sm-10">
	            	<input type="text" class="form-control" name="search_name" id="search_name">
				 </div>
			  </div>
			  
			  <div class="form-group row">
			  	<label class="col-sm-2 col-form-label">회원 분류</label>
			  	<div class="col-sm-10">
	            	<select class="form-select" name="user_category" id="user_category" aria-label="회원 분류">
		                <option value="all" selected>전체</option>
		                <option value="0">일반 회원</option>
		                <option value="8">휴면 회원</option>
	            	</select>
				 </div>
			  </div>
		
			  <br>
			  <div class="form-group row">
			  	<input type="hidden" id="workgroup" name="workgroup" value="admin">
			  	<input type="hidden" id="work" name="work" value="customer_mng">
			    <div class="col text-center">
			      <%
			      	String searchId = request.getParameter("search_id");
			      	if(searchId == null) searchId = "";
			      	
			      	String searchName = request.getParameter("search_name");
			      	if(searchName == null) searchName = "";
			      	
			      	String userCategory = request.getParameter("user_category");
			      	if(userCategory == null) userCategory = "";
			      	
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
    <div class="card-header py-3" style="display: inline-flex; justify-content: space-between;">
        <h6 class="font-weight-bold text-primary" style="font-size: 1rem; margin-top: 0.5rem;">고객 목록</h6>
	
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
				                    	<input style="zoom:1.2;" type="checkbox" id="user_allCheck">
				                    </th>
				                    <th>아이디</th>
			                        <th>이름</th>
			                        <th>전화번호</th>
			                        <th>이메일</th>
			                        <th>상태</th>
			                    </tr>
			                </thead>
			                <tbody>
			                	<%
			                		List<UserDTO> userList = null;
			                	
				                	String search_id = request.getParameter("search_id");
							      	if(search_id == null) search_id = "";
							      	
							      	String search_name = request.getParameter("search_name");
							      	if(search_name == null) search_name = "";
							      	
							      	String user_category = request.getParameter("user_category");
							      	if(user_category == null || user_category.equals("all")) user_category = "";
							      	
									if(search_id.equals("") && search_name.equals("") && user_category.equals(""))
										userList = UserDAO.getDAO().selectAllUserList();
									else
										userList = UserDAO.getDAO().selectUserList(search_id, search_name, user_category);
									
									
									if(userList.isEmpty()) {
			                	%>
			                	<tr>
			                		<td colspan="7">검색 결과가 없습니다.</td>
			                	</tr>
			                	<%	} else { 
			                			for(UserDTO user : userList) { %>
						                    <tr>
						                        <td><input style="zoom:1.2;" type="checkbox" name="checkUno" value="<%=user.getUid()%>" class="ucheck"></td>
						                        <td><%=user.getUid() %></td>
						                        <td><%=user.getName() %></td>
						                        <td><%=user.getPhone() %></td>
						                        <td><%=user.getEmail() %></td>
						                        <% if(user.getStatus() == 0) { %> 
						                        	<td>일반회원</td>
						                        <% } else if(user.getStatus() == 8) { %> 
						                        	<td>휴면회원</td>
						                        <% } %>
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
</div>
                    
<script type='text/javascript'>
	$(function(){        
		$('.input-group.date').datepicker({ 
			calendarWeeks: false,            
			todayHighlight: true,            
			autoclose: true,            
			format: "yyyy/mm/dd",            
			language: "kr"
			
		});    
		
	});
	
	$("#user_allCheck").change(function() {
		if($(this).is(":checked")) {
			$(".ucheck").prop("checked",true);
		} else {
			$(".ucheck").prop("checked",false);
		}
	});    
</script>
