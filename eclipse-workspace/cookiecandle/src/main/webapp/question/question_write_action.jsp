<%@page import="coocan.com.dao.QuestionDAO"%>
<%@page import="coocan.com.dto.QuestionDTO"%>
<%@page import="coocan.com.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ref="0", reStep="0";
	if(request.getParameter("ref")!=null) {//전달값이 있는 경우(답글인 경우)
		ref=request.getParameter("ref");
		//reStep=request.getParameter("reStep");
	}
	String qTitle = Utility.escapeTag(request.getParameter("qTitle"));
	String qContent = Utility.escapeTag(request.getParameter("qContent"));
	String qUid=request.getParameter("qUid");
	int status = Integer.parseInt(request.getParameter("secret"));
	
	QuestionDTO question = new QuestionDTO();
	question.setqTitle(qTitle);
	question.setqContent(qContent);
	question.setqUid(qUid);
	question.setqStatus(status);
	question.setRef(Integer.parseInt(ref));
	
	QuestionDAO.getDAO().insertQuestion(question);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=question&work=question_list'");
	out.println("</script>");
%>