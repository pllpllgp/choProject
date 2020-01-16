<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Gravity M/M</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	
	$("#search_dept_seq").select2();
	$("#search_user_seq").select2();
	
	
	//팀별 입력 현황 조회
	$("#btn_search").click(function() {
		//formClear();
		if($("#search_date option:selected").val() == "") {
			
			alert("작업월을 선택해 주세요.");
			return;
		} else {

			$("#urlPage").val("adminTeam");
			$("#methodType").val("search");
			doSubmit();
		}
		
	});
	
	
	//팀별 입력 현황 입력 버튼
	$("#btn_insert").click(function(){
		
		var searchDate = $("#search_date").val();
		var userSeq = "";
		var userMM = "";
		var choice = 0;
		
		$("[name='i_mm_seq_pk']").each(function(){
			
			if($(this).is(":checked")){
				
				//index 찾기
				projectIndex = $(this).closest('tr').index();
				
				userSeq = $(this).closest('tr').find('[name="i_userSeq"]').val();
				userMM = $(this).closest('tr').find('[name="userMM"]').text();
				
				choice ++;
			}
		});
		
		if(choice == 0) {
				
			alert("입력할 MM을 선택해주세요.");
		} else if(choice == 1) {
		
			window.open("adminTeam.grv?methodType=write&search_date=" + searchDate +"&userSEQ=" + userSeq + "&userMM=" + userMM, "Team MM 작성","width=600,height=750,history=no,resizable=no,status=no,scrollbars=yes,menubar=no, resizable=no");
		}
	});
	
	
	//팀별 입력 현황 엑셀 다운로드
	$("#btn_download").click(function() {
		
		var adminTeamMMSeq = ""
		
		if($("#search_date").val() == "") {
			
			alert("작업월과 부서를 선택해 주세요.");
			
		} else {
			
			$("[name='i_mm_seq_pk']").each(function(){
				
				if($(this).is(":checked")){
					adminTeamMMSeq += $(this).val() + ","
					$("#adminTeamMMSEQ").val(adminTeamMMSeq);
				}
				
			});

			$("#urlPage").val("adminTeam");
			$("#methodType").val("excel");
			doSubmit();
			
		}
	});
	
})

//팀별 입력 현황 완료/미완료 클릭
function completeClick(disable) {
	
	var choice = 0;
	
	$("#urlPage").val("adminTeam");
	$("#methodType").val("completeYN");
	$("#disable").val(disable);
	
	$("[name='i_mm_seq_pk']").each(function(){
		
		if($(this).is(":checked")){
			
			//index 찾기
			projectIndex = $(this).closest('tr').index();
			
			$("#check_MM_seq").val($(this).val());
			
			choice ++;
		}
	});
	
	if(choice == 0) {
		
		if(disable == "Y") {
			
			alert("완료할 프로젝트를 선택해주세요.");	
		} else {
			
			alert("미완료할 프로젝트를 선택해주세요.");
		}
		
	} else if(choice == 1) {
	
		doSubmit();
	}
}


//MM입력 저장
function userMMSave(project_user_MM_SEQ, projectSEQ, projectMM){
	
	$("#urlPage").val("adminTeam");
	$("#methodType").val("save");
	
	$("#project_user_MM_SEQ").val(project_user_MM_SEQ);
	$("#project_SEQ").val(projectSEQ);
	$("#project_MM").val(projectMM);
	
	doSubmit();
	
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
	<input type="hidden"				id="project_user_MM_SEQ" 	name="project_user_MM_SEQ" 	value="" />
	<input type="hidden"				id="project_SEQ" 			name="project_SEQ" 			value="" />
	<input type="hidden"				id="project_MM" 			name="project_MM" 			value="" />
	<input type="hidden"				id="disable" 				name="disable" 				value="" />
	<input type="hidden"				id="check_MM_seq" 			name="check_MM_seq" 		value="" />
	<input type="hidden"				id="check_user_MM_seq" 		name="check_user_MM_seq" 	value="" />
	<input type="hidden"				id="adminTeamMMSEQ" 		name="adminTeamMMSEQ" 		value="" />

	<jsp:include page="/WEB-INF/form/top.jsp"></jsp:include>
	
	<div class="mm-menu-name"><h5>관리자 M/M (팀별 입력 현황)</h5></div>
	
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
			<th class="text-muted" style="width:80px; text-align: center;">부서명</th>
			<td style="width:350px;">
				<select id="search_dept_seq" name="search_dept_seq"  class="form-control">
					<option value="">부서</option>
					<c:forEach  var='item' items="${lDept }">
						<c:if test="${item.v_up_dept_name_k eq null }">
							<option value="${item.i_seq_pk }" ${item.i_seq_pk == searchBean.search_dept_seq ? "selected='selected'" : ""}>${item.v_dept_name_k }</option>
						</c:if>
						<c:if test="${item.v_up_dept_name_k ne null }">
							<option value="${item.i_seq_pk }" ${item.i_seq_pk == searchBean.search_dept_seq ? "selected='selected'" : ""}>${item.v_up_dept_name_k } / ${item.v_dept_name_k }</option>
						</c:if>
					</c:forEach>
				</select>
			</td>
			<th class="text-muted" style="width:60px; text-align: center;">성명</th>
			<td style="width:160px;">
				<select id="search_user_seq" name="search_user_seq" class="form-control">
					<option value="">성명</option>
					<c:forEach  var='item' items="${lUser }">
						<option value="${item.userSEQ }" ${item.userSEQ == searchBean.search_user_seq ? "selected='selected'" : ""}>${item.userName }</option>
					</c:forEach>
				</select>
			</td>
			<th class="text-muted" style="width:100px; text-align: center;">완료 여부</th>
			<td style="width:120px;">
				<select id="project_user_flag" name="project_user_flag" class="form-control">
					<option value="" ${"" == searchBean.project_user_flag ? "selected='selected'" : ""}>전부</option>
					<option value="Y" ${"Y" == searchBean.project_user_flag ? "selected='selected'" : ""}>완료</option>
					<option value="N" ${"N" == searchBean.project_user_flag ? "selected='selected'" : ""}>미완료</option>
				</select>
			</td>
			<td class="text-muted" style="width:60px; text-align: right;">
				<button type="button" class="btn btn-secondary btn-sm" id="btn_search">조회</button>
			</td>
		</tr>
	</table>
	
	<table class="mm-search">
		<tr>
			<td style="margin-top:10px;">
				<button type="button" id="btn_download" name="btn_download" class="btn btn-outline-primary">Excel 다운로드</button>
				<button type="button" id="btn_complete" name="btn_complete" class="btn btn-outline-primary" onclick="completeClick('Y')">완료</button>
				<button type="button" id="btn_inComplete" name="btn_inComplete" class="btn btn-outline-primary" onclick="completeClick('N')">미완료</button>
				<button type="button" id="btn_insert" name="btn_insert" class="btn btn-outline-primary">입력</button>
			</td>
		</tr>
	</table>
	
	<table class="table">
			
		<c:set var="index" value="0" />
		
		<!-- 유저 데이터가 없는 경우 -->
		<c:if test="${lUserDefaultMM.size() eq null }">
			<tr>
				<td>
					<table class="table table-bordered">	
						<thead>
							<tr class="table-primary">
								<th scope="col" style="color: #050505; font-size: 14px;">선택</th>
								<th scope="col" style="color: #050505; font-size: 14px;">완료여부</th>
								<th scope="col" style="color: #050505; font-size: 14px;">작업년도</th>
								<th scope="col" style="color: #050505; font-size: 14px;">부서코드</th>
								<th scope="col" style="color: #050505; font-size: 14px;">부서명(ERP)</th>
								<th scope="col" style="color: #050505; font-size: 14px;">부서명</th>
								<th scope="col" style="color: #050505; font-size: 14px;">사번</th>
								<th scope="col" style="color: #050505; font-size: 14px;">성명</th>
								<th scope="col" style="color: #050505; font-size: 14px;">입사일</th>
								<th scope="col" style="color: #050505; font-size: 14px;">퇴사일</th>
								<th scope="col" style="color: #050505; font-size: 14px;">급여일수</th>
								<th scope="col" style="color: #050505; font-size: 14px;">당월 M/M</th>
							</tr>
						</thead>
					</table>
				<td>
					<table class="table table-bordered">	
						<thead>
							<tr class="table-primary">
								<th scope="col" style="color: #050505; font-size: 14px;">프로젝트 코드</th>
								<th scope="col" style="color: #050505; font-size: 14px;">프로젝트 명</th>
								<th scope="col" style="color: #050505; font-size: 14px;">투입 M/M</th>
							</tr>
						</thead>
					</table>
				</td>	
			</tr>
		</c:if>
		
		<!-- 유저 데이터가 있는 경우 -->	
		<c:if test="${lUserDefaultMM.size() != 0 }">
			<c:forEach var='item' items="${lUserDefaultMM }">
				<tr>
					<!-- 직원 정보 데이터 -->
					<c:if test="${index == 0 }">
						<td>
							<table class="table table-bordered">	
								<thead>
									<tr class="table-primary">
										<th scope="col" style="color: #050505; font-size: 14px;">선택</th>
										<th scope="col" style="color: #050505; font-size: 14px;">완료여부</th>
										<th scope="col" style="color: #050505; font-size: 14px;">작업년도</th>
										<th scope="col" style="color: #050505; font-size: 14px;">부서코드</th>
										<th scope="col" style="color: #050505; font-size: 14px;">부서명(ERP)</th>
										<th scope="col" style="color: #050505; font-size: 14px;">부서명</th>
										<th scope="col" style="color: #050505; font-size: 14px;">사번</th>
										<th scope="col" style="color: #050505; font-size: 14px;">성명</th>
										<th scope="col" style="color: #050505; font-size: 14px;">입사일</th>
										<th scope="col" style="color: #050505; font-size: 14px;">퇴사일</th>
										<th scope="col" style="color: #050505; font-size: 14px;">급여일수</th>
										<th scope="col" style="color: #050505; font-size: 14px;">당월 M/M</th>
									</tr>
								</thead>
								<tr>
									<td style="text-align: center; font-size: 14px;">
										<input type="checkbox" id="i_mm_seq_pk" name="i_mm_seq_pk" value="${item.i_seq_pk }">
										<input type="hidden" id="i_userSeq" name="i_userSeq" value="${item.i_user_number }" />
									</td>
									<td id="adminTeamYN" name="adminTeamYN" style="font-size: 14px;">${item.v_disable }</td>
									<td style="font-size: 14px;">${item.d_job_date }</td>
									<td style="font-size: 14px;">${item.v_dept_code }</td>
									<td style="font-size: 14px;">${item.v_dept_code_name }</td>
									<td style="font-size: 14px;">${item.v_dept_name }</td>
									<td style="font-size: 14px;">${item.v_man_seq }</td>
									<td style="font-size: 14px;">${item.v_user_name_k }</td>
									<td style="font-size: 14px;">${item.d_enter_date }</td>
									<td style="font-size: 14px;">${item.d_retirement_date }</td>
									<td style="font-size: 14px;">${item.i_day_count }</td>
									<td id="userMM" name="userMM" style="font-size: 14px;">${item.d_mm }</td>
								</tr>
							</table>
						</td>
					</c:if>
					<!-- 직원 MM작성 정보 데이터 -->
					<c:if test="${index == 0 }">
						<td>
							<table class="table table-bordered">	
								<thead>
									<tr class="table-primary">
										<th scope="col" style="color: #050505; font-size: 14px;">프로젝트 코드</th>
										<th scope="col" style="color: #050505; font-size: 14px;">프로젝트 명</th>
										<th scope="col" style="color: #050505; font-size: 14px;">투입 M/M</th>
									</tr>
								</thead>
					</c:if>
					<c:if test="${index < item.cnt }">
						<c:if test="${item.v_project_code ne null }">
								<tr>
									<td style="font-size: 14px;">${item.v_project_code }</td>
									<td style="font-size: 14px;">${item.v_project_name }</td>
									<td style="font-size: 14px;">${item.d_mm_user }</td>
								</tr>
						</c:if>
								<c:set var="index" value="${index + 1 }" />
					</c:if>
					<c:if test="${index == item.cnt }">
								<tr>
									<td class="table-info" colspan="2" style="font-size: 14px;">총 MM</td>
									<td style="font-size: 14px;">${item.d_mm_user_group_sum }</td>
								</tr>
								<c:set var="index" value="0" />
							</table>
						
						</td>
					</c:if>
					
				</tr>
			</c:forEach>
			
			
			<table class="table table-bordered" align="right" style="margin-right: 10px; width: 500px;">	
				<thead>
					<tr class="table-primary">
						<th scope="col" style="color: #050505; font-size: 14px;">당월 M/M계</th>
						<th scope="col" style="color: #050505; font-size: 14px;">프로젝트 코드</th>
						<th scope="col" style="color: #050505; font-size: 14px;">프로젝트 명</th>
						<th scope="col" style="color: #050505; font-size: 14px;">투입 M/M 합계</th>
					</tr>
				</thead>
				<c:if test="${lUserProjectGroup.size() != 0 }">
					<c:forEach var='item' items="${lUserProjectGroup }">
						<tr>
							<td style="font-size: 14px;"></td>
							<td style="font-size: 14px;">${item.v_project_code }</td>
							<td style="font-size: 14px;">${item.v_project_name }</td>
							<td style="font-size: 14px;">${item.d_mm_user_sum }</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:forEach var='item' items="${lUserDefaultMM }" begin="0" end="0">
					<tr>
						<td style="font-size: 14px;">${item.d_mm_sum }</td>
						<td style="font-size: 14px;"></td>
						<td style="font-size: 14px;"></td>
						<td style="font-size: 14px;">${item.d_mm_user_sum }</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
				
	</table>
	
</form>
</body>
</html>