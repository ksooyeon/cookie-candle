<%@page import="coocan.com.dao.BoardDAO"%>
<%@page import="coocan.com.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>

<div class="container px-5 my-5">
	<div class="d-sm-flex align-items-center justify-content-between mb-3">
		<h1 class="h2 mb-0 text-gray-900 font-weight-bold">게시물 관리</h1>
	</div><br>
	
	<div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">검색 정보</h6>
        </div>
        <div class="card-body">
        	<form>
			  
			  <div class="form-group row">
			  	<label class="col-sm-2 col-form-label">게시판</label>
			  	<div class="col-sm-10">
	            	<select class="form-select" name="board_category" id="board_category" aria-label="게시판 분류">
		                <option value="notice" selected>공지사항</option>
		                <option value="review">리뷰</option>
		                <option value="question">문의</option>
	            	</select>
				 </div>
			  </div>
			  
			  <div class="form-group row">
			  	<label class="col-sm-2 col-form-label">게시글 찾기</label>
			  	<div class="col-sm-10">
	            	<select class="form-select" name="board_writer" id="category" aria-label="작성자 분류">
	            		<option value="">선택</option>
	            		<option value="title">제목</option>
	            		<option value="content">내용</option>
		                <option value="writer_id">아이디</option>
	            	</select>
	            	<input type="text" name="search_word" id="search" style="margin-left: 1em; width: 40rem; display:none;">
		            
				 </div>
			  </div>
			  
			  <div class="form-group row" id="only_question" style="display:none;">
			  	<label class="col-sm-2 col-form-label">답변 상태</label>
			    <div class="col-sm-10">
				  <div class="form-check form-check-inline">
					  <input class="form-check-input" type="checkbox" id="bcheck1">
					  <label class="form-check-label" for="bcheck1">전체</label>
				  </div>
				  <div class="form-check form-check-inline">
					  <input class="form-check-input rcheck" type="checkbox" name="reply" id="inlineCheckbox2" value="0">
					  <label class="form-check-label" for="inlineCheckbox2">답변 전</label>
			   	  </div>
				  <div class="form-check form-check-inline">
					  <input class="form-check-input rcheck" type="checkbox" name="reply" id="inlineCheckbox3" value="1">
					  <label class="form-check-label" for="inlineCheckbox3">답변 완료</label>
				  </div>
				</div>
			  </div>
			  
			  <div class="form-group row">
			  	<label class="col-sm-2 col-form-label">기간</label>
			  	<div class="col-sm-10">
				  	<input type="date" class="datePicker" id="startdate" readonly>
				  	~
				  	<input type="date" class="datePicker" id="enddate" readonly>
				 </div>
			  </div>
			  
			  <script type="text/javascript">
			  	$('.datePicker').datepicker({
			  		format : "yyyy-mm-dd",
			  		language : "kr",
			  		todayHighlight : true,
			  		autoclose: true
			  	});
			  </script>
		
			  <br>
			  <div class="form-group row">
			  	<input type="hidden" id="workgroup" name="workgroup" value="admin">
			  	<input type="hidden" id="work" name="work" value="board_mng">
			    <div class="col text-center">
			      <%
			      	String board_category = request.getParameter("board_category");
			      	if(board_category == null) board_category = "notice";
			      	
			      	String board_writer = request.getParameter("board_writer");
			      	if(board_writer == null) board_writer = "";
			      	
			      	String search_word = request.getParameter("search_word");
			      	if(search_word == null) search_word = "";
			      	
			      	String[] reply_status = new String[2];
			      	if(request.getParameterValues("reply") == null) {
			      		reply_status[0] = "0";
			      		reply_status[1] = "1";
			      	}
			      	else {
			      		reply_status = request.getParameterValues("reply");
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
	<form id="boardForm" class="boardForm">
	    <div class="card-header py-3" style="display: inline-flex; width: -webkit-fill-available; justify-content: space-between;">
	      <h6 class="font-weight-bold text-primary" style="font-size: 1rem; margin-top: 0.5rem;">게시글 목록</h6>
	      <div style="display: contents;">
	     	<div class="col-sm-12 col-md-7" style="text-align: end;">
	     		<div>
	     			<button type="button" class="btn btn-danger btn-sm headerBtn" id="b_removeCheck" data-toggle="modal" data-target="#remove_modal">삭제</button>
	     			<!-- Modal -->
					<div class="modal fade" id="remove_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					      
					      <div class="modal-body" style="height: 100px;">
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					        <h6 id="p_check" style="text-align: center; color: black; margin-top: 2em;">선택하신 게시물을 삭제하시겠습니까?</h6>
					      </div>
					      <div class="modal-footer" style="justify-content: center;">
					      	<button type="button" class="btn btn-primary" id="b_remove">삭제</button>
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					      </div>
					      
					    </div>
					  </div>
	     			</div>
	     			<!-- Modal -->
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
				                        <th>분류</th>
				                        <th>제목</th>
				                        <th>작성자</th>
				                        <th>작성일</th>
				                        <th>답변상태</th>
				                    </tr>
				                </thead>
				                <tbody>
				                	<%
				                		List<BoardDTO> boardList = null;
				                	
					                	String b_category = request.getParameter("board_category");
								      	if(b_category == null) b_category = "notice";
								      	
								      	String b_writer = request.getParameter("board_writer");
								      	if(b_writer == null) b_writer = "";
								      	
								      	String s_word = request.getParameter("search_word");
								      	if(s_word == null) s_word = "";
								      	
								      	String[] r_status = new String[2];
								      	if(request.getParameterValues("reply") == null) {
								      		r_status[0] = "0";
								      		r_status[1] = "1";
								      	}
								      	else {
								      		r_status = request.getParameterValues("reply");
								      	}
								      	
								      	String s_date = request.getParameter("startdate");
										if(s_date == null) s_date = "";
										String e_date = request.getParameter("enddate");
										if(e_date == null) e_date = "";
										
										boardList = BoardDAO.getDAO().selectBoardList(b_category, b_writer, s_word, r_status, s_date, e_date);
										
										if(boardList.isEmpty()) { %>
					                	<tr>
					                		<td colspan="6">검색 결과가 없습니다.</td>
					                	</tr>
					                	<%	} else { 
					                			for(BoardDTO board : boardList) { %>
								                    <tr>
								                        <td><input style="zoom:1.2;" type="checkbox" name="checkBno" value="<%=board.getId()%>" class="bcheck"></td>
								                        <% if(board.getCategory().equals("notice")) { %> 
								                        	<td>공지사항</td>
								                        <% } else if(board.getCategory().equals("review")) { %> 
								                        	<td>리뷰</td>
								                        <% } else { %> 
								                        	<td>문의사항</td>
								                        <% } %>
								                        <td><%=board.getTitle() %></td>
								                        <td><%=board.getId() %></td>
								                        <td><%=board.getDate()%></td>
								                        <% if(board.getStatus().equals("0")) { %> 
								                        	<td>답변전</td>
								                        <% } else if(board.getStatus().equals("1")) { %> 
								                        	<td>답변완료</td>
								                        <% } else { %> 
								                        	<td><%=board.getStatus()%></td>
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
				     <!-- Paging -->
				     
	            	</div>
	        	</div>
	    	</div>
	 </form>
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
	
	$("#bcheck1").change(function() {
		if($(this).is(":checked")) {
			$(".rcheck").prop("checked",true);
		} else {
			$(".rcheck").prop("checked",false);
		}
	});
	
	$("#allCheck").change(function() {
		if($(this).is(":checked")) {
			$(".bcheck").prop("checked",true);
		} else {
			$(".bcheck").prop("checked",false);
		}
	});
	
	$("#board_category").change(function() {
		var state = $("#board_category option:selected").val();
		if(state == "question") {
			$("#only_question").show();
			$("#bcheck1").prop("checked",true);
			$("#inlineCheckbox2").prop("checked",true);
			$("#inlineCheckbox3").prop("checked",true);
		} else {
			$("#only_question").hide();
		}
	});
	
	$("#category").change(function() {
		var state = $("#category option:selected").val();
		if(state == null) {
			$("#search").hide();
		} else {
			$("#search").show();
		}
	});
	
	$(".headerBtn").click(function() {
		 if($(".bcheck").filter(":checked").length==0) {
			alert("선택된 게시글이 없습니다.");
			location.reload();
			return;
		}
			 
	 });
	
	$("#b_remove").click(function() {
		$("#boardForm").attr("action","admin_index.jsp?workgroup=admin&work=board_remove_action");
		$("#boardForm").attr("method","post");
		$("#boardForm").submit();
	});
</script>
