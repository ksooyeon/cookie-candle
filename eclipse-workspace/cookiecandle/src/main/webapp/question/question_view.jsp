<%@page import="coocan.com.dto.UserDTO"%>
<%@page import="coocan.com.dao.QuestionDAO"%>
<%@page import="coocan.com.dto.QuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	QuestionDTO questionView = QuestionDAO.getDAO().selectQuestionView(num);
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
	    border:1px solid;
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
		<h4 class="board_title">q&a</h4>
		<div class="board_under"></div>
	</div>
	<br>
	<table class="board_view_table">
  		<tbody>
		    <tr>
		    	<th>TITLE</th>
			    <td><%=questionView.getqTitle() %></td>
			    <th>ID</th>
			    <td><%=questionView.getqUid() %></td>
		    </tr>
		    <tr>
		    	<th>DATE</th>
			    <td><%=questionView.getqDate() %></td>
		    </tr>
			<tr>
				<td colspan="4" class="board_content">
					<p><%=questionView.getqContent() %></p>
				</td>
			</tr>    
  		</tbody>
	</table>
	<div class="board_list_btn">
		<a id="listBtn" class="btn btn-outline-dark" href="index.jsp?workgroup=question&work=question_list">list</a>
		<% if(userLogin!=null && (userLogin.getUid().equals(questionView.getqUid()))){//로그인 사용자이거나 게시글 작성자 %>	
			<a id="deleteBtn" class="btn btn-outline-dark" style="margin-right: 5px">delete</a>
			<a id="modifyBtn" class="btn btn-outline-dark" style="margin-right: 5px">modify</a>
		<% } %>
		<%if(userLogin==null){%>	
			<a href="index.jsp?workgroup=user&work=user_login_action"></a>		
		<% } else if(userLogin.getStatus()==9) {%>
			<a id="replyBtn" class="btn btn-outline-dark" style="margin-right: 5px">reply</a>
			<%} %>
	</div>
</div>
<form method="post" id="menuForm">
	<%-- [답글쓰기]를 클릭한 경우 전달되는 값 --%>
	<input type="hidden" name="ref" value="<%=num%>">
</form>
<script type="text/javascript">
$("#replyBtn").click(function() {
	if(confirm("답글을 등록 하시겠습니까?")) {
		$("#menuForm").attr("action","index.jsp?workgroup=question&work=question_write");
		$("#menuForm").submit();
	}
});
$("#modifyBtn").click(function() {
	if(confirm("게시글을 수정 하시겠습니까?")) {
		location.href = "index.jsp?workgroup=question&work=question_modify&num=<%=questionView.getqNo()%>";
	}
});

$("#deleteBtn").click(function() {
	if(confirm("게시글을 삭제 하시겠습니까?")) {
		location.href = "index.jsp?workgroup=question&work=question_delete_action&num=<%=questionView.getqNo()%>";
	}
});
</script>