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
	
	//당월 팀 M/M 검색
	$("#btn_search").click(function() {
		
		//formClear();
		if($("#search_date").val() == "" || $("#search_dept_seq").val() == "") {
			
			alert("작업월과 부서를 선택해 주세요.");
			return;
			
		} else {

			$("#urlPage").val("teamMM");
			$("#methodType").val("search");
			doSubmit();
		
		}
		
	});
	
	
	//개인 M/M 완료
	$("#btn_complete").click(function() {
		
		var projectMMSeq = "";
		var projectCheck = false;
		
		$("#urlPage").val("teamMM");
		$("#methodType").val("complete");
		
		$("[name='i_mm_seq_pk']").each(function(){
			
			if(projectCheck = $(this).is(":checked")){
				projectMMSeq += $(this).val() + ",";
			}

		});
		
		$("#i_mm_seq_pk").val(projectMMSeq);
		$("#complete_check").val("Y");
		
		doSubmit();
		
	});
	
	
	//개인 M/M 미완료
	$("#btn_incomplete").click(function() {
		
		var projectMMSeq = "";
		var projectCheck = false;
		
		$("#urlPage").val("teamMM");
		$("#methodType").val("complete");
		
		$("[name='i_mm_seq_pk']").each(function(){
			
			if(projectCheck = $(this).is(":checked")){
				projectMMSeq += $(this).val() + ",";
			}

		});
		
		$("#i_mm_seq_pk").val(projectMMSeq);
		$("#complete_check").val("N");
		
		doSubmit();
		
	});
	
	
	//팀완료 버튼 클릭
	$("#btn_team_complete").click(function() {
		
		var teamYN = "Y";
		var projectMMSeq = "";
		
		$("[name='teamCompleteYN']").each(function(){
			
			if($(this).html() == "N"){
				teamYN = "N";
				return;
			}

		});
		
		$("[name='i_mm_seq_pk']").each(function(){
			projectMMSeq += $(this).val() + ",";

		});
		
		$("#i_mm_seq_pk").val(projectMMSeq);
		
		if(teamYN == "Y"){
			$("#urlPage").val("teamMM");
			$("#methodType").val("teamComplete");
			
			doSubmit();
		} else {
			alert("MM 완료가 안된 인원이 있습니다.");
		}
		
	});
	
	
	//팀별 입력 현황 엑셀 다운로드
	$("#btn_download").click(function() {
		
		var teamUserMMSeq = ""
		
		if($("#search_date").val() == "" || $("#search_dept_seq").val() == "") {
			
			alert("작업월과 부서를 선택해 주세요.");
			
		} else {
			
			$("[name='i_mm_seq_pk']").each(function(){
				
				if($(this).is(":checked")){
					
					teamUserMMSeq += $(this).val() + ","
				}
			});

			$("#teamUserMMSEQ").val(teamUserMMSeq);
			$("#urlPage").val("teamMM");
			$("#methodType").val("excel");
			doSubmit();
			
		}
	});
	
//$(function(){}) 종료	
})

//해당 월 팀별 MM 부서 확인
function choiceDate() {
	
	$("#urlPage").val("teamMM");
	$("#methodType").val("dateSearch");
	doSubmit();
	
}

</script>
</head>
<body>
<form id="userInfo" method="post" style="width:1600px; margin:auto; margin-top:50px">
	<input type="hidden"				id="urlPage" 				name="urlPage" 				value="${urlPage }"/>
	<input type="hidden"				id="methodType" 			name="methodType" 			value=""/>
	<input type="hidden"				id="userSEQ"				name="userSEQ" 				value="${userBean.userSEQ }"/>
	<input type="hidden"				id="userID"					name="userID"				value="${userBean.userID }"/>
	<input type="hidden"				id="userName" 				name="userName" 			value="${userBean.userName }"/>
	<input type="hidden"				id="userMail" 				name="userMail" 			value="${userBean.userMail }"/>
	<input type="hidden"				id="userNum" 				name="userNum" 				value="${userBean.userNum }"/>
	<input type="hidden"				id="userAuth" 				name="userAuth" 			value="${userBean.userAuth }"/>
	<input type="hidden"				id="userDeptAuth" 			name="userDeptAuth" 		value="${userBean.userDeptAuth }"/>
	<input type="hidden"				id="i_mm_seq_pk" 			name="i_mm_seq_pk" 			value=""/>
	<input type="hidden"				id="complete_check" 		name="complete_check" 		value=""/>
	<input type="hidden"				id="teamUserMMSEQ" 			name="teamUserMMSEQ" 		value=""/>

	<jsp:include page="/WEB-INF/form/top.jsp"></jsp:include>
	
	<div class="mm-menu-name"><h5>확인자 M/M (팀별 입력 현황)</h5></div>
	
	<table class="mm-search">
		<tr>
			<th class="text-muted" style="width:60px; text-align: left;">작업월</th>
			<td style="width:120px;">
				<select id="search_date" name="search_date"  class="form-control" onchange="choiceDate();">
					<option value="">작업월</option>
					<c:forEach var='item' items="${lMonth }">
						<option value="${item }" ${item == searchBean.search_date ? "selected='selected'" : ""}>${item }</option>
					</c:forEach>
				</select>

			</td>
			<th class="text-muted" style="width:80px; text-align: center;">부서명</th>
			<td style="width:200px;">
				<select id="search_dept_seq" name="search_dept_seq"  class="form-control">
					<option value="">부서명</option>
					<c:forEach  var='item' items="${lTeam }">
						<option value="${item.i_dept_seq }" ${item.i_dept_seq == searchBean.search_dept_seq ? "selected='selected'" : ""}>${item.v_dept_name }</option>
					</c:forEach>
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
				<c:if test="${btn_flag eq '2' }">
					<input type="button" class="btn btn-outline-primary" id="btn_download" 			name="btn_download" 		value="Excel 다운로드"/>
				</c:if>
				<c:if test="${btn_flag eq '3' }">
					<input type="button" class="btn btn-outline-primary" id="btn_complete" 			name="btn_complete"	 		value="완료"/>
					<input type="button" class="btn btn-outline-primary" id="btn_incomplete" 		name="btn_incomplete" 		value="미완료"/>
					<input type="button" class="btn btn-outline-primary" id="btn_team_complete" 	name="btn_team_complete" 	value="팀완료"/>
				</c:if>
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
								<th scope="col" style="color: #050505; font-size: 14px;">부서명</th>
								<th scope="col" style="color: #050505; font-size: 14px;">사번</th>
								<th scope="col" style="color: #050505; font-size: 14px;">성명</th>
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
										<th scope="col" style="color: #050505; font-size: 14px;">부서명</th>
										<th scope="col" style="color: #050505; font-size: 14px;">사번</th>
										<th scope="col" style="color: #050505; font-size: 14px;">성명</th>
										<th scope="col" style="color: #050505; font-size: 14px;">당월 M/M</th>
									</tr>
								</thead>
								<tr>
									<td style="text-align: center;">
										<input type="checkbox" id="i_mm_seq_pk" name="i_mm_seq_pk" value="${item.i_seq_pk }" style="font-size: 14px;">
									</td>
									<td id="teamCompleteYN" name="teamCompleteYN" style="font-size: 14px;">${item.v_disable }</td>
									<td style="font-size: 14px;">${item.d_job_date }</td>
									<td style="font-size: 14px;">${item.v_dept_code }</td>
									<td style="font-size: 14px;">${item.v_dept_name }</td>
									<td style="font-size: 14px;">${item.v_man_seq }</td>
									<td style="font-size: 14px;">${item.v_user_name_k }</td>
									<td style="font-size: 14px;">${item.d_mm }</td>
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
		</c:if>
				
	</table>
	
</form>
</body>
</html>