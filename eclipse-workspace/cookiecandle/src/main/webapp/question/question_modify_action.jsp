<%@page import="coocan.com.dao.QuestionDAO"%>
<%@page import="coocan.com.dto.QuestionDTO"%>
<%@page import="coocan.com.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String qTitle=Utility.escapeTag(request.getParameter("qTitle"));
	String qContent=Utility.escapeTag(request.getParameter("qContent"));
	int qNo=Integer.parseInt(request.getParameter("qNo"));
	
	QuestionDTO question = new QuestionDTO();
	question.setqTitle(qTitle);
	question.setqContent(qContent);
	question.setqNo(qNo);
	QuestionDAO.getDAO().updateQuestion(question);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=question&work=question_list'");
	out.println("</script>");
%>