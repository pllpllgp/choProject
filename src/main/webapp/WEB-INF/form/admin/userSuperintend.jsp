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
	
	$("#search_user_seq").select2();
	
	//직원 조회
	$("#btn_search").click(function() {
		
		$("#urlPage").val("userSuperintend");
		$("#methodType").val("normal");
		
		doSubmit();
	});
	
	
	//직원 추가
	$("#userAdd").click(function() {
		
		var mytable = document.getElementById('userInserEdit');
		
		document.getElementById("userAddTable").style.display = "block";
		
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
		cell5 = row.insertCell(4);

		cell1.innerHTML = "<td><input type='text' id='addUserId' name='addUserId'/></td>";
		cell2.innerHTML = "<td><input type='text' id='addUserMail' name='addUserMail'/></td>";
		cell3.innerHTML = "<td><input type='text' id='addUserName' name='addUserName'/></td>";
		cell4.innerHTML = "<td><input type='text' id='addUserNum' name='addUserNum'/></td>";
		cell5.innerHTML = "<td><input type='checkbox' id='userAuthYN' name='userAuthYN' />     check(Y)</td>";
		
		$("#userState").val("userAdd");
	});
	
	
	//직원 수정
	$("#userEdit").click(function() {
		
		var userSeq = "";
		var userid = "";
		var userNum = "";
		var userName = "";
		var userMail = "";
		var userAuthYN = "";
		var choice = 0;
		
		var mytable = document.getElementById('userInserEdit');
		
		document.getElementById("userAddTable").style.display = "block";
		
		if(mytable.rows.length > 1){
			for(var i = 1; mytable.rows.length != i; i){
				
				mytable.deleteRow(1);
			}
		}
		
		$("[name='checkUser']").each(function(){
			
			if($(this).is(":checked")){
				
				document.getElementById("userAddTable").style.display = "block";
				//index 찾기
				projectIndex = $(this).closest('tr').index();
				
				userSeq = $(this).val();
				userid = $(this).closest('tr').find('[name="userID"]').text();
				userMail = $(this).closest('tr').find('[name="userMail"]').text();
				userName = $(this).closest('tr').find('[name="userName"]').text();
				userNum = $(this).closest('tr').find('[name="userNum"]').text();
				userAuthYN = $(this).closest('tr').find('[name="userAuthYN"]').text();
				
				choice ++;
			}
		});
		
		if(choice == 0) {
				
				document.getElementById("userAddTable").style.display = "none";
			alert("수정할 유저를 선택해 주세요.");
		} else {
			
			row = mytable.insertRow(mytable.rows.length);
			
			cell1 = row.insertCell(0);
			cell2 = row.insertCell(1);
			cell3 = row.insertCell(2);
			cell4 = row.insertCell(3);
			cell5 = row.insertCell(4);
			
			cell1.innerHTML = "<td><input type='hidden'	id='addUserSeq'	name='addUserSeq' value='" + userSeq + "' /><input type='text' id='addUserId' name='addUserId' value='" + userid + "'/></td>";
			cell2.innerHTML = "<td><input type='text' id='addUserMail' name='addUserMail' value='" + userMail + "'/></td>";
			cell3.innerHTML = "<td><input type='text' id='addUserName' name='addUserName' value='" + userName + "'/></td>";
			cell4.innerHTML = "<td><input type='text' id='addUserNum' name='addUserNum' value='" + userNum + "''/></td>";
			if(userAuthYN == "Y") {
				cell5.innerHTML = "<td><input type='checkbox' id='userAuthYN' name='userAuthYN' checked='checked' />     check(Y)</td>";
			} else {
				cell5.innerHTML = "<td><input type='checkbox' id='userAuthYN' name='userAuthYN' />     check(Y)</td>";	
			}
			
			$("#userState").val("userEdit");
		}
	});
	
	
	//프로젝트 추가/수정 취소
	$("#btn_delete").click(function() {
		
		document.getElementById("userAddTable").style.display = "block";
		var mytable = document.getElementById('userInserEdit');
			
		if(mytable.rows.length > 1){
			for(var i = 1; mytable.rows.length != i; i){
				
				mytable.deleteRow(1);
			}
		}

		document.getElementById("userAddTable").style.display = "none";
	});
	
	
	//직원 추가/수정 저장
	$("#btn_save").click(function() {
		
		$("#urlPage").val("userSuperintend");
		$("#methodType").val("save");
		
		if($("#userAuthYN").is(":checked")){
			$("#adduserAuthYN").val("Y");
		} else {
			$("#adduserAuthYN").val("N");
		}
		
		if($("#addUserId").val() == "" || $("#addUserMail").val() == "" || $("#addUserName").val() == "" || $("#addUserNum").val() == "") {
			
			alert("칸을 전부 입력해 주세요.");
		} else {
			
			doSubmit();
		}
		
		
	});
	
	
	//팀별 입력 현황 엑셀 다운로드
	$("#btn_download").click(function() {
		
		var adminTeamMMSeq = ""
		
		$("[name='i_mm_seq_pk']").each(function(){
				
			if($(this).is(":checked")){
				adminTeamMMSeq += $(this).val() + ","
				$("#adminTeamMMSEQ").val(adminTeamMMSeq);
			}
			
		});

		$("#urlPage").val("userSuperintend");
		$("#methodType").val("excel");
		doSubmit();
	});
	
//$(function(){}) 종료 
})
	
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
	<input type="hidden"				id="userDeptAuth" 			name="userDeptAuth" 		value="${userBean.userDeptAuth }" />
	<input type="hidden"				id="adduserAuthYN" 			name="adduserAuthYN" 		value="" />
	<input type="hidden"				id="userState" 				name="userState" 			value="" />

	<jsp:include page="/WEB-INF/form/top.jsp"></jsp:include>
	
	<div class="mm-menu-name"><h5>관리자 M/M (직원 관리)</h5></div>
	
	<table class="mm-search">
		<tr>
			<th class="text-muted" style="width:50px; text-align: left;">성명</th>
			<td>
				<select id="search_user_seq" name="search_user_seq" style="width:180px;" class="form-control">
					<option value="">성명</option>
					<c:forEach var='item' items="${getUserBean }">
						<option value="${item.userSEQ}" ${item.userSEQ == searchBean.search_user_seq ? "selected='selected'" : ""}>${item.userName }</option>
					</c:forEach>
				</select>
			</td>
			<th class="text-muted" style="width:100px; text-align: center;">재직 유무</th>
			<td>
				<select id="search_use" name="search_use" class="form-control">
					<option value="" ${"" == searchBean.search_disable ? "selected='selected'" : ""}>모두</option>
					<option value="Y" ${"Y" == searchBean.search_disable ? "selected='selected'" : ""}>재직</option>
					<option value="N" ${"N" == searchBean.search_disable ? "selected='selected'" : ""}>퇴사</option>
				</select>
			</td>
			<td class="text-muted" style="width:60px; text-align: right;">
				<button type="button" id="btn_search" name="btn_search" class="btn btn-secondary btn-sm">조회</button>
			</td>
		</tr>
	</table>
	
	<table class="mm-search">
		<tr>
			<td colspan="5" style="margin-top:10px;">
				<button type="button" id="btn_download" name="btn_download" class="btn btn-outline-primary">Excel 다운로드</button>
				<button type="button" id="userAdd" name="userAdd" class="btn btn-outline-primary">추가</button>
				<button type="button" id="userEdit" name="userEdit" class="btn btn-outline-primary">수정</button>
			</td>
		</tr>
	</table>
	
	
	<!-- 직원 추가 테이블 -->
	<table id="userAddTable" name="userAddTable" style="display:none;  margin-right:15px">
		<tr>
			<td style="border-bottom-width: 0px; padding-bottom: 0px;">
				<table id="userInserEdit" name="userInserEdit" class="table table-bordered">
					<thead>
						<tr class="table-primary">
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">아이디</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">이메일</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">이름</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">사원번호</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">관리자 유무</th>
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
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">선택</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">아이디</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">이메일</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">이름</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">사원번호</th>
							<th scope="col" style="color: #050505; text-align: center; font-size: 14px;">관리자 유무</th>
						</tr>
					</thead>
					<c:if test="${getUserBean.size() != 0 }">
						<c:forEach var="item" items="${getUserBean }">
							<tr>
								<td style="text-align: center; font-size: 14px;"><input type="radio" id="checkUser" name="checkUser" value="${item.userSEQ }"/></td>
								<td id="userID" name="userID" style="font-size: 14px;">${item.userID }</td>
								<td id="userMail" name="userMail" style="font-size: 14px;">${item.userMail }</td>
								<td id="userName" name="userName" style="font-size: 14px;">${item.userName }</td>
								<td id="userNum" name="userNum" style="font-size: 14px;">${item.userNum }</td>
								<td id="userAuthYN" name="userAuthYN" style="font-size: 14px;">${item.userAuthYN }</td>
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