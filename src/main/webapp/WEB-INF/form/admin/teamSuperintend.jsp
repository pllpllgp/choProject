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
	
	//팀 추가
	$("#team_add").click(function() {

		var mytable = document.getElementById('deptInserEdit');
		
		document.getElementById("deptAddTable").style.display = "block";
		
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

		cell1.innerHTML = "<td><input type='text' id='DeptSortNameAE' name='DeptSortNameAE'/></td>";
		cell2.innerHTML = "<td><input type='text' id='DeptNameAE' name='DeptNameAE'/></td>";
		cell3.innerHTML = "<td><select id='DeptUpNameAE' name='DeptUpNameAE'><c:forEach var='item' items='${lDept }'><c:if test='${item.v_up_dept_name_k eq null }'><option value='${item.i_seq_pk }'>${item.v_dept_name_k }</option></c:if><c:if test='${item.v_up_dept_name_k ne null }'><option value='${item.i_seq_pk }'>${item.v_up_dept_name_k } / ${item.v_dept_name_k }</option></c:if></c:forEach></select></td>";
		cell4.innerHTML = "<td><input type='text' id='DeptCountAE' name='DeptCountAE'/></td>";
		
		document.getElementById("btn_delete").style.display = "none";
		
		$("#DeptUpNameAE").select2();
		$("#teamState").val("teamAdd");
	});
	
	
	//팀 추가/수정 취소
	$("#btn_cancle").click(function() {
		
		document.getElementById("deptTable2").style.display = "none";
		document.getElementById("deptTable3").style.display = "none";
		document.getElementById("deptTable4").style.display = "none";
		document.getElementById("cusor1").style.display = "none";
		document.getElementById("cusor2").style.display = "none";
		document.getElementById("cusor3").style.display = "none";

		document.getElementById("deptAddTable").style.display = "none";
	});
	
	
	//팀 추가/수정 저장
	$("#btn_save").click(function() {
		
		$("#urlPage").val("teamSuperintend");
		$("#methodType").val("save");
		
		if($("#DeptSortNameAE").val() == "" || $("#DeptNameAE").val() == "" || $("#DeptCountAE").val() == "") {
			
			alert("빈칸을 모두 채워주세요.");
		} else {
			
			doSubmit();
		}
		
		
	});
	
	
	//팀 추가/수정 삭제
	$("#btn_delete").click(function() {
		
		$("#urlPage").val("teamSuperintend");
		$("#methodType").val("delete");

		if(confirm("팀을 삭제하시겠습니까?")) {
			doSubmit();
		}
	});
	
	
	//팀별 입력 현황 엑셀 다운로드
	$("#btn_download").click(function() {
		
		var adminTeamMMSeq = ""

		$("#urlPage").val("teamSuperintend");
		$("#methodType").val("excel");
		doSubmit();
		
	});
	
//$(function(){}) 종료	
})


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
	document.getElementById("btn_delete").style.display = "block";
	
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
	
	cell1.innerHTML = "<td><input type='hidden' id='editDeptSeq' name='editDeptSeq' value='" + deptSeq + "'/><input type='text' id='DeptSortNameAE' name='DeptSortNameAE' value='" + deptStep + "'/></td>";
	cell2.innerHTML = "<td><input type='text' id='DeptNameAE' name='DeptNameAE' value='" + deptName + "'/></td>";
	cell3.innerHTML = "<td><select id='DeptUpNameAE' name='DeptUpNameAE'><c:forEach var='item' items='${lDept }'><c:if test='${item.v_up_dept_name_k eq null }'><option value='${item.i_seq_pk }'>${item.v_dept_name_k }</option></c:if><c:if test='${item.v_up_dept_name_k ne null }'><option value='${item.i_seq_pk }'>${item.v_up_dept_name_k } / ${item.v_dept_name_k }</option></c:if></c:forEach></select></td>";
	cell4.innerHTML = "<td><input type='text' id='DeptCountAE' name='DeptCountAE' value='" + deptSort + "'/></td>";
	
	$("#DeptUpNameAE").val(deptUpSeq);
	$("#DeptUpNameAE").select2();
	$("#teamState").val("teamEdit");
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
	document.getElementById("btn_delete").style.display = "block";
	
	
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
	
	cell1.innerHTML = "<td><input type='hidden' id='editDeptSeq' name='editDeptSeq' value='" + deptSeq + "'/><input type='text' id='DeptSortNameAE' name='DeptSortNameAE' value='" + deptStep + "'/></td>";
	cell2.innerHTML = "<td><input type='text' id='DeptNameAE' name='DeptNameAE' value='" + deptName + "'/></td>";
	cell3.innerHTML = "<td><select id='DeptUpNameAE' name='DeptUpNameAE'><c:forEach var='item' items='${lDept }'><c:if test='${item.v_up_dept_name_k eq null }'><option value='${item.i_seq_pk }'>${item.v_dept_name_k }</option></c:if><c:if test='${item.v_up_dept_name_k ne null }'><option value='${item.i_seq_pk }'>${item.v_up_dept_name_k } / ${item.v_dept_name_k }</option></c:if></c:forEach></select></td>";
	cell4.innerHTML = "<td><input type='text' id='DeptCountAE' name='DeptCountAE' value='" + deptSort + "'/></td>";
	
	$("#DeptUpNameAE").val(deptUpSeq);
	$("#DeptUpNameAE").select2();
	$("#teamState").val("teamEdit");
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
	
	document.getElementById("btn_delete").style.display = "block";
	
	
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
	
	cell1.innerHTML = "<td><input type='hidden' id='editDeptSeq' name='editDeptSeq' value='" + deptSeq + "'/><input type='text' id='DeptSortNameAE' name='DeptSortNameAE' value='" + deptStep + "'/></td>";
	cell2.innerHTML = "<td><input type='text' id='DeptNameAE' name='DeptNameAE' value='" + deptName + "'/></td>";
	cell3.innerHTML = "<td><select id='DeptUpNameAE' name='DeptUpNameAE'><c:forEach var='item' items='${lDept }'><c:if test='${item.v_up_dept_name_k eq null }'><option value='${item.i_seq_pk }'>${item.v_dept_name_k }</option></c:if><c:if test='${item.v_up_dept_name_k ne null }'><option value='${item.i_seq_pk }'>${item.v_up_dept_name_k } / ${item.v_dept_name_k }</option></c:if></c:forEach></select></td>";
	cell4.innerHTML = "<td><input type='text' id='DeptCountAE' name='DeptCountAE' value='" + deptSort + "'/></td>";
	
	$("#DeptUpNameAE").val(deptUpSeq);
	$("#DeptUpNameAE").select2();
	$("#teamState").val("teamEdit");
}


//네번째 상위 조직 클릭
function dept_4(val) {
	
	//팀관리 추가 & 수정 테이블
	document.getElementById("deptAddTable").style.display = "block";
	document.getElementById("btn_delete").style.display = "block";
	
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
	
	cell1.innerHTML = "<td><input type='hidden' id='editDeptSeq' name='editDeptSeq' value='" + deptSeq + "'/><input type='text' id='DeptSortNameAE' name='DeptSortNameAE' value='" + deptStep + "'/></td>";
	cell2.innerHTML = "<td><input type='text' id='DeptNameAE' name='DeptNameAE' value='" + deptName + "'/></td>";
	cell3.innerHTML = "<td><select id='DeptUpNameAE' name='DeptUpNameAE'><c:forEach var='item' items='${lDept }'><c:if test='${item.v_up_dept_name_k eq null }'><option value='${item.i_seq_pk }'>${item.v_dept_name_k }</option></c:if><c:if test='${item.v_up_dept_name_k ne null }'><option value='${item.i_seq_pk }'>${item.v_up_dept_name_k } / ${item.v_dept_name_k }</option></c:if></c:forEach></select></td>";
	cell4.innerHTML = "<td><input type='text' id='DeptCountAE' name='DeptCountAE' value='" + deptSort + "'/></td>";
	
	$("#DeptUpNameAE").val(deptUpSeq);
	$("#DeptUpNameAE").select2();
	$("#teamState").val("teamEdit");
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
	<input type="hidden"				id="teamState" 				name="teamState" 			value="" />

	<jsp:include page="/WEB-INF/form/top.jsp"></jsp:include>
	
	<div class="mm-menu-name"><h5>관리자 M/M (팀관리)</h5></div>
	
	<table class="mm-search">
		<tr>
			<td style="margin-top:10px;">
				<button type="button" id="btn_download" name="btn_download" class="btn btn-outline-primary">Excel 다운로드</button>
				<button type="button" id="team_add" name="team_add" class="btn btn-outline-primary">추가</button>
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
							<th scope="col" style="color: #050505; text-align: center; width: 200px; font-size: 14px;">부서명규칙번호</th>
							<th scope="col" style="color: #050505; text-align: center; width: 200px; font-size: 14px;">부서명</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">상위부서</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">부서순서</th>
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
							<input type="button" id="btn_delete" name="btn_delete" class="btn btn-primary btn-sm" value="삭제" style="width:60px;" />
						</th>
						<th>
							<input type="button" id="btn_cancle" name="btn_cancle" class="btn btn-primary btn-sm" value="취소" style="width:60px;" />
						</th>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	
	<!-- 팀관리 조회 목록 -->
	<table style="margin-left: 5px; border: 1px solid; width: 1000px;">
		<tr>
			<td valign="top" style="width: 200px; padding-top: 20px; padding-bottom: 20px; padding-left: 30px;">
			
				<!-- 팀관리 1번 조회 목록 -->
				<table id="deptTable1" name="deptTable1" class="table table-bordered">
					<thead>
						<tr class="table-primary">
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">부서명</th>
						</tr>
					</thead>
					<c:if test="${lDept.size() != 0 }">
						<c:forEach var="item" items="${lDept }">
							<c:if test="${item.i_step eq '1' }">
								<tr id="deptTR1" name="deptTR1">
									<td id="teamSuDeptName1" name="teamSuDeptName1" style="cursor: pointer; font-size: 14px;" onclick="dept_1('${item.i_seq_pk }')">${item.v_dept_name_k }</td>
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
			
			<td style="width: 50px;">
				<img src="/common/images/btn_cnext_off.gif" id="cusor1" name="cusor1" width="50" height="30" style="display: none;"/>
			</td>
			
			<td valign="top" style="width: 200px; padding-top: 20px; padding-bottom: 20px;">
			
				<!-- 팀관리 2번 조회 목록 -->
				<table id="deptTable2" name="deptTable2" class="table table-bordered" style="display: none; width: 200px;">
					<thead>
						<tr class="table-primary">
							<th scope="col" style="color: #050505; text-align: center;  width: 200px; font-size: 14px;">부서명</th>
						</tr>
					</thead>
					<c:if test="${lDept.size() != 0 }">
						<c:forEach var="item" items="${lDept }">
							<c:if test="${item.i_step eq '2' }">
								<tr id="deptTR2" name="deptTR2" style="display:none;">
									<td id="teamSuDeptName2" name="teamSuDeptName2" style="cursor: pointer; font-size: 14px;" onclick="dept_2('${item.i_seq_pk }')">${item.v_dept_name_k }</td>
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
			
			<td style="width: 50px;">
				<img src="/common/images/btn_cnext_off.gif" id="cusor2" name="cusor2" width="50" height="30" style="display: none;"/>
			</td>
			
			<td valign="top" style="width: 200px; padding-top: 20px; padding-bottom: 20px;">
			
				<!-- 팀관리 3번 조회 목록 -->
				<table id="deptTable3" name="deptTable3" class="table table-bordered" style="display: none; width: 200px;">
					<thead>
						<tr class="table-primary">
							<th scope="col" style="color: #050505; text-align: center; width: 200px; font-size: 14px;">부서명</th>
						</tr>
					</thead>
					<c:if test="${lDept.size() != 0 }">
						<c:forEach var="item" items="${lDept }">
							<c:if test="${item.i_step eq '3' }">
								<tr id="deptTR3" name="deptTR3" style="display:none;">
									<td id="teamSuDeptName3" name="teamSuDeptName3" style="cursor: pointer; font-size: 14px;" onclick="dept_3('${item.i_seq_pk }')">${item.v_dept_name_k }</td>
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
			
			<td style="width: 50px;">
					<img src="/common/images/btn_cnext_off.gif" id="cusor3" name="cusor3" width="50" height="30" style="display: none;"/>
			</td>
			
			<td valign="top" style="width: 200px; padding-top: 20px; padding-bottom: 20px; padding-right: 30px;">
			
				<!-- 팀관리 4번 조회 목록 -->
				<table id="deptTable4" name="deptTable4"  class="table table-bordered" style="display: none; width: 200px;">
					<thead>
						<tr class="table-primary">
							<th scope="col" style="color: #050505; text-align: center; width: 200px;">부서명</th>
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