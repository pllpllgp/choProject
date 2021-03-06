<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="/mm/common/css/bootstrap.min.css" />
<link rel="stylesheet" href="/mm/common/css/common.css" />
<link rel="stylesheet" href="/mm/common/css/select2.css" />
<script type="text/javascript" src="/mm/common/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="https://unpkg.com/popper.js@1.14.7/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="/mm/common/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/mm/common/js/common.js"></script>
<script type="text/javascript" src="/mm/common/js/select2.js"></script>
<script>
$(function() {
	
	$("#i_project_code").select2();
	
	//M/M 입력
	$("#btn_check").click(function() {
		
		if($("#i_project_code").val() == ""){
			alert("프로젝트를 선택해주세요");
			return;
		}
		
		var target = document.getElementById("i_project_code");
		var projectName = target.options[target.selectedIndex].text;
		var projectNumber = target.options[target.selectedIndex].value;
		
		mytable = document.getElementById('project_code_table');
		row = mytable.insertRow(mytable.rows.length);
		
		cell1 = row.insertCell(0);
		cell2 = row.insertCell(1);
		cell3 = row.insertCell(2);
		cell4 = row.insertCell(3);

		cell1.innerHTML = "<td><input type='checkbox' id='code_check' name='code_check' value='" + projectNumber + "' /></td>";
		cell2.innerHTML = "<td><input type='text' id='code_name' name='code_name' value='" + projectName + "' size='45' readonly style='border:0;' /></td>";
		cell3.innerHTML = "<td><input type='text' id='code_mm' name='code_mm' size='5' /></td>";
		cell4.innerHTML = "<td><input type='text' id='code_number' name='code_number' value='" + projectNumber + "' style='display:none;' /></td>";
		
	});
	
	
	//M/M 중간 저장
	$("#btn_save").click(function(){
		
		var projectSEQ = "";
		var projectMM = "";
		var mmMax = 0;
		var mmNum = 0;
		
		$("#urlPage").val("userMM");
		$("#methodType").val("save");
		
		$("[name='code_mm']").each(function(){
			
			if($(this).val() == ""){
				alert("프로젝트 명 또는 투입 M/M을 입력 안했습니다.");
				mmMax = 1;
			}
			
			mmNum = parseFloat(mmNum) + parseFloat($(this).val());
			
			if(mmNum > $("#userMM").val()){
				alert("입력 M/M이 당월 M/M보다 많습니다.");
				mmMax = 1;
			} else {
				projectMM += $(this).val() + ",";
			}
		});
		
		if(mmMax == 0) {
		
			$("[name='code_number']").each(function(){
				
				projectSEQ += $(this).val() + ",";
				
			});
			
			if(projectSEQ == ""){
				
				alert("M/M을 입력 후 저장해주세요");
				mmMax = 1;
			}
			
			if(mmMax == 0) {
				
				opener.userMMSave(projectSEQ, projectMM);
				window.close();
			}
		}
		
	});
	
	
	//M/M 입력한 데이터 삭제
	$("#btn_delete").click(function(){
		
		var table = document.getElementById("project_code_table");
		
		$("#urlPage").val("userMM");
		$("#methodType").val("delete");
		
		var tableRow = 1;
		
		$("[name='code_check']").each(function(){
			
			if($(this).is(":checked")){
				table.deleteRow(tableRow);
			} else {
				tableRow++
			}
			
		});
	});
	
//$(function(){}) 종료		
})

</script>
</head>
<body>
<form id="userInfo" name="userInfo" method="post">
	<input type="hidden"				id="urlPage" 				name="urlPage" 				value=""/>
	<input type="hidden"				id="methodType" 			name="methodType" 			value=""/>
	<input type="hidden"				id="search_date"			name="search_date"			value="${search_date }"/>
	<input type="hidden"				id="userSEQ" 				name="userSEQ" 				value="${userSEQ }"/>
	<input type="hidden"				id="userMM" 				name="userMM" 				value="${userMM }"/>
	<input type="hidden"				id="project_SEQ" 			name="project_SEQ" 			value=""/>
	
	<c:if test="${lUserDefaultMM.size() != 0 }">
		<c:forEach var='item' items="${lUserDefaultMM }" begin="0" end="0">
			<input type="hidden"				id="i_mm_seq_pk" 			name="i_mm_seq_pk" 			value="${item.i_seq_pk }"/>
		</c:forEach>
	</c:if>
	
	<table class="table table-borderless" style="text-align: center; margin-left: auto; margin-right: auto;">
		<tr id="project_table_clone">
			<td>
				<span>
					<select id="i_project_code" name="i_project_code" class="i_project_code">
						<option value="">프로젝트 명</option>
						<c:if test="${lProjectCode.size() != 0 }">
							<c:forEach var='item' items="${lProjectCode }">
								<option value="${item.i_seq_pk }">${item.v_project_name }</option>
							</c:forEach>
						</c:if>
					</select>			
				</span>
				<input type="button" class="btn btn-primary btn-sm" id="btn_check" name="btn_check" value="확인" style="width:60px; align: left;" />	
			</td>
		</tr>
	</table>
	
	
	<table id="project_code_table" name="project_code_table" style="text-align: center; margin-left: auto; margin-right: auto; border:1px solid #444444;">
		<thead>
			<tr class="table-primary">
				<th scope="col" style="color: #050505; width:70px; font-size: 14px;">선택</th>
				<th scope="col" style="color: #050505; width:400px; font-size: 14px;">프로젝트 명</th>
				<th scope="col" style="color: #050505; width:100px; font-size: 14px;">투입 M/M</th>
			</tr>
		</thead>
		<c:forEach var='item' items="${lUserDefaultMM }">
			<c:if test="${item.v_project_name ne null }">
				<tr id="trName" name="trName">
					<td><input type='checkbox' id='code_check' name='code_check' value="${item.i_project_code_pk }" style="font-size: 14px;" /></td>
					<td><input type="text" id="code_name" name="code_name" value="${item.v_project_name }" size="45" readonly style="border: 0; font-size: 14px;" /></td>
					<td><input type="text" id="code_mm" name="code_mm" value="${item.d_mm_user }" size="5" readonly style="border: 0; font-size: 14px;" /></td>
					<td><input type='text' id='code_number' name='code_number' value="${item.i_project_code_pk }" style='display: none; font-size: 14px;' /></td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
	
	
	<table style="margin-left: auto; margin-right: auto;">
		<tr>
			<th>
				<input type="button" class="btn btn-primary btn-sm" id="btn_save" name="btn_save" value="저장" style="width:60px; align: right; font-size: 14px;" />
			</th>
			<th>
				<input type="button" class="btn btn-primary btn-sm" id="btn_delete" name="btn_delete" value="삭제" style="width:60px; align: right; font-size: 14px;" />
			</th>
		</tr>
	</table>
</form>
</body>
</html>