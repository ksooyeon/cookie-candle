<%@page import="coocan.com.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserDTO loginMember=(UserDTO)session.getAttribute("userLogin");
	String id = loginMember.getName();
%>

<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

     <!-- Sidebar Toggle (Topbar) -->
     <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
         <i class="fa fa-bars"></i>
     </button>

     <!-- Topbar Navbar -->
     <ul class="navbar-nav ml-auto">
         
         <!-- Nav Item - User Information -->
         <li class="nav-item dropdown no-arrow" style="margin-right: 1rem;">
             <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                 data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                 <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=id %> 님</span>
                 <i class="fas fa-user-circle fa-2x"></i>
             </a>
             <!-- Dropdown - User Information -->
             <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                 aria-labelledby="userDropdown">
                 <a class="dropdown-item" href="index.jsp?workgroup=user&work=user_mypage">
                     <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                     내정보
                 </a>
                 <a class="dropdown-item" href="index.jsp?workgroup=user&work=user_logout" data-toggle="modal" data-target="#logoutModal">
                     <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                     로그아웃
                 </a>
             </div>
         </li>

     </ul>

 </nav>