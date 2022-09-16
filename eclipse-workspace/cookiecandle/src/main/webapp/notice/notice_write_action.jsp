<%@page import="coocan.com.dao.NoticeDAO"%>
<%@page import="coocan.com.dto.NoticeDTO"%>
<%@page import="coocan.com.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String nTitle=Utility.escapeTag(request.getParameter("nTitle"));
	String nContent=Utility.escapeTag(request.getParameter("nContent"));
	String nUid=request.getParameter("nUid");
	
	NoticeDTO notice = new NoticeDTO();
	notice.setnTitle(nTitle);
	notice.setnContent(nContent);
	
	NoticeDAO.getDAO().insertNotice(notice);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?workgroup=notice&work=notice_list'");
	out.println("</script>");
%>