<%@page import="coocan.com.dto.UserDTO"%>
<%@page import="coocan.com.dto.QuestionDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="coocan.com.dao.QuestionDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String search=request.getParameter("search");
   if(search==null) {
   search="";
   }
   String keyword=request.getParameter("keyword");
   if(keyword==null) {
   keyword="";
   }
   int pageNum=1;
   if(request.getParameter("pageNum")!=null){
      pageNum=Integer.parseInt(request.getParameter("pageNum"));
   }
   
   int pageSize=10;
   int totalQuestion=QuestionDAO.getDAO().selectQuestionCount(search, keyword);
   int totalPage=(int)Math.ceil((double)totalQuestion/pageSize);
   if(pageNum<=0 || pageNum>totalPage) {//비정상 요청 페이지
      pageNum=1;
   }
   int startRow=(pageNum-1)*pageSize+1;
   int endRow=pageNum*pageSize;
   if(endRow>totalQuestion) {
      endRow=totalQuestion;
   }
   List<QuestionDTO> questionList = QuestionDAO.getDAO().selectAllQuestionList(startRow, endRow, search, keyword);
   String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
   int rowNum=totalQuestion-(pageNum-1)*pageSize;
   
   UserDTO userLogin=(UserDTO)session.getAttribute("userLogin");
%>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>   
<style>
   .table {
       width: 70%;
       margin: 5px auto;
       /* border: 0.5px solid black; */
       border-collapse: collapse;
   }
   
   .table th {
       /* height: 40px;
       border: 0.5px solid black;
       text-align: center;
       border-color: #333333; */
       background: #fcfcfc;
       padding: 10px 0 10px 0;
       text-align: center;
       /* border-top-width: 2px; */
       border-bottom-width: 2px;
       /* border-top-style: solid; */
       border-bottom-style: solid;
       font-weight: bold;
   }
   
   .table td {
       /* height: 40px;
       border: 0.5px solid black; */
           text-align: center;
       padding: 5px 9px 5px 9px;
       border-bottom-color: #eeeeee;
       border-bottom-width: 1px;
       border-bottom-style: solid;
   }
   
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
   
   .table-hover tbody tr:hover {
        color: #212529;
        background-color: rgba(0, 0, 0, 0.075);
   }
   
   .notice_foot{
      position: relative;
       margin: 0 auto;
   }
   
   .pagination{
      top: 30px;
       position: relative;
       display: inline-block;
       left: 50%;
       transform: translate(-50%, 0%);
   }
   
   .pagination span{
      float: left;
         width: 34px;
       height: 34px;
       line-height: 32px;
       text-align: center;
       font-size: 15px;
       font-weight: 300;
       border-radius: 50%;
       color: #555;
       transition: background-color .3s;
       border: 0px solid #ddd;
       margin: 0 4px;
       cursor: pointer;
   }
   
   .pagination span.active{
      border: 2px solid #fcd158;
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

.question_search{
   text-align:center;
}
</style>

<div style="margin-top: 100px;">
   <div class="board_title_div" align="center">
      <h4 class="board_title">q&a</h4>
      <div class="board_under"></div>
   </div>
   <br>
   <table class="table table-hover">
        <thead>
          <tr>
               <th width="10%">NO</th>
               <th>TITLE</th>
               <th width="10%">ID</th>
               <th width="20%">DATE</th>
          </tr>
        </thead>
        <tbody>
           <% for(QuestionDTO question:questionList) {%>
             <tr>
                <td><%=question.getqNo() %></td>
                <td>
                	<a href="index.jsp?workgroup=question&work=question_view&num=<%=question.getqNo()%>">	
                  <% if(question.getRef()!=0) {//답글인 경우 %>
                     <%-- 게시글의 깊이에 의해 왼쪽 여백을 다르게 설정하여 응답되도록 처리 --%>
                     <span style="margin-left: 40px;">└[답글]</span>
                  <% } %>
                  <%=question.getqTitle()%></a>
               </td>
                <td><%=question.getqUid() %></td>
                <td><%=question.getqDate() %></td>
             </tr>
         <% } %>
        </tbody>
   </table>
   <%  int blockSize=5;
      int startPage=(pageNum-1)/blockSize*blockSize+1;
      int endPage=startPage+blockSize-1;
      if(endPage>totalPage) {
         endPage=totalPage;
      }
   %>
   <div class="question_foot">
      <div class="pagination">
         <% if(startPage>blockSize) {//첫번째 블럭이 아닌 경우 - 링크 설정 %>
            <a href="index.jsp?workgroup=question&work=question_list&pageNum=1&search=<%=search%>&keyword=<%=keyword%>"><span><<</span></a>
            <a href="index.jsp?workgroup=question&work=question_list&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>"><span><</span></a>
         <% } else{ %>
            <span><<</span>
            <span><</span>
         <% }%>
         <% for(int i=startPage;i<=endPage;i++) { %>
            <% if(pageNum!=i) {//요청 페이지 번호와 이벤트 페이지 번호가 다른 경우 - 링크 설정 %>
               <a href="index.jsp?workgroup=question&work=question_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>"><span class="numberPage"><%=i %></span></a>
            <% } else {//요청 페이지 번호와 이벤트 페이지 번호가 같이 경우 - 링크 미설정 %>
               <span class="numberPage active"><%=i %></span>
            <% } %>
         <% } %>
         <% if(endPage!=totalPage) {//마지막 블럭이 아닌 경우 - 링크 설정 %>
            <a href="index.jsp?workgroup=question&work=question_list&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>"><span>></span></a>
            <a href="index.jsp?workgroup=question&work=question_list&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>"><span>>></span></a>
         <% } else { %>
            <span>></span>
            <span>>></span>
         <% } %>
         <!-- <span><<</span> 
         <span><</span>
         <span class="numberPage active">1</span>
         <span class="numberPage">2</span>
         <span class="numberPage">3</span>
         <span>></span> 
         <span>>></span> -->
      </div>
   <div class="board_list_btn">
         <% if(userLogin!=null) {//로그인 사용자 중 게시글 작성자이거나 관리자인 경우 %>   
            <a class="btn btn-outline-dark" href="index.jsp?workgroup=question&work=question_write">write</a>
         <% } %>
      </div>
   </div>
   <br>
   <br><br>
   <div class="question_search">
      <form action="index.jsp?workgroup=question&work=question_list" method="post">
         <%-- select 태그에 의해 전달되는 값은 검색단어를 비교하기 위한 컬럼명과 동일한 이름으로 전달되도록 설정 --%>
         <select id="search" name="search">
            <option value="q_uid" selected="selected">&nbsp;작성자&nbsp;</option>
            <option value="q_title">&nbsp;제목&nbsp;</option>
            <option value="q_content">&nbsp;내용&nbsp;</option>
         </select>
         <input type="text" name="keyword" value="<%=keyword%>">
         <button type="submit">검색</button>
      </form>
   </div>
</div>
<script type="text/javascript">
   var search="<%=search%>";
   if(search){
      $("#search").val(search);
   }
</script>