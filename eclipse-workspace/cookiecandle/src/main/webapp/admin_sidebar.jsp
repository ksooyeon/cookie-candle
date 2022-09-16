<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

	 <!-- Sidebar - Brand -->
	 <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.jsp">
	     <div class="sidebar-brand-icon rotate-n-15">
	         <i class="fas fa-cookie"></i>
	     </div>
	     <div class="sidebar-brand-text mx-3" style="text-align: left;">Cookie Candle</div>
	 </a>
	
	 <!-- Divider -->
	 <hr class="sidebar-divider my-0">
	
	 <!-- Nav Item - Dashboard -->
	 <li class="nav-item active">
	     <a class="nav-link" href="admin_index.jsp">
	         <i class="fas fa-fw fa-tachometer-alt"></i>
	         <span>홈</span></a>
	 </li>
	
	 <!-- Divider -->
	 <hr class="sidebar-divider">
	
	 <!-- Heading -->
	 <div class="sidebar-heading">
	     쇼핑몰
	 </div>
	
	 <!-- Nav Item - Pages Collapse Menu -->
	 <li class="nav-item">
	     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
	         aria-expanded="true" aria-controls="collapseTwo">
	         <i class="fas fa-fw fa-cog"></i>
	         <span>상품 관리</span>
	     </a>
	     <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
	         <div class="bg-white py-2 collapse-inner rounded">
	             <h6 class="collapse-header">Products</h6>
	             <a class="collapse-item" href="admin_index.jsp?workgroup=admin&work=product_reg">상품 등록</a>
	             <a class="collapse-item" href="admin_index.jsp?workgroup=admin&work=product_mng">상품 관리</a>
	         </div>
	     </div>
	 </li>
	
	 <!-- Nav Item - Utilities Collapse Menu -->
	 <li class="nav-item">
	     <a class="nav-link" href="admin_index.jsp?workgroup=admin&work=order_mng">
	         <i class="fas fa-fw fa-table"></i>
	         <span>전체주문관리</span></a>
	 </li>
	 
	 <li class="nav-item">
	     <a class="nav-link" href="admin_index.jsp?workgroup=admin&work=customer_mng">
	         <i class="fas fa-fw fa-table"></i>
	         <span>고객 관리</span></a>
	 </li>
	 
	 <li class="nav-item">
	     <a class="nav-link" href="admin_index.jsp?workgroup=admin&work=board_mng">
	         <i class="fas fa-fw fa-table"></i>
	         <span>게시물 관리</span></a>
	 </li>
	
	 <!-- Divider -->
	 <hr class="sidebar-divider d-none d-md-block">
	
	 <!-- Sidebar Toggler (Sidebar) -->
	 <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

</ul>