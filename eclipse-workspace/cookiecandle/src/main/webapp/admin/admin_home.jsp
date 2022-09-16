<%@page import="coocan.com.dao.BoardDAO"%>
<%@page import="coocan.com.dao.UserDAO"%>
<%@page import="coocan.com.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>

<div class="container-fluid">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h5 mb-0 text-gray-800">전체 쇼핑몰 운영 현황</h1>
    </div>

    <!-- Content Row -->
    <div class="row" style="">
		
		<%
			int orderCount = OrderDAO.getDAO().countAllOrders();
			int allPrice = OrderDAO.getDAO().sumAllPrice();
		
			int payCount = OrderDAO.getDAO().countPayment()[0];
			int payPrice = OrderDAO.getDAO().countPayment()[1];
			
			int allUserCount = UserDAO.getDAO().countUsers()[0];
			int normalUserCount = UserDAO.getDAO().countUsers()[1];
			int restUserCount = UserDAO.getDAO().countUsers()[2];
			
			int status_0 = OrderDAO.getDAO().countStatus(0);  // 입금전 주문상태 갯수
			int status_3 = OrderDAO.getDAO().countStatus(3);  // 배송준비중
			int status_4 = OrderDAO.getDAO().countStatus(4);  // 배송중
			int status_5 = OrderDAO.getDAO().countStatus(5);  // 배송완료
			
			int noticeCount = BoardDAO.getDAO().countBoard()[0];
			int reviewCount = BoardDAO.getDAO().countBoard()[1];
			int questionCount = BoardDAO.getDAO().countBoard()[2];
			int replyCount = BoardDAO.getDAO().countBoard()[3];
			
			int complete = (replyCount / questionCount) * 100;
		%>
		
        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-s font-weight-bold text-primary mb-1">
                                주문 (<%=orderCount %>건)</div>
                            <div class="h3 mb-0 font-weight-bold text-gray-800"><%=allPrice %>원</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-receipt fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-s font-weight-bold text-primary mb-1">
                                결제 (<%=payCount %>건)</div>
                            <div class="h3 mb-0 font-weight-bold text-gray-800"><%=payPrice %>원</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h5 mb-0 text-gray-800">전체 주문 현황</h1>
    </div>
    
    <!-- Content Row -->
    <div class="row">

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-s font-weight-bold text-success mb-1">
                                입금전</div>
                            <div class="h3 mb-0 font-weight-bold text-gray-800"><%=status_0 %>건</div>
                        </div>
                        <div class="col-auto">
                            <i class="far fa-credit-card fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-s font-weight-bold text-success mb-1">
                                배송 준비</div>
                            <div class="h3 mb-0 font-weight-bold text-gray-800"><%=status_3 %>건</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-pause fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-s font-weight-bold text-success mb-1">
                                배송중</div>
                            <div class="h3 mb-0 font-weight-bold text-gray-800"><%=status_4 %>건</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-play fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-s font-weight-bold text-success mb-1">
                                배송 완료</div>
                            <div class="h3 mb-0 font-weight-bold text-gray-800"><%=status_5 %>건</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-check fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 회원 -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h5 mb-0 text-gray-800">전체 회원 현황</h1>
    </div>
    
    <!-- Content Row -->
    <div class="row">

		 <div class="col-xl-3 col-md-6 mb-4" Onclick="location.href='admin_index.jsp?workgroup=admin&work=customer_mng'">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-s font-weight-bold text-warning mb-1">
                                전체 회원수</div>
                            <div class="h3 mb-0 font-weight-bold text-gray-800"><%=allUserCount %>명</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-users fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-s font-weight-bold text-warning mb-1">
                                일반 회원</div>
                            <div class="h3 mb-0 font-weight-bold text-gray-800"><%=normalUserCount %>명</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-user fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-s font-weight-bold text-warning mb-1">
                               	휴면 회원</div>
                            <div class="h3 mb-0 font-weight-bold text-gray-800"><%=restUserCount %>명</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-user-slash fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 게시글 -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h5 mb-0 text-gray-800">전체 게시글 현황</h1>
    </div>
    
    <!-- Content Row -->
    <div class="row">

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-s font-weight-bold text-info mb-1">
                                공지사항</div>
                            <div class="h3 mb-0 font-weight-bold text-gray-800"><%=noticeCount %>개</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-s font-weight-bold text-info mb-1">
                                리뷰</div>
                            <div class="h3 mb-0 font-weight-bold text-gray-800"><%=reviewCount %>개</div>
                        </div>
                        <div class="col-auto">
                            <i class="fa fa-star fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-s font-weight-bold text-info mb-1">
                                문의</div>
                            <div class="h3 mb-0 font-weight-bold text-gray-800"><%=questionCount %>개</div>
                        </div>
                        <div class="col-auto">
                            <i class="fa fa-comment fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-xl-3 col-md-6 mb-4">
             <div class="card border-left-info shadow h-100 py-2">
                 <div class="card-body">
                     <div class="row no-gutters align-items-center">
                         <div class="col mr-2">
                             <div class="text-s font-weight-bold text-info text-uppercase mb-1">답변 진행 상황
                             </div>
                             <div class="row no-gutters align-items-center">
                                 <div class="col-auto">
                                     <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"><%=complete %>%</div>
                                 </div>
                                 <div class="col">
                                     <div class="progress progress-sm mr-2">
                                         <div class="progress-bar bg-info" role="progressbar" style="width: <%=complete %>%" aria-valuenow="<%=complete %>" aria-valuemin="0" aria-valuemax="100"></div>
                                         
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <div class="col-auto">
                             <i class="fa fa-check-circle fa-2x text-gray-300"></i>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
         
    </div>
</div>