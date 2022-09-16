<%@page import="coocan.com.dao.ProductDAO"%>
<%@page import="coocan.com.dto.ProductDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>
  
<% 
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='admin_index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}

	String saveDirectory = request.getServletContext().getRealPath("/img");
	
	MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory
			, 1024*1024*15, "utf-8", new DefaultFileRenamePolicy());
	
	String name = multipartRequest.getParameter("pname");
	String category = multipartRequest.getParameter("category");
	int price = Integer.parseInt(multipartRequest.getParameter("price"));
	int stock = Integer.parseInt(multipartRequest.getParameter("stock"));
	String imageMain = multipartRequest.getFilesystemName("img1");
	String imageDetail = multipartRequest.getFilesystemName("img2");
	
	ProductDTO product=new ProductDTO();
	product.setPname(name);
	product.setKinds(category);
	product.setPrice(price);
	product.setStock(stock);
	product.setImg1(imageMain);
	product.setImg2(imageDetail);
	
	int rows = ProductDAO.getDAO().insertProduct(product);
	if(rows<=0) {
		new File(saveDirectory, imageMain).delete();
		new File(saveDirectory, imageDetail).delete();
	}
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='admin_index.jsp?workgroup=admin&work=product_reg';");
	out.println("</script>");
%>