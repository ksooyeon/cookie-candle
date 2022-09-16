<%@page import="coocan.com.dto.UserDTO"%>
<%@page import="coocan.com.dao.ProductDAO"%>
<%@page import="coocan.com.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<ProductDTO> productList = ProductDAO.getDAO().selectAllProductList();
	UserDTO userLogin=(UserDTO)session.getAttribute("userLogin");
%>
<style>
	.board_title_div {
    	/* font-size: 2.5em; */
    	font-weight: bold;
    	width: 80%;
    	margin: auto;
    	color: inherit;
    	font-family: 'Noto Serif KR', serif;
	}
	
	.board_title{
		width: 100%;
	    font-size: 25px;
	    font-weight: 700;
	    position: relative;
	    display: block;
	    margin-bottom: 10px;
	    text-align: center;
	}
	
	.board_under{
		width: 97px;
    	height: 5px;
    	background: #4B4846;
    	position: relative;
    	display: inline-block;
    	margin: 0 auto;
	}
	
	.board_view_table {
	    width: 70%;
	    margin: 5px auto;
	    border-collapse: collapse;
	    border: 1px solid;
	}
	
	.board_view_table th {
	    /* height: 40px;
	    border: 0.5px solid black;
	    text-align: center;
	    border-color: #333333; */
    	padding: 10px 0 10px 0;
    	text-align: center;
    	border-top-width: 1px; 
    	border-bottom-width: 1px;
    	border-top-style: solid;
    	border-bottom-style: solid;
	}
	
	.board_view_table td {
    	/* height: 40px;
    	border: 0.5px solid black; */
    	padding: 5px 9px 5px 9px;
    	border-top-width: 1px;
    	border-bottom-width: 1px;
    	border-top-style: solid;
    	border-bottom-style: solid;
	}
	
	.board_content{
		text-align: center;
		padding: 30px 9px 30px 9px !important;
	}
	
	.board_btn_area{
		width : 70%;
		margin: 20px 15% 0;
	}
	
	.btn {
		display: inline-block;
		font-weight: 400;
		color: #212529;
		text-align: center;
		vertical-align: middle;
		cursor: pointer;
		-webkit-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
		background-color: transparent;
		border: 1px solid transparent;
		padding: 0.375rem 0.75rem;
		font-size: 1rem;
		line-height: 1.5;
		border-radius: 0.25rem;
		transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
	}

	.btn:hover {
		color: #212529;
	  	text-decoration: none;
	}
	
	.btn:focus, .btn.focus {
		outline: 0;
	  	box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
	}

	.board_list_btn{
		width : 70%;
		margin: 20px 82% 0;
	}
	
	.form-control {
  display: block;
  width: 100%;
  height: calc(1.5em + 0.75rem + 2px);
  /* padding: 0.375rem 0.75rem; */
  font-size: 1rem;
  font-weight: 400;
  line-height: 1.5;
  color: #495057;
  background-color: #fff;
  background-clip: padding-box;
  border: 1px solid #ced4da;
  border-radius: 0.25rem;
  transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.input-group {
  position: relative;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-wrap: wrap;
  flex-wrap: wrap;
  -ms-flex-align: stretch;
  align-items: stretch;
  width: 100%;
}

.input-group-sm > .form-control:not(textarea),
.input-group-sm > .custom-select {
  height: calc(1.5em + 0.5rem + -15px);
}

.input-group-sm > .form-control,
.input-group-sm > .custom-select,
.input-group-sm > .input-group-prepend > .input-group-text,
.input-group-sm > .input-group-append > .input-group-text,
.input-group-sm > .input-group-prepend > .btn,
.input-group-sm > .input-group-append > .btn {
  padding: 0.25rem 0.5rem;
  font-size: 0.875rem;
  line-height: 1.5;
  border-radius: 0.2rem;
}

.input-group-lg > .custom-select,
.input-group-sm > .custom-select {
  padding-right: 1.75rem;
}

.btn {
		display: inline-block;
		font-weight: 400;
		color: #212529;
		text-align: center;
		vertical-align: middle;
		cursor: pointer;
		-webkit-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
		background-color: transparent;
		border: 1px solid transparent;
		padding: 0.375rem 0.75rem;
		font-size: 1rem;
		line-height: 1.5;
		border-radius: 0.25rem;
		transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
	}

	.btn:hover {
		color: #212529;
	  	text-decoration: none;
	}
	
	.btn:focus, .btn.focus {
		outline: 0;
	  	box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
	}
	
	.btn-outline-dark {
  color: #343a40;
  border-color: #343a40;
}

.btn-outline-dark:hover {
  color: #fff;
  background-color: #343a40;
  border-color: #343a40;
}

.btn-outline-dark:focus, .btn-outline-dark.focus {
  box-shadow: 0 0 0 0.2rem rgba(52, 58, 64, 0.5);
}

.btn-outline-dark.disabled, .btn-outline-dark:disabled {
  color: #343a40;
  background-color: transparent;
}

.btn-outline-dark:not(:disabled):not(.disabled):active, .btn-outline-dark:not(:disabled):not(.disabled).active,
.show > .btn-outline-dark.dropdown-toggle {
  color: #fff;
  background-color: #343a40;
  border-color: #343a40;
}

.btn-outline-dark:not(:disabled):not(.disabled):active:focus, .btn-outline-dark:not(:disabled):not(.disabled).active:focus,
.show > .btn-outline-dark.dropdown-toggle:focus {
  box-shadow: 0 0 0 0.2rem rgba(52, 58, 64, 0.5);
}

.board_list_btn{
	width : 70%;
	display: flex;
    flex-direction: row-reverse;
    margin: 5px auto;
}
</style>
<div style="margin-top: 100px;">
	<div class="board_title_div" align="center">
		<h4 class="board_title">review</h4>
		<div class="board_under"></div>
	</div>
	<br>
	<form action="index.jsp?workgroup=review&work=review_write_action" method="post" id="reviewForm">
		<input type="hidden" name="rUid" value="<%=userLogin.getUid()%>">
		<table class="board_view_table">
  		<tbody>
  			<tr>
  				<th>PRODUCT</th>
  				<td colspan="3">
  					<select name="product" id="product" class="form-select form-select-sm" aria-label=".form-select-sm example">
		            	<option value="">상품 선택</option>
  						<%for(ProductDTO product:productList) {%>
  							<option value="<%=product.getPno() %>"><%=product.getPname() %></option>
		            	<%} %>
					</select>
				</td>
			</tr>
		    <tr>
		    	<th>TITLE</th>
			    <td colspan="3">
			    	<div class="form-floating">
  						<input type="text" name="rTitle" id="rTitle">
					</div>
				<td>
		    </tr>
		    <tr>
		    	<th>CONTENT</th>
			    <td colspan="3">
			    	<div class="form-floating">
  						<textarea class="form-control" name="rContent" id="rContent" style="height: 100px"></textarea>
					</div>
				<td>
		    </tr>
  		</tbody>
		</table>
		<div class="board_list_btn">
			<button type="submit" class="btn btn-outline-dark">OK</button>
		</div>
  	</form>
</div>
<script type="text/javascript">
$("#reviewForm").submit(function() {
	var selectProduct = document.getElementById("product").value;
	if(!selectProduct){
		alert("상품을 선택해 주세요");
		return false;
	}
	
	if($("#rTitle").val()=="") {
		alert("제목을 입력해 주세요.");
		$("#rTitle").focus();
		return false;
	}
	
	if($("#rContent").val()=="") {
		alert("내용을 입력해 주세요.");
		$("#rContent").focus();
		return false;
	}
});
</script>