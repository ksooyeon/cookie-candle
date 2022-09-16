<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8");
	
	String workgroup=request.getParameter("workgroup");
	if(workgroup==null) workgroup="admin";
	
	String work=request.getParameter("work");
	if(work==null) work="admin_home";
	
	String contentPath=workgroup+"/"+work+".jsp";

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Cookie Candle-Admin</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.standalone.min.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.kr.min.js"></script>
</head>
<body>
<!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <jsp:include page="admin_sidebar.jsp"/>
        
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <div id="topbar">
	                <jsp:include page="admin_topbar.jsp"/>
                </div>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div id="content"></div>
                	<jsp:include page="<%=contentPath %>"/>
             
             </div>
             <!-- /.container-fluid -->
             
             <!-- Footer -->
	         <div id="footer">
	         	<jsp:include page="admin_footer.jsp"/>
	         </div>
	         <!-- End of Footer -->

         </div>
         <!-- End of Main Content -->


        <!-- End of Content Wrapper -->
     </div>
     
     <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts 
    <script src="/js/demo/chart-area-demo.js"></script>
    <script src="/js/demo/chart-pie-demo.js"></script>
    -->
    
    <script type='text/javascript'>
		$(function(){        
			$('.input-group.date').datepicker({ 
				calendarWeeks: false,            
				todayHighlight: true,            
				autoclose: true,            
				format: "yyyy/mm/dd",            
				language: "kr"
				
			});    
			
		});   
	</script>
</body>
</html>