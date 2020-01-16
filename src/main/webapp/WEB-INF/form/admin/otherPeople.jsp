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
	
	//조회
	$("#btn_search").click(function() {

		$("#urlPage").val("otherPeople");
		$("#methodType").val("search");
		
		if($("#search_date option:selected").val() == "") {
			alert("작업월을 선택해 주세요.");
		
		} else {
			doSubmit();
			
		}
	});
	
	
	//타인입력 추가
	$("#btn_add").click(function() {
		
		$("#peopleState").val("add");
		
		document.getElementById("PeopleAddTable").style.display = "block";
		
		var mytable = document.getElementById('peopleInserEdit');
		
		if(mytable.rows.length > 2){
			for(var i = 2; mytable.rows.length != i; i){
					
				mytable.deleteRow(2);
			}
		}
		
		row = mytable.insertRow(mytable.rows.length);
		
		cell1 = row.insertCell(0);
		cell2 = row.insertCell(1);
		cell3 = row.insertCell(2);
		cell4 = row.insertCell(3);
		cell5 = row.insertCell(4);

		cell1.innerHTML = "<td><select id='addPeopleDate' name='addPeopleDate' class='form-control'><option value=''>작업월</option><c:forEach var='item' items='${lMonth }'><option value='${item }'>${item }</option></c:forEach></select></td>";
		cell2.innerHTML = "<td><input type='text' id='addPeopleNum' name='addPeopleNum' readonly style='border: 0; text-align: center;'/></td>";
		cell3.innerHTML = "<td><select id='addPeopleName' name='addPeopleName' onchange='changeUser()'><c:forEach var='item' items='${lUser }'><option value='${item.userSEQ }'>${item.userName }</option></c:forEach></select></td>";
		cell4.innerHTML = "<td><input type='text' id='addOtherPeopleNum' name='addOtherPeopleNum' readonly style='border: 0; text-align: center;'/></td>";
		cell5.innerHTML = "<td><select id='addOtherPeopleName' name='addOtherPeopleName' onchange='changeOtherUser()'/><c:forEach var='item' items='${lUser }'><option value='${item.userSEQ }'>${item.userName }</option></c:forEach></select></td>";
		
		$("#addPeopleName").select2();
		$("#addOtherPeopleName").select2();
		
	});
	
	
	//타인입력 수정
	$("#btn_edit").click(function() {
		
		var peopleSeq = "";
		var otherPeopleSeq = "";
		var addPeopleSeq = "";
		var addPeopleNum = "";
		var addPeopleName = "";
		var otheraddPeopleSeq = "";
		var otheraddPeopleNum = "";
		var otheraddPeopleName = "";
		var choice = 0;

		$("#peopleState").val("edit");
		
		var mytable = document.getElementById('peopleInserEdit');
		
		if(mytable.rows.length > 2){
			for(var i = 2; mytable.rows.length != i; i){
				
				mytable.deleteRow(2);
			}
		}
		
		$("[name='checkPeople']").each(function(){
			
			if($(this).is(":checked")){
				document.getElementById("PeopleAddTable").style.display = "block";
				//index 찾기
				projectIndex = $(this).closest('tr').index();
				
				peopleSeq = $(this).val(); //타인 입력 SEQ
				otherPeopleSeq = $(this).closest('tr').find('[name="checkOtherPeople"]').val(); //타인 입력 지정자 SEQ
				addPeopleSeq = $(this).closest('tr').find('[name="peopleSe"]').text(); //M/M 유저 SEQ
				addPeopleNum = $(this).closest('tr').find('[name="peopleNu"]').text(); //M/M 유저 사번
				addPeopleName = $(this).closest('tr').find('[name="peopleNm"]').text(); //M/M 유저 이름
				otheraddPeopleSeq = $(this).closest('tr').find('[name="otherPeopleSe"]').text(); //M/M 유저 SEQ(타인입력 지정자)
				otheraddPeopleNum = $(this).closest('tr').find('[name="otherPeopleNu"]').text(); //M/M 유저 사번(타인입력 지정자)
				otheraddPeopleName = $(this).closest('tr').find('[name="otherPeopleNa"]').text(); //M/M 유저 이름(타인입력 지정자)
				
				choice ++;
				
			}
			
		});
		
		if(choice == 0) {
			
			document.getElementById("PeopleAddTable").style.display = "none";
			alert("수정할 대상 및 대리자 입력 지정자를 선택해 주세요.");
		} else if(choice > 1) {
			
			document.getElementById("PeopleAddTable").style.display = "none";
			alert("수정할 대상 및 대리자 입력 지정자를 하나만 선택해주세요.");
		} else {
			
			row = mytable.insertRow(mytable.rows.length);
			
			cell1 = row.insertCell(0);
			cell2 = row.insertCell(1);
			cell3 = row.insertCell(2);
			cell4 = row.insertCell(3);
			cell5 = row.insertCell(4);

			cell1.innerHTML = "<td><input type='text' id='addPeopleDate' name='addPeopleDate' value='${searchBean.search_date}' readonly style='text-align:center; border: 0;'/></td>";
			cell2.innerHTML = "<td><input type='text' id='addPeopleNum' name='addPeopleNum' value='" + addPeopleNum + "' readonly style='border: 0; text-align: center;'/></td>";
			cell3.innerHTML = "<td><select id='addPeopleName' name='addPeopleName' onchange='changeUser()'><c:forEach var='item' items='${lUser }'><option value='${item.userSEQ }'>${item.userName }</option></c:forEach></select></td>";
			cell4.innerHTML = "<td><input type='text' id='addOtherPeopleNum' name='addOtherPeopleNum' value='" + otheraddPeopleNum + "' readonly style='border: 0; text-align: center;'/></td>";
			cell5.innerHTML = "<td><select id='addOtherPeopleName' name='addOtherPeopleName' onchange='changeOtherUser()'/><c:forEach var='item' items='${lUser }'><option value='${item.userSEQ }'>${item.userName }</option></c:forEach></select></td>";
			
			$("#addPeopleName").val(addPeopleSeq);
			$("#addOtherPeopleName").val(otheraddPeopleSeq);
			
			$("#peopleSeq").val(peopleSeq);
			$("#addPeopleSeq").val(addPeopleSeq);
			$("#otherPeopleSeq").val(otherPeopleSeq);
			$("#addOtherPeopleSeq").val(otheraddPeopleSeq);
			
			$("#addPeopleName").select2();
			$("#addOtherPeopleName").select2();
		}
	});
	
	
	//타인입력 추가/수정 취소
	$("#btn_cancle").click(function() {
		
		var mytable = document.getElementById('peopleInserEdit');
			
		if(mytable.rows.length > 2){
			for(var i = 2; mytable.rows.length != i; i){
				
				mytable.deleteRow(2);
			}
		}

		document.getElementById("PeopleAddTable").style.display = "none";
		
	});
	
	
	//타인입력 추가/수정 저장
	$("#btn_save").click(function() {
		
		$("#urlPage").val("otherPeople");
		$("#methodType").val("save");
		
		doSubmit();
		
	});
	
	
	//타인입력 제거
	$("#btn_delete").click(function() {
		
		var otherSeqArray = "";
		var choice = 0;
		
		$("[name='checkPeople']").each(function(){
			
			if($(this).is(":checked")){
				
				otherSeqArray += $(this).val() + ",";
				choice ++;
			} 
		});
		
		if(choice == 0) {
			
			alert("제거할 대상 및 대리 입력 지정자를 선택해 주세요.");
		} else {
			
			if(false!=confirm("선택한 대상 및 대리 입력 지정자를 제거하시겠습니까?")){

				$("#urlPage").val("otherPeople");
				$("#methodType").val("delete");
				$("#otherSeq").val(otherSeqArray);
				doSubmit();
			}
		}
	});
	
	
	//다음달 프로젝트 데이터 입력
	$("#btn_prev_month").click(function() {
					
		$("#urlPage").val("otherPeople");
		$("#methodType").val("addPrev");
		
		if(false!=confirm($("#prev_month").val() + " 데이터가 " 
				+ $("#default_month").val() + " 데이터로 저장됩니다.\r\n"
				+ "기존에 저장된 " + $("#default_month").val() + " 데이터는 삭제 됩니다.\r\n"
				+ "저장 하시겠습니까?")){
			
			doSubmit();
		}
	});
	
//$(function(){}) 종료
})


//타인입력 추가/수정 행 제거
function addPeopleDelete(num){
		
	var tableRow = num.parentElement.parentElement.rowIndex;
	
	var mytable = document.getElementById('peopleInserEdit');
			
	mytable.deleteRow(tableRow);
	
	if(mytable.rows.length == 2){
			
		document.getElementById("PeopleAddTable").style.display = "none";
	}
	
}


//추가/수정시 유저 선택 변경
function changeUser(){

	$("[name='addPeopleName']").each(function(){
		
		$("#peopleNumber").val($(this).val());
		$(this).closest('tr').find('[name="addPeopleNum"]').val($("#peopleNumber option:selected").text());
		
		$("#addPeopleSeq").val($("#peopleNumber option:selected").val());
	});
	
}

//추가/수정시 다른 유저 선택 변경
function changeOtherUser(){

	$("[name='addOtherPeopleName']").each(function(){
		
		$("#peopleNumber").val($(this).val());
		$(this).closest('tr').find('[name="addOtherPeopleNum"]').val($("#peopleNumber option:selected").text());
		
		$("#addOtherPeopleSeq").val($("#peopleNumber option:selected").val());
	});
	
}


//프로젝트 전체 선택
function allOther(){

	if($("#allCheckOther").is(":checked")){
		
		$("[name='checkPeople']").each(function(){
			
			$(this)[0].checked = true;
		});
	} else {
		
		$("[name='checkPeople']").each(function(){
			
			$(this)[0].checked = false;
		});
	}
}	

</script>
</head>
<body>
<form id="userInfo" name="userInfo" method="post" style="width:1600px; margin:auto; margin-top:50px;">
	<input type="hidden"				id="urlPage" 				name="urlPage" 				value="${urlPage }" />
	<input type="hidden"				id="methodType" 			name="methodType" 			value="" />
	<input type="hidden"				id="userSEQ"				name="userSEQ" 				value="${userBean.userSEQ } "/>
	<input type="hidden"				id="userID"					name="userID"				value="${userBean.userID }" />
	<input type="hidden"				id="userName" 				name="userName" 			value="${userBean.userName }" />
	<input type="hidden"				id="userMail" 				name="userMail" 			value="${userBean.userMail }" />
	<input type="hidden"				id="userNum" 				name="userNum" 				value="${userBean.userNum }" />
	<input type="hidden"				id="userAuth" 				name="userAuth" 			value="${userBean.userAuth }" />
	<input type="hidden"				id="userDeptAuth" 			name="userDeptAuth" 		value="${userBean.userDeptAuth }"/>
	<input type="hidden"				id="peopleState" 			name="peopleState" 			value="" />
	<input type="hidden"				id="peopleSeq" 				name="peopleSeq" 			value="" />
	<input type="hidden"				id="otherPeopleSeq" 		name="otherPeopleSeq" 		value="" />
	<input type="hidden"				id="addPeopleSeq" 			name="addPeopleSeq" 		value="" />
	<input type="hidden"				id="addOtherPeopleSeq" 		name="addOtherPeopleSeq" 	value="" />
	<input type="hidden"				id="otherSeq" 				name="otherSeq" 			value="" />

	<jsp:include page="/WEB-INF/form/top.jsp"></jsp:include>
	
	<div class="mm-menu-name"><h5>관리자 M/M (대리 입력 지정)</h5></div>
	
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
			<td class="text-muted" style="width:60px; text-align: right;">
				<button type="button" class="btn btn-secondary btn-sm" id="btn_search" name="btn_search">조회</button>
			</td>
		</tr>
	</table>
	
	<table class="mm-search">
		<tr>
			<td style="margin-top:10px;">
				<c:forEach var='item' items="${lMonth }" begin="1" end="1">
					<button type="button" id="btn_prev_month" name="btn_prev_month" class="btn btn-outline-primary">${item } 데이터 가져오기</button>
					<input type="hidden" name="prev_month" id="prev_month" value="${item}"/>
				</c:forEach>
				<c:forEach var='item' items="${lMonth }" begin="0" end="0">
					<input type="hidden" id="default_month" name="default_month" value="${item}"/>
				</c:forEach>
				<button type="button" class="btn btn-outline-primary" id="btn_add" name="btn_add">추가</button>
				<button type="button" class="btn btn-outline-primary" id="btn_edit" name="btn_edit">수정</button>
				<button type="button" class="btn btn-outline-primary" id="btn_delete" name="btn_delete">제거</button>
			</td>
		</tr>
	</table>
	
	
	<!-- 타인 추가/수정 테이블 -->
	<table id="PeopleAddTable" name="PeopleAddTable" style="display:none; margin-right:15px">
		<tr>
			<td style="border-bottom-width: 0px; padding-bottom: 0px;">
				<table id="peopleInserEdit" name="peopleInserEdit" class="table table-bordered">
					<thead>
						<tr class="table-primary">
							<th rowspan="2" scope="col" style="color: #050505; text-align:center; vertical-align:middle; width: 200px; font-size: 14px;">작업 년도</th>
							<th colspan="2" scope="col" style="color: #050505; text-align:center; font-size: 14px;">대리</th>
							<th colspan="2" scope="col" style="color: #050505; text-align:center; font-size: 14px;">대리 입력 지정자</th>
						</tr>
						<tr class="table-primary">
							<th scope="col" style="color: #050505; text-align:center; font-size: 14px;">사번</th>
							<th scope="col" style="color: #050505; text-align:center; font-size: 14px;">성명</th>
							<th scope="col" style="color: #050505; text-align:center; font-size: 14px;">사번</th>
							<th scope="col" style="color: #050505; text-align:center; font-size: 14px;">성명</th>
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
							<input type="button" id="btn_cancle" name="btn_cancle" class="btn btn-primary btn-sm" value="취소" style="width:60px;" />
						</th>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	
	<!-- 조회 테이블 -->
	<table class="table" style="width: 750px; margin-left: 5px">
		<tr>
			<td>
				<table class="table table-bordered">
					<thead>
						<tr class="table-primary">
							<th rowspan="2" scope="col" width=90px style="color: #050505; text-align:center; vertical-align:middle; font-size: 14px;"><input type="checkbox" id="allCheckOther" name="allCheckOther" onclick="allOther()"/>  선택</th>
							<th rowspan="2" scope="col" width=100px style="color: #050505; text-align:center; vertical-align:middle; font-size: 14px;">작업 년도</th>
							<th colspan="2" scope="col" style="color: #050505; text-align:center; font-size: 14px;">대상자</th>
							<th colspan="2" scope="col" style="color: #050505; text-align:center; font-size: 14px;">대리 입력 지정자</th>
						</tr>
						<tr class="table-primary">
							<th scope="col" style="color: #050505; text-align:center; font-size: 14px;">사번</th>
							<th scope="col" style="color: #050505; text-align:center; font-size: 14px;">성명</th>
							<th scope="col" style="color: #050505; text-align:center; font-size: 14px;">사번</th>
							<th scope="col" style="color: #050505; text-align:center; font-size: 14px;">성명</th>
						</tr>
					</thead>
					<c:if test="${lOtherPeople.size() != 0 }">
						<c:forEach var='item' items="${lOtherPeople }">
							<tr>
								<td style="text-align:center; font-size: 14px;">
									<input type="checkbox" id="checkPeople" name="checkPeople" value="${item.i_seq_pk }"/>
									<input type="hidden" id="checkOtherPeople" name="checkOtherPeople" value="${item.i_to_seq_pk }"/>	
								</td>
								<td style="text-align:center; font-size: 14px;">${item.d_job_date }</td>
								<td id="peopleSe" name="peopleSe" style="display:none; ">${item.i_user_number }</td>
								<td id="peopleNu" name="peopleNu" style="font-size: 14px;">${item.v_man_seq }</td>
								<td id="peopleNa" name="peopleNa" style="font-size: 14px;">${item.v_user_name_k }</td>
								<td id="otherPeopleSe" name="otherPeopleSe" style="display:none; ">${item.i_to_user_number }</td>
								<td id="otherPeopleNu" name="otherPeopleNu" style="font-size: 14px;">${item.v_to_man_seq }</td>
								<td id="otherPeopleNa" name="otherPeopleNa" style="font-size: 14px;">${item.v_to_user_name_k }</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</td>
		</tr>
	</table>
	
	
	<!-- 유저 사번/seq -->
	<table style="display:none; ">
		<tr>
			<td>
				<select id="peopleNumber" name="peopleNumber">
					<c:forEach var='item' items="${lUser }">
						<option value="${item.userSEQ }">${item.userNum }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
	</table>

</form>
</body>
</html>