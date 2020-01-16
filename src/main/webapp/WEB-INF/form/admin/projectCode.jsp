<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Gravity M/M</title>
<script type="text/javascript" src="/mm/common/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="/mm/common/js/select2.js"></script>
<script type="text/javascript">
$(function() {
	
	$("#search_project_seq").select2();
	
	//해당 날짜 프로젝트 조회
	$("#btn_search").click(function() {
		
		$("#urlPage").val("projectCode");
		$("#methodType").val("search");
		
		if($("#search_date option:selected").val() == ""){
			alert("작업월을 선택해 주세요.");
			
		} else {
			doSubmit();
			
		}
	});
	
	
	//다음달 프로젝트 데이터 입력
	$("#btn_prev_month").click(function() {
					
		$("#urlPage").val("projectCode");
		$("#methodType").val("addPrev");
		
		if(false!=confirm($("#prev_month").val() + " 데이터가 " 
				+ $("#default_month").val() + " 데이터로 저장됩니다.\r\n"
				+ "기존에 저장된 " + $("#default_month").val() + " 데이터는 삭제 됩니다.\r\n"
				+ "저장 하시겠습니까?")){
			doSubmit();
		}
		
	});
	
	
	//프로젝트 엑셀 다운로드
	$("#projectDown").click(function() {
		
		var projectCodeSeq = ""
			
		if($("#search_date").val() == "") {
				
			alert("작업월을 조회해 주세요.");
		} else {
				
			$("[name='checkProject']").each(function(){
					
				if($(this).is(":checked")){
						
					projectCodeSeq += $(this).val() + ","
				}
			});
				
			$("#projectCodeSEQ").val(projectCodeSeq);
			$("#urlPage").val("projectCode");
			$("#methodType").val("excel");
			doSubmit();
		}
	});
	
	
	//프로젝트 추가
	$("#projectAdd").click(function() {
		
		var mytable = document.getElementById('projectInserEdit');
		
		document.getElementById("projectAddTable").style.display = "block";
		
		if(mytable.rows.length > 1){
			for(var i = 1; mytable.rows.length != i; i){
					
				mytable.deleteRow(1);
			}
		}					

		row = mytable.insertRow(mytable.rows.length);
		
		cell1 = row.insertCell(0);
		cell2 = row.insertCell(1);
		cell3 = row.insertCell(2);
		cell4 = row.insertCell(3);

		cell1.innerHTML = "<td><select id='addProjectDate' name='addProjectDate' class='form-control'><option value=''>작업월</option><c:forEach var='item' items='${lMonth }'><option value='${item }'>${item }</option></c:forEach></select></td>";
		cell2.innerHTML = "<td><input type='hidden'	id='addProjectSeq'	name='addProjectSeq' value='' /><input type='checkbox' id='addProjectCheck' name='addProjectCheck' />     check(Y)</td>";
		cell3.innerHTML = "<td><input type='text' id='addProjectCode' name='addProjectCode'/></td>";
		cell4.innerHTML = "<td><input type='text' id='addProjectName' name='addProjectName' style='width: 300px;'/></td>";
		
		$("#projectState").val("projectAdd");
	});
	
	
	//프로젝트 수정
	$("#projectEdit").click(function() {
		
		var projectSeq = "";
		var projectNum = "";
		var projectName = "";
		var projectYN = "";
		var choice = 0;
		
		var mytable = document.getElementById('projectInserEdit');
		
		if(mytable.rows.length > 1){
			for(var i = 1; mytable.rows.length != i; i){
				
				mytable.deleteRow(1);
			}
		}
		
		$("[name='checkProject']").each(function(){
			
			if($(this).is(":checked")){
				
				document.getElementById("projectAddTable").style.display = "block";
				//index 찾기
				projectIndex = $(this).closest('tr').index();
				
				projectSeq = $(this).val();
				projectYN = $(this).closest('tr').find('[name="projectYN"]').text();
				projectNum = $(this).closest('tr').find('[name="projectNum"]').text();
				projectName = $(this).closest('tr').find('[name="projectName"]').text();
				
				choice ++;
			}
		});
		
			if(choice == 0) {
				
				document.getElementById("projectAddTable").style.display = "none";
			alert("수정할 프로젝트를 선택해 주세요.");
		} else if(choice > 1) {
			
			document.getElementById("projectAddTable").style.display = "none";
			alert("프로젝트를 하나만 선택해주세요.");
		} else {
			
			row = mytable.insertRow(mytable.rows.length);
			
			cell1 = row.insertCell(0);
			cell2 = row.insertCell(1);
			cell3 = row.insertCell(2);
			cell4 = row.insertCell(3);
			
			cell1.innerHTML = "<td><input type='text' id='addProjectDate' name='addProjectDate' value='${searchBean.search_date}' readonly style='text-align:center; border: 0;' /></td>";
			
			if(projectYN == "Y") {
				cell2.innerHTML = "<td><input type='hidden'	id='addProjectSeq'	name='addProjectSeq' value='" + projectSeq + "' /><input type='checkbox' id='addProjectCheck' name='addProjectCheck' checked='checked' />     check(Y)</td>";
			} else {
				cell2.innerHTML = "<td><input type='hidden'	id='addProjectSeq'	name='addProjectSeq' value='" + projectSeq + "' /><input type='checkbox' id='addProjectCheck' name='addProjectCheck' />     check(Y)</td>";	
			}
			
			cell3.innerHTML = "<td><input type='text' id='addProjectCode' name='addProjectCode' value='" + projectNum + "'/></td>";
			cell4.innerHTML = "<td><input type='text' id='addProjectName' name='addProjectName' value='" + projectName + "' style='width: 300px;'/></td>";
			
			$("#projectState").val("projectEdit");
		}
		
	});
	
	
	//프로젝트 추가/수정 취소
	$("#btn_delete").click(function() {
		
		document.getElementById("projectAddTable").style.display = "block";
		var mytable = document.getElementById('projectInserEdit');
			
		if(mytable.rows.length > 1){
			for(var i = 1; mytable.rows.length != i; i){
				
				mytable.deleteRow(1);
			}
		}

		document.getElementById("projectAddTable").style.display = "none";
	});
	
	
	//프로젝트 추가/수정 저장
	$("#btn_save").click(function() {
		
		$("#urlPage").val("projectCode");
		$("#methodType").val("save");
		
		if($("#addProjectCheck").is(":checked")){
			$("#projectUseYN").val("Y");
		} else {
			$("#projectUseYN").val("N");
		}
		
		if($("#addProjectDate").val() == "" || $("#addProjectCode").val() == "" || $("#addProjectName").val() == "") {
			
			alert("작업년도 또는 프로젝트 코드, 프로젝트 명을 입력하지 않았습니다.");
		} else {
			
			doSubmit();
		}
		
		
	});
	
//$(function(){}) 종료	
})


//프로젝트 사용 유무 변경
function projectUse(use){
	
	var projectSeqArray = "";
	var projectUseYN = "";
	var choice = 0;
	
	$("[name='checkProject']").each(function(){
		
		if($(this).is(":checked")){
			
			choice ++;
		}
	});
	
	if(choice == 0) {
		
		alert("프로젝트를 선택해주세요.");
	} else {
		
		$("#urlPage").val("projectCode");
		$("#methodType").val("projectUse");
		$("#projectUseYN").val(use);
		
		$("[name='checkProject']").each(function(){
			if($(this).is(":checked")){
				projectSeqArray += $(this).val() + ",";
			} 
		});
		
		if($("#projectUseYN").val() == "Y") {
			
			projectUseYN = "사용";
		} else if($("#projectUseYN").val() == "N") {
			
			projectUseYN = "미사용";
		}
		if(false!=confirm("프로젝트 " + projectUseYN + "으로 변경하시겠습니까?")){
			
			$("#projectSeq").val(projectSeqArray);
			doSubmit();
		}
	}
}


//프로젝트 전체 선택
function allProject(){

	if($("#allCheckProject").is(":checked")){
		$("[name='checkProject']").each(function(){
			$(this)[0].checked = true;
			
		});
	} else {
		$("[name='checkProject']").each(function(){
			$(this)[0].checked = false;
			
		});
	}
}	
	
</script>
</head>
<body>
<form id="userInfo" method="post" style="width:1600px; margin:auto; margin-top:50px;">
	<input type="hidden"				id="urlPage" 				name="urlPage" 				value="${urlPage }" />
	<input type="hidden"				id="methodType" 			name="methodType" 			value="" />
	<input type="hidden"				id="userSEQ"				name="userSEQ" 				value="${userBean.userSEQ } "/>
	<input type="hidden"				id="userID"					name="userID"				value="${userBean.userID }" />
	<input type="hidden"				id="userName" 				name="userName" 			value="${userBean.userName }" />
	<input type="hidden"				id="userMail" 				name="userMail" 			value="${userBean.userMail }" />
	<input type="hidden"				id="userNum" 				name="userNum" 				value="${userBean.userNum }" />
	<input type="hidden"				id="userAuth" 				name="userAuth" 			value="${userBean.userAuth }" />
	<input type="hidden"				id="userDeptAuth" 			name="userDeptAuth" 		value="${userBean.userDeptAuth }"/>
	<input type="hidden"				id="projectUseYN" 			name="projectUseYN" 		value="" />
	<input type="hidden"				id="projectState" 			name="projectState" 		value="" />
	<input type="hidden"				id="projectSeq" 			name="projectSeq" 			value="" />
	<input type="hidden"				id="projectCodeSEQ" 		name="projectCodeSEQ" 		value="" />

	<jsp:include page="/WEB-INF/form/top.jsp"></jsp:include>
	
	<div class="mm-menu-name"><h5>관리자 M/M (프로젝트 코드 추가/비활성화)</h5></div>
	
	<table class="mm-search">
		<tr>
			<th class="text-muted" style="width:60px; text-align: left;">작업월</th>
			<td style="width:120px;">
				<select id="search_date" name="search_date" class="form-control">
					<option value="">작업월</option>
					<c:forEach var='item' items="${lMonth }">
						<option value="${item }" ${item == searchBean.search_date ? "selected='selected'" : ""}>${item }</option>
					</c:forEach>
				</select>
			</td>
			<th class="text-muted" style="width:120px; text-align: center;">프로젝트 명</th>
			<td style="width:200px;">
				<select id="search_project_seq" name="search_project_seq" class="form-control">
					<option value="">프로젝트 명</option>
					<c:forEach var='item' items="${lProjectCode }">
						<option value="${item.i_seq_pk }" ${item.i_seq_pk == searchBean.search_project_seq ? "selected='selected'" : ""}>${item.v_project_name }</option>
					</c:forEach>
				</select>
			</td>
			<th class="text-muted" style="width:100px; text-align: center;">사용 유무</th>
			<td style="width:120px;">
				<select id="project_user_flag" name="project_user_flag" class="form-control">
					<option value="" ${"" == searchBean.project_user_flag ? "selected='selected'" : ""}>전부</option>
					<option value="Y" ${"Y" == searchBean.project_user_flag ? "selected='selected'" : ""}>사용</option>
					<option value="N" ${"N" == searchBean.project_user_flag ? "selected='selected'" : ""}>미사용</option>
				</select>
			</td>
			<td><button type="button" id="btn_search" name="btn_search" class="btn btn-secondary btn-sm">조회</button></td>
		</tr>
	</table>
	
	<table class="mm-search">
		<tr>
			<td style="margin-top:10px;">
				<button type="button" id="projectDown" name="projectDown" class="btn btn-outline-primary" >Excel 다운로드</button>
				<c:forEach var='item' items="${lMonth }" begin="1" end="1">
					<button type="button" id="btn_prev_month" name="btn_prev_month" class="btn btn-outline-primary">${item } 데이터 가져오기</button>
					<input type="hidden" name="prev_month" id="prev_month" value="${item}"/>
				</c:forEach>
				<c:forEach var='item' items="${lMonth }" begin="0" end="0">
					<input type="hidden" id="default_month" name="default_month" value="${item}"/>
				</c:forEach>
				<button type="button" id="projectUseY" name="projectUseY"  class="btn btn-outline-primary" onclick="projectUse('Y')">사용</button>
				<button type="button" id="projectUseN" name="projectUseN" class="btn btn-outline-primary" onclick="projectUse('N')">미사용</button>
				<button type="button" id="projectAdd" name="projectAdd" class="btn btn-outline-primary">추가</button>
				<button type="button" id="projectEdit" name="projectEdit" class="btn btn-outline-primary">수정</button>
			</td>
		</tr>
	</table>
	
	
	<!-- 프로젝트 추가 테이블 -->
	<table id="projectAddTable" name="projectAddTable" style="display:none;  margin-right:15px">
		<tr>
			<td style="border-bottom-width: 0px; padding-bottom: 0px;">
				<table id="projectInserEdit" name="projectInserEdit" class="table table-bordered">
					<thead>
						<tr class="table-primary">
							<th scope="col" style="color: #050505; text-align: center; width: 200px; font-size: 14px;">작업년도</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">사용유무 선택</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">프로젝트 코드</th>
							<th scope="col" style="color: #050505; text-align: center; width: 300px; font-size: 14px;">프로젝트 명</th>
						</tr>
					</thead>
				</table>
			</td>
		</tr>
		<tr>
			<td style="border-top-width: 0px; padding-top: 0px; padding-bottom:10px;">
				<table align="right">
					<tr>
						<th>
							<input type="button" id="btn_save" name="btn_save" class="btn btn-primary btn-sm" value="저장" style="width:60px;" />
						</th>
						<th>
							<input type="button" id="btn_delete" name="btn_delete" class="btn btn-primary btn-sm" value="취소" style="width:60px;" />
						</th>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	
	<!-- 프로젝트 조회 목록 -->
	<table class="table" style="width: 1000px; margin-left: 5px">
		<tr>
			<td style="padding-right: 10px;">
				<table class="table table-bordered">
					<thead>
						<tr class="table-primary">
							<th scope="col" width=90px style="color: #050505; text-align: center; font-size: 14px;"><input type="checkbox" id="allCheckProject" name="allCheckProject" onclick="allProject()"/>  선택</th>
							<th scope="col" width=100px style="color: #050505; text-align: center; font-size: 14px;">사용 유무</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">프로젝트 코드</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">프로젝트 명</th>
						</tr>
					</thead>
					<c:if test="${lProjectCode.size() != 0 }">
						<c:forEach var="item" items="${lProjectCode }">
							<tr>
								<td style="text-align: center; font-size: 14px;"><input type="checkbox" id="checkProject" name="checkProject" value="${item.i_seq_pk }"/></td>
								<td id="projectYN" name="projectYN" style="text-align: center; font-size: 14px;">${item.v_disable }</td>
								<td id="projectNum" name="projectNum" style="font-size: 14px;">${item.v_project_code }</td>
								<td id="projectName" name="projectName" style="font-size: 14px;">${item.v_project_name }</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</td>
		</tr>
	</table>

</form>
</body>
</html>