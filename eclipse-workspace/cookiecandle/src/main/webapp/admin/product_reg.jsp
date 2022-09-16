<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>

<div class="container px-5 my-5">
	<div class="d-sm-flex align-items-center justify-content-between mb-3">
		<h1 class="h2 mb-0 text-gray-900 font-weight-bold">상품 등록</h1>
	</div>
	
	<div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">기본 정보</h6>
        </div>
        <div class="card-body">
            <form action="admin_index.jsp?workgroup=admin&work=product_add_action" method="post" enctype="multipart/form-data" id="productForm" data-sb-form-api-token="API_TOKEN">
		        <div class="mb-3">
		            <label class="form-label" for="pname">상품명</label>
		            <textarea class="form-control" id="pname" name="pname" type="text" style="height: 5rem;" data-sb-validations="required"></textarea>
		            <div class="invalid-feedback" data-sb-feedback="pname:required">상품명을 입력해주세요</div>
		        </div>
		        <div class="mb-3">
		            <label class="form-label" for="상품분류">상품 분류</label>
		            <br>
		            <select class="form-select" name="category" aria-label="상품 분류">
		                <option value="Candle" selected>Candle</option>
		                <option value="Candle Holder">Candle Holder</option>
		                <option value="Candle Care">Candle Care</option>
		            </select>
		        </div>
		        <div class="mb-3">
		            <label class="form-label" for="price">가격</label>
		            <input class="form-control" id="price" name="price" type="text" data-sb-validations="required" />
		            <div class="invalid-feedback" data-sb-feedback="price:required">가격을 입력해주세요</div>
		        </div>
		        <div class="mb-3">
		            <label class="form-label" for="stock">재고 수량</label>
		            <input class="form-control" id="stock" name="stock" type="text" data-sb-validations="required" />
		            <div class="invalid-feedback" data-sb-feedback="stock:required">재고 수량을 입력해주세요</div>
		        </div>
		        
		        
				<div class="form-group">
				  <label for="img1">대표 이미지</label>
				  <input type="file" class="form-control-file" name="img1" id="img1">
				</div>
				
				<div class="form-group">
				  <label for="img2">상세 이미지</label>
				  <input type="file" class="form-control-file" name="img2" id="img2">
				</div>
				
		        <div class="d-none" id="submitSuccessMessage">
		            <div class="text-center mb-3">
		                <div class="fw-bolder">상품을 성공적으로 등록하였습니다</div>
		                <p>To activate this form, sign up at</p>
		                <a href="https://startbootstrap.com/solution/contact-forms">https://startbootstrap.com/solution/contact-forms</a>
		            </div>
		        </div>
		        <div class="d-none" id="submitErrorMessage">
		            <div class="text-center text-danger mb-3">상품 등록에 실패하였습니다</div>
		        </div>
		        <br>
		        <div class="d-grid">
		            <button type="button" id="btn_proreg" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#reg_modal">상품 등록</button>
		           
		            <!-- Modal -->
					<div class="modal fade" id="reg_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					      
					      <div class="modal-body" style="height: 100px;">
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					        <h6 id="p_check" style="text-align: center; color: black; margin-top: 2em;">상품을 등록하시겠습니까?</h6>
					        	
					      </div>
					      <div class="modal-footer" style="justify-content: center;">
					      	<button type="submit" class="btn btn-primary">등록</button>
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					      </div>
					    </div>
					  </div>
					</div>
		        </div>
		    </form>
		    <div id="message" style="color: red;"></div>
        </div>
    </div>
</div>
<script type="text/javascript">
	
	$("#btn_proreg").click(function() {
		if($("#pname").val()=="") {
			$("#message").text("제품명을 입력해 주세요.");
			$("#pname").focus();
			return false;
		}
		
		if($("#price").val()=="") {
			$("#message").text("가격을 입력해 주세요.");
			$("#price").focus();
			return false;
		}
		
		if($("#stock").val()=="") {
			$("#message").text("재고 수량을 입력해 주세요.");
			$("#stock").focus();
			return false;
		}
		
		if($("#img1").val()=="") {
			$("#message").text("대표이미지를 입력해 주세요.");
			$("#img1").focus();
			return false;
		}
		
		if($("#img2").val()=="") {
			$("#message").text("상세이미지를 입력해 주세요.");
			$("#img2").focus();
			return false;
		}
	});
</script>
<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>