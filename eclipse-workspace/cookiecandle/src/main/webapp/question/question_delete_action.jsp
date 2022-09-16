<%@page import="coocan.com.dao.QuestionDAO"%>
<%@page import="coocan.com.dto.QuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	QuestionDTO question = QuestionDAO.getDAO().selectQuestionView(num);
	QuestionDAO.getDAO().deleteQuestion(num);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=question&work=question_list';");
	out.println("</script>");
%>