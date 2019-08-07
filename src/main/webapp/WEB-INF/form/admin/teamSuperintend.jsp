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
						
			$("#urlPage").val("projectCode");
			$("#methodType").val("excel");
			
			doSubmit();
			
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
	
	
	//첫번째 상위 조직 클릭
	function dept_1(val) {
		
		var deptName = "";
		var deptSort = "";
		var deptStep = "";
		var deptSeq = ""
		var deptUpSeq = "";
		var downDeptCount = 0;
		
		$("[name='deptTR2']").each(function(){
			
			deptUpSeq = $(this).closest('tr').find('[name="clickUpDeptSeq2"]').val();
			
			if(val == deptUpSeq) {
					
				$(this).css('display','');
				downDeptCount ++;
			} else {
				
				$(this).css('display','none');
			}
		});
		
		if(downDeptCount == 0) {
			
			document.getElementById("deptTable2").style.display = "none";
			document.getElementById("cusor1").style.display = "none";
		} else {
			
			document.getElementById("deptTable2").style.display = "block";
			document.getElementById("cusor1").style.display = "block";
		}
		
		document.getElementById("deptTable3").style.display = "none";
		document.getElementById("deptTable4").style.display = "none";
		document.getElementById("cusor2").style.display = "none";
		document.getElementById("cusor3").style.display = "none";
		
		//팀관리 추가 & 수정 테이블
		document.getElementById("deptAddTable").style.display = "block";
		
		var mytable = document.getElementById('deptInserEdit');
		
		if(mytable.rows.length > 1){
			
			for(var i = 1; mytable.rows.length != i; i){
					
				mytable.deleteRow(1);
			}
		}
		
		$("[name='deptTR1']").each(function(){
			
			if(val == $(this).closest('tr').find('[name="clickDeptSeq1"]').val()) {
				
				deptName = $(this).closest('tr').find('[name="teamSuDeptName1"]').text();
				deptSort = $(this).closest('tr').find('[name="clickSortDeptSeq1"]').val();
				deptStep = $(this).closest('tr').find('[name="clickStepDeptSeq1"]').val();
				deptSeq = $(this).closest('tr').find('[name="clickDeptSeq1"]').val();
				deptUpSeq = $(this).closest('tr').find('[name="clickUpDeptSeq1"]').val();
			}
		});
		
		row = mytable.insertRow(mytable.rows.length);
		
		cell1 = row.insertCell(0);
		cell2 = row.insertCell(1);
		cell3 = row.insertCell(2);
		cell4 = row.insertCell(3);
		
		cell1.innerHTML = "<td><input type='text' id='DeptSortNameAE' name='DeptSortNameAE' value='" + deptStep + "'/></td>";
		cell2.innerHTML = "<td><select id='DeptUpNameAE' name='DeptUpNameAE'><c:forEach var='item' items='${lDept }'><option value='${item.i_seq_pk }'>${item.v_dept_name_k }</option></c:forEach></select></td>";
		cell3.innerHTML = "<td><input type='text' id='DeptNameAE' name='DeptNameAE' value='" + deptName + "'/></td>";
		cell4.innerHTML = "<td><input type='text' id='DeptCountAE' name='DeptCountAE' value='" + deptSort + "'/></td>";
		
		$("#DeptUpNameAE").val(deptUpSeq);
		$("#DeptUpNameAE").select2();
	}
	
	
	//두번째 상위 조직 클릭
	function dept_2(val) {
		
		var deptName = "";
		var deptUpName = "";
		var deptCount = "";
		var deptSeq = ""
		var deptUpSeq = "";
		var downDeptCount = 0;
		
		$("[name='deptTR3']").each(function(){
			
			deptUpSeq = $(this).closest('tr').find('[name="clickUpDeptSeq3"]').val();
			
			if(val == deptUpSeq) {
					
				$(this).css('display','');
				downDeptCount ++;
			} else {
				
				$(this).css('display','none');
			}
		});
		
		if(downDeptCount == 0) {
			
			document.getElementById("deptTable3").style.display = "none";
			document.getElementById("cusor2").style.display = "none";
		} else {
			
			document.getElementById("deptTable3").style.display = "block";
			document.getElementById("cusor2").style.display = "block";
		}
		
		document.getElementById("deptTable4").style.display = "none";
		document.getElementById("cusor3").style.display = "none";
		
		
		//팀관리 추가 & 수정 테이블
		document.getElementById("deptAddTable").style.display = "block";
		
		var mytable = document.getElementById('deptInserEdit');
		
		if(mytable.rows.length > 1){
			
			for(var i = 1; mytable.rows.length != i; i){
					
				mytable.deleteRow(1);
			}
		}
		
		$("[name='deptTR2']").each(function(){
			
			if(val == $(this).closest('tr').find('[name="clickDeptSeq2"]').val()) {
				
				deptName = $(this).closest('tr').find('[name="teamSuDeptName2"]').text();
				deptSort = $(this).closest('tr').find('[name="clickSortDeptSeq2"]').val();
				deptStep = $(this).closest('tr').find('[name="clickStepDeptSeq2"]').val();
				deptSeq = $(this).closest('tr').find('[name="clickDeptSeq2"]').val();
				deptUpSeq = $(this).closest('tr').find('[name="clickUpDeptSeq2"]').val();
			}
		});
		
		row = mytable.insertRow(mytable.rows.length);
		
		cell1 = row.insertCell(0);
		cell2 = row.insertCell(1);
		cell3 = row.insertCell(2);
		cell4 = row.insertCell(3);
		
		cell1.innerHTML = "<td><input type='text' id='DeptSortNameAE' name='DeptSortNameAE' value='" + deptStep + "'/></td>";
		cell2.innerHTML = "<td><input type='text' id='DeptNameAE' name='DeptNameAE' value='" + deptName + "'/></td>";
		cell3.innerHTML = "<td><select id='DeptUpNameAE' name='DeptUpNameAE'><c:forEach var='item' items='${lDept }'><option value='${item.i_seq_pk }'>${item.v_dept_name_k }</option></c:forEach></select></td>";
		cell4.innerHTML = "<td><input type='text' id='DeptCountAE' name='DeptCountAE' value='" + deptSort + "'/></td>";
		
		$("#DeptUpNameAE").val(deptUpSeq);
		$("#DeptUpNameAE").select2();
	}
	
	
	//세번째 상위 조직 클릭
	function dept_3(val) {
		
		var deptName = "";
		var deptUpName = "";
		var deptCount = "";
		var deptSeq = ""
		var deptUpSeq = "";
		var downDeptCount = 0;
		
		$("[name='deptTR4']").each(function(){
			
			deptUpSeq = $(this).closest('tr').find('[name="clickUpDeptSeq4"]').val();
			
			if(val == deptUpSeq) {
					
				$(this).css('display','');
				downDeptCount ++;
			} else {
				
				$(this).css('display','none');
			}
		});
		
		if(downDeptCount == 0) {
			
			document.getElementById("deptTable4").style.display = "none";
			document.getElementById("cusor3").style.display = "none";
		} else {
			
			document.getElementById("deptTable4").style.display = "block";
			document.getElementById("cusor3").style.display = "block";
		}
		
		
		//팀관리 추가 & 수정 테이블
		document.getElementById("deptAddTable").style.display = "block";
		
		var mytable = document.getElementById('deptInserEdit');
		
		if(mytable.rows.length > 1){
			
			for(var i = 1; mytable.rows.length != i; i){
					
				mytable.deleteRow(1);
			}
		}
		
		$("[name='deptTR3']").each(function(){
			
			if(val == $(this).closest('tr').find('[name="clickDeptSeq3"]').val()) {
				
				deptName = $(this).closest('tr').find('[name="teamSuDeptName3"]').text();
				deptSort = $(this).closest('tr').find('[name="clickSortDeptSeq3"]').val();
				deptStep = $(this).closest('tr').find('[name="clickStepDeptSeq3"]').val();
				deptSeq = $(this).closest('tr').find('[name="clickDeptSeq3"]').val();
				deptUpSeq = $(this).closest('tr').find('[name="clickUpDeptSeq3"]').val();
			}
		});
		
		row = mytable.insertRow(mytable.rows.length);
		
		cell1 = row.insertCell(0);
		cell2 = row.insertCell(1);
		cell3 = row.insertCell(2);
		cell4 = row.insertCell(3);
		
		cell1.innerHTML = "<td><input type='text' id='DeptSortNameAE' name='DeptSortNameAE' value='" + deptStep + "'/></td>";
		cell2.innerHTML = "<td><input type='text' id='DeptNameAE' name='DeptNameAE' value='" + deptName + "'/></td>";
		cell3.innerHTML = "<td><select id='DeptUpNameAE' name='DeptUpNameAE'><c:forEach var='item' items='${lDept }'><option value='${item.i_seq_pk }'>${item.v_dept_name_k }</option></c:forEach></select></td>";
		cell4.innerHTML = "<td><input type='text' id='DeptCountAE' name='DeptCountAE' value='" + deptSort + "'/></td>";
		
		$("#DeptUpNameAE").val(deptUpSeq);
		$("#DeptUpNameAE").select2();
	}
	
	
	//네번째 상위 조직 클릭
	function dept_4(val) {
		
		//팀관리 추가 & 수정 테이블
		document.getElementById("deptAddTable").style.display = "block";
		
		var mytable = document.getElementById('deptInserEdit');
		
		if(mytable.rows.length > 1){
			
			for(var i = 1; mytable.rows.length != i; i){
					
				mytable.deleteRow(1);
			}
		}
		
		$("[name='deptTR4']").each(function(){
			
			
			
			if(val == $(this).closest('tr').find('[name="clickDeptSeq4"]').val()) {
				
				deptName = $(this).closest('tr').find('[name="teamSuDeptName4"]').text();
				deptSort = $(this).closest('tr').find('[name="clickSortDeptSeq4"]').val();
				deptStep = $(this).closest('tr').find('[name="clickStepDeptSeq4"]').val();
				deptSeq = $(this).closest('tr').find('[name="clickDeptSeq4"]').val();
				deptUpSeq = $(this).closest('tr').find('[name="clickUpDeptSeq4"]').val();
			}
		});
		
		row = mytable.insertRow(mytable.rows.length);
		
		cell1 = row.insertCell(0);
		cell2 = row.insertCell(1);
		cell3 = row.insertCell(2);
		cell4 = row.insertCell(3);
		
		cell1.innerHTML = "<td><input type='text' id='DeptSortNameAE' name='DeptSortNameAE' value='" + deptStep + "'/></td>";
		cell2.innerHTML = "<td><input type='text' id='DeptNameAE' name='DeptNameAE' value='" + deptName + "'/></td>";
		cell3.innerHTML = "<td><select id='DeptUpNameAE' name='DeptUpNameAE'><c:forEach var='item' items='${lDept }'><option value='${item.i_seq_pk }'>${item.v_dept_name_k }</option></c:forEach></select></td>";
		cell4.innerHTML = "<td><input type='text' id='DeptCountAE' name='DeptCountAE' value='" + deptSort + "'/></td>";
		
		$("#DeptUpNameAE").val(deptUpSeq);
		$("#DeptUpNameAE").select2();
	}
		
</script>
</head>
<body>
	<form id="userInfo" method="post">
		<input type="hidden"				id="urlPage" 				name="urlPage" 				value="" />
		<input type="hidden"				id="methodType" 			name="methodType" 			value="" />
		<input type="hidden"				id="userSEQ"				name="userSEQ" 				value="${userBean.userSEQ } "/>
		<input type="hidden"				id="userID"					name="userID"				value="${userBean.userID }" />
		<input type="hidden"				id="userName" 				name="userName" 			value="${userBean.userName }" />
		<input type="hidden"				id="userMail" 				name="userMail" 			value="${userBean.userMail }" />
		<input type="hidden"				id="userNum" 				name="userNum" 				value="${userBean.userNum }" />
		<input type="hidden"				id="userAuth" 				name="userAuth" 			value="${userBean.userAuth }" />
		<input type="hidden"				id="projectUseYN" 			name="projectUseYN" 		value="" />
		<input type="hidden"				id="projectState" 			name="projectState" 		value="" />
		<input type="hidden"				id="projectSeq" 			name="projectSeq" 			value="" />
	
		<jsp:include page="/WEB-INF/form/top.jsp"></jsp:include>
		
		<div class="mm-menu-name"><h5>관리자 M/M (팀관리)</h5></div>
		
		<table class="mm-search">
			<tr>
				<td colspan="5" style="margin-top:10px;">
					<button type="button" id="projectAdd" name="projectAdd" class="btn btn-outline-primary">추가</button>
					<button type="button" id="projectEdit" name="projectEdit" class="btn btn-outline-primary">수정</button>
				</td>
			</tr>
		</table>
		
		
		<!-- 팀관리 추가 테이블 -->
		<table id="deptAddTable" name="deptAddTable" style="display:none;  margin-right:15px">
			<tr>
				<td style="border-bottom-width: 0px; padding-bottom: 0px;">
					<table id="deptInserEdit" name="deptInserEdit" class="table table-bordered">
						<thead>
							<tr class="table-primary">
								<th scope="col" style="color: #848484; text-align: center; width: 200px;">부서명규칙번호</th>
								<th scope="col" style="color: #848484; text-align: center; width: 200px;">부서명</th>
								<th scope="col" style="color: #848484; text-align: center;">상위부서</th>
								<th scope="col" style="color: #848484; text-align: center;">부서순서</th>
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
		
		
		<!-- 팀관리 조회 목록 -->
		<table style="margin-left: 5px;">
			<tr>
				<td valign="top" style="margin-left: 10px;">
				
					<!-- 팀관리 1번 조회 목록 -->
					<table id="deptTable1" name="deptTable1" class="table table-bordered">
						<thead>
							<tr class="table-primary">
								<th scope="col" style="color: #848484; text-align: center;">부서명</th>
							</tr>
						</thead>
						<c:if test="${lDept.size() != 0 }">
							<c:forEach var="item" items="${lDept }">
								<c:if test="${item.i_step eq '1' }">
									<tr id="deptTR1" name="deptTR1">
										<td id="teamSuDeptName1" name="teamSuDeptName1" style="cursor: pointer;" onclick="dept_1('${item.i_seq_pk }')">${item.v_dept_name_k }</td>
										<td style="display: none;">
											<input type="hidden" id="clickDeptSeq1" name="clickDeptSeq1" value="${item.i_seq_pk }"/>
											<input type="hidden" id="clickUpDeptSeq1" name="clickUpDeptSeq1" value="${item.i_dept_up }"/>
											<input type="hidden" id="clickSortDeptSeq1" name="clickSortDeptSeq1" value="${item.i_sort }"/>
											<input type="hidden" id="clickStepDeptSeq1" name="clickStepDeptSeq1" value="${item.i_step }"/>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</table>
				
				</td>
				<td>
				
					<div id="cusor1" name="cusor1" class="text-left" style="height: 70px; margin-top: 10px; margin-left: 10px; display: none;">
						<img src="/mm/common/images/btn_cnext_off.gif" width="80" height="30"/>
					</div>
					
				</td>
				<td valign="top">
				
					<!-- 팀관리 2번 조회 목록 -->
					<table id="deptTable2" name="deptTable2" class="table table-bordered" style="display: none;">
						<thead>
							<tr class="table-primary">
								<th scope="col" style="color: #848484; text-align: center;">부서명</th>
							</tr>
						</thead>
						<c:if test="${lDept.size() != 0 }">
							<c:forEach var="item" items="${lDept }">
								<c:if test="${item.i_step eq '2' }">
									<tr id="deptTR2" name="deptTR2" style="display:none;">
										<td id="teamSuDeptName2" name="teamSuDeptName2" style="cursor: pointer;" onclick="dept_2('${item.i_seq_pk }')">${item.v_dept_name_k }</td>
										<td style="display: none;">
											<input type="hidden" id="clickDeptSeq2" name="clickDeptSeq2" value="${item.i_seq_pk }"/>
											<input type="hidden" id="clickUpDeptSeq2" name="clickUpDeptSeq2" value="${item.i_dept_up }"/>
											<input type="hidden" id="clickSortDeptSeq2" name="clickSortDeptSeq2" value="${item.i_sort }"/>
											<input type="hidden" id="clickStepDeptSeq2" name="clickStepDeptSeq2" value="${item.i_step }"/>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</table>
				
				</td>
				
				<td>
					<div id="cusor2" name="cusor2" class="text-left" style="height: 70px; margin-top: 10px; margin-left: 10px; display: none;">
						<img src="/mm/common/images/btn_cnext_off.gif" width="80" height="30"/>
					</div>
				</td>
				
				<td valign="top">
				
					<!-- 팀관리 3번 조회 목록 -->
					<table id="deptTable3" name="deptTable3" class="table table-bordered" style="display: none;">
						<thead>
							<tr class="table-primary">
								<th scope="col" style="color: #848484; text-align: center;">부서명</th>
							</tr>
						</thead>
						<c:if test="${lDept.size() != 0 }">
							<c:forEach var="item" items="${lDept }">
								<c:if test="${item.i_step eq '3' }">
									<tr id="deptTR3" name="deptTR3" style="display:none;">
										<td id="teamSuDeptName3" name="teamSuDeptName3" style="cursor: pointer;" onclick="dept_3('${item.i_seq_pk }')">${item.v_dept_name_k }</td>
										<td style="display: none;">
											<input type="hidden" id="clickDeptSeq3" name="clickDeptSeq3" value="${item.i_seq_pk }"/>
											<input type="hidden" id="clickUpDeptSeq3" name="clickUpDeptSeq3" value="${item.i_dept_up }"/>
											<input type="hidden" id="clickSortDeptSeq3" name="clickSortDeptSeq3" value="${item.i_sort }"/>
											<input type="hidden" id="clickStepDeptSeq3" name="clickStepDeptSeq3" value="${item.i_step }"/>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</table>
				
				</td>
				
				<td>
					<div id="cusor3" name="cusor3" class="text-left" style="height: 70px; margin-top: 10px; margin-left: 10px; display: none;">
						<img src="/mm/common/images/btn_cnext_off.gif" width="80" height="30"/>
					</div>
				</td>
				
				<td valign="top">
				
					<!-- 팀관리 4번 조회 목록 -->
					<table id="deptTable4" name="deptTable4"  class="table table-bordered" style="display: none;">
						<thead>
							<tr class="table-primary">
								<th scope="col" style="color: #848484; text-align: center;">부서명</th>
							</tr>
						</thead>
						<c:if test="${lDept.size() != 0 }">
							<c:forEach var="item" items="${lDept }">
								<c:if test="${item.i_step eq '4' }">
									<tr id="deptTR4" name="deptTR4" style="display:none;">
										<td id="teamSuDeptName4" name="teamSuDeptName4" style="cursor: pointer;" onclick="dept_4('${item.i_seq_pk }')">${item.v_dept_name_k }</td>
										<td style="display: none;">
											<input type="hidden" id="clickDeptSeq4" name="clickDeptSeq4" value="${item.i_seq_pk }"/>
											<input type="hidden" id="clickUpDeptSeq4" name="clickUpDeptSeq4" value="${item.i_dept_up }"/>
											<input type="hidden" id="clickSortDeptSeq4" name="clickSortDeptSeq4" value="${item.i_sort }"/>
											<input type="hidden" id="clickStepDeptSeq4" name="clickStepDeptSeq4" value="${item.i_step }"/>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</table>
				
				</td>
			</tr>
		</table>
	
	</form>
</body>
</html>