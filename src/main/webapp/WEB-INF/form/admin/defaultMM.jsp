<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Gravity M/M</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet"  href="/mm/common/css/jquery-ui.css" />
<link rel="stylesheet"  href="/mm/common/css/jquery-ui.min.css" />
<script type="text/javascript" src="/mm/common/js/jquery-ui.js"></script>
<script type="text/javascript" src="/mm/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		$("#search_dept_seq").select2();
		
		$("#btn_search").click(function() {
		
			$("#urlPage").val("defaultMM");
			$("#methodType").val("search");
			
			if($("#search_date option:selected").val() == ""){
				
				alert("작업월을 선택해 주세요.");
			} else {
				
				doSubmit();
			}
			
		});
		
		
		//전월 M/M 데이터 다음월 M/M 데이터로 입력
		$("#btn_prev_month").click(function() {
			
			$("#urlPage").val("defaultMM");
			$("#methodType").val("prevMonth");
			
			if(false!=confirm($("#prev_month").val() + " 데이터가 " 
					+ $("#default_month").val() + " 데이터로 저장됩니다.\r\n"
					+ "기존에 저장된 " + $("#default_month").val() + " 데이터는 삭제 됩니다.\r\n"
					+ "저장 하시겠습니까?")){
				
				doSubmit();
			}
		});
		
		
		//당월 M/M입력 추가 버튼
		$("#btn_add").click(function(){
			
			var mytable = document.getElementById('defaultInserEdit');
			
			$("#defaultState").val("defaultAdd");
			
			document.getElementById("defaultAddTable").style.display = "block";
			
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
			cell6 = row.insertCell(5);
			cell7 = row.insertCell(6);
			cell8 = row.insertCell(7);
			cell9 = row.insertCell(8);
			cell10 = row.insertCell(9);

			cell1.innerHTML = "<td><select id='addDefaultYear' name='addDefaultYear' class='form-control' style='width: 150px;'><option value=''>작업월</option><c:forEach var='item' items='${lMonth }'><option value='${item }'>${item }</option></c:forEach></select></td>";
			cell2.innerHTML = "<td><input type='text' id='addDefaultCode' name='addDefaultCode' style='width: 100px;' /></td>";
			cell3.innerHTML = "<td><input type='text' id='addDefaultERP' name='addDefaultERP' /></td>";
			cell4.innerHTML = "<td><select id='addDefaultDept' name='addDefaultDept' style='width: 245px;'><option value=''></option><c:forEach var='item' items='${lDept }'><option value='${item.i_seq_pk }'>${item.v_dept_name_k }</option></c:forEach></select></td>";
			cell5.innerHTML = "<td><input type='text' id='addDefaultNum' name='addDefaultNum' readonly style='border: 0; width: 100px;' /></td>";
			cell6.innerHTML = "<td><select id='addDefaultName' name='addDefaultName' onchange='changeUser()'><option value=''></option><c:forEach var='item' items='${lUser }'><option value='${item.userSEQ }'>${item.userName }</option></c:forEach></select></td>";
			cell7.innerHTML = "<td><input type='text' id='addDefaultIn' name='addDefaultIn' style='width: 150px;' /></td>";
			cell8.innerHTML = "<td><input type='text' id='addDefaultOut' name='addDefaultOut' style='width: 150px;' /></td>";
			cell9.innerHTML = "<td><input type='text' id='addDefaultDay' name='addDefaultDay' /></td>";
			cell10.innerHTML = "<td><input type='text' id='addDefaultMM' name='addDefaultMM' /></td>";
			
			$("#addDefaultDept").select2();
			$("#addDefaultName").select2();
			
			$("#addDefaultIn").datepicker({
				
				dateFormat: 'yy-mm-dd',
				prevText: '이전 달',
				nextText: '다음 달',
				monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				dayNames: ['일','월','화','수','목','금','토'],
				dayNamesShort: ['일','월','화','수','목','금','토'],
				dayNamesMin: ['일','월','화','수','목','금','토'],
				yearSuffix: '년'
			});
			$("#addDefaultOut").datepicker({
				
				dateFormat: 'yy-mm-dd',
				prevText: '이전 달',
			    nextText: '다음 달',
				monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				dayNames: ['일','월','화','수','목','금','토'],
				dayNamesShort: ['일','월','화','수','목','금','토'],
				dayNamesMin: ['일','월','화','수','목','금','토'],
				yearSuffix: '년'
			});
		});
		
		
		//당월 M/M입력 수정 버튼
		$("#btn_edit").click(function(){
			
			var defaultSeq = "";
			var defaultYear = "";
			var defaultCode = "";
			var defaultERP = "";
			var defaultDept = "";
			var defaultNum = "";
			var defaultName = "";
			var defaultIndate = "";
			var defaultOutdate = "";
			var defaultDay = "";
			var defaultMM = "";
			
			var mytable = document.getElementById('defaultInserEdit');
			var choice = 0;
			
			$("#defaultState").val("defaultEdit");
			
			if(mytable.rows.length > 1){
				for(var i = 1; mytable.rows.length != i; i){
						
					mytable.deleteRow(1);
				}
			}
			
			$("[name='checkDefault']").each(function(){
				
				if($(this).is(":checked")){
					
					document.getElementById("defaultAddTable").style.display = "block";
					
					defaultSeq = $(this).val();
					defaultYear = $(this).closest('tr').find('[name="DefaultDate"]').text();
					defaultCode = $(this).closest('tr').find('[name="DefaultDeptCode"]').text();
					defaultERP = $(this).closest('tr').find('[name="DefaultDeptERP"]').text();
					defaultDept = $(this).closest('tr').find('[name="DefaultDeptSeq"]').val();
					defaultNum = $(this).closest('tr').find('[name="DefaultMMNum"]').text();
					defaultName = $(this).closest('tr').find('[name="DefaultUserSeq"]').val();
					defaultIndate = $(this).closest('tr').find('[name="DefaultMMIndate"]').text();
					defaultOutdate = $(this).closest('tr').find('[name="DefaultMMOutdate"]').text();
					defaultDay = $(this).closest('tr').find('[name="DefaultMMDay"]').text();
					defaultMM =$(this).closest('tr').find('[name="DefaultMMNow"]').text();
					
					choice ++;
				}
			});
			
			if(choice == 1) {
				
				row = mytable.insertRow(mytable.rows.length);
				
				cell1 = row.insertCell(0);
				cell2 = row.insertCell(1);
				cell3 = row.insertCell(2);
				cell4 = row.insertCell(3);
				cell5 = row.insertCell(4);
				cell6 = row.insertCell(5);
				cell7 = row.insertCell(6);
				cell8 = row.insertCell(7);
				cell9 = row.insertCell(8);
				cell10 = row.insertCell(9);

				cell1.innerHTML = "<td><input type='hidden'	id='addProjectSeq'	name='addProjectSeq' value='" + defaultSeq + "' /><input type='text' id='addDefaultYear' name='addDefaultYear' readonly style='border: 0; width: 150px;' value='" + defaultYear + "' /></td>";
				cell2.innerHTML = "<td><input type='text' id='addDefaultCode' name='addDefaultCode' style='width: 100px;' value='" + defaultCode + "' /></td>";
				cell3.innerHTML = "<td><input type='text' id='addDefaultERP' name='addDefaultERP' value='" + defaultERP + "' /></td>";
				cell4.innerHTML = "<td><select id='addDefaultDept' name='addDefaultDept' style='width: 245px;'><option value=''></option><c:forEach var='item' items='${lDept }'><option value='${item.i_seq_pk }'>${item.v_dept_name_k }</option></c:forEach></select></td>";
				cell5.innerHTML = "<td><input type='text' id='addDefaultNum' name='addDefaultNum' readonly style='border: 0; width: 100px;' value='" + defaultNum + "' /></td>";
				cell6.innerHTML = "<td><select id='addDefaultName' name='addDefaultName' onchange='changeUser()'><option value=''></option><c:forEach var='item' items='${lUser }'><option value='${item.userSEQ }'>${item.userName }</option></c:forEach></select></td>";
				cell7.innerHTML = "<td><input type='text' id='addDefaultIn' name='addDefaultIn' style='width: 150px;' value='" + defaultIndate + "' /></td>";
				cell8.innerHTML = "<td><input type='text' id='addDefaultOut' name='addDefaultOut' style='width: 150px;' value='" + defaultOutdate + "' /></td>";
				cell9.innerHTML = "<td><input type='text' id='addDefaultDay' name='addDefaultDay' value='" + defaultDay + "' /></td>";
				cell10.innerHTML = "<td><input type='text' id='addDefaultMM' name='addDefaultMM' value='" + defaultMM + "' /></td>";
						
				$("#addDefaultDept").val(defaultDept);
				$("#addDefaultName").val(defaultName);
				
				$("#addDefaultDept").select2();
				$("#addDefaultName").select2();
				
				$("#addDefaultIn").datepicker({
					
					dateFormat: 'yy-mm-dd',
					prevText: '이전 달',
					nextText: '다음 달',
					monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					dayNames: ['일','월','화','수','목','금','토'],
					dayNamesShort: ['일','월','화','수','목','금','토'],
					dayNamesMin: ['일','월','화','수','목','금','토'],
					yearSuffix: '년'
				});
				$("#addDefaultOut").datepicker({
					
					dateFormat: 'yy-mm-dd',
					prevText: '이전 달',
				    nextText: '다음 달',
					monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					dayNames: ['일','월','화','수','목','금','토'],
					dayNamesShort: ['일','월','화','수','목','금','토'],
					dayNamesMin: ['일','월','화','수','목','금','토'],
					yearSuffix: '년'
				});
				
			} else {
				
				document.getElementById("defaultAddTable").style.display = "none";
				alert("프로젝트를 선택해주세요.");
			}
		});
		
		
		//추가/수정 취소
		$("#btn_cancle").click(function() {
			
			document.getElementById("defaultAddTable").style.display = "none";
		});
		
		
		//추가/수정 저장
		$("#btn_save").click(function() {
			
			$("#urlPage").val("defaultMM");
			$("#methodType").val("save");
			$("#defaultDeptNameK").val($("#addDefaultDept option:selected").text());
			
			if($("#addDefaultYear").val() == "" || $("#addDefaultCode").val() == "" || $("#addDefaultERP").val() == "" ||
					 $("#addDefaultIn").val() == "" || $("#addDefaultDay").val() == "" || $("#addDefaultMM").val() == "" ||
					$("#addDefaultDept option:selected").val() == "" || $("#addDefaultName option:selected").val() == "") {
				
				alert("퇴사일을 제외한 모든 값을 입력해주세요.");
			} else {
				
				doSubmit();
			}
		});
		
		
		//팀별 입력 현황 엑셀 다운로드
		$("#btn_download").click(function() {
			
			var defaultMMSeq = ""
			
			if($("#search_date").val() == "") {
				
				alert("작업월을 조회해 주세요.");
			} else {
				
				$("[name='checkDefault']").each(function(){
					
					if($(this).is(":checked")){
						
						defaultMMSeq += $(this).val() + ",";
					}
				});

				$("#defaultMMSeq").val(defaultMMSeq);
				$("#urlPage").val("defaultMM");
				$("#methodType").val("excel");
				doSubmit();
				
			}
		});
		
		
	//$(function(){}) 종료
	})
	
	
	//추가/수정시 유저 선택 변경
	function changeUser(){

		$("[name='addDefaultName']").each(function(){
			
			$("#peopleNumber").val($(this).val());
			$(this).closest('tr').find('[name="addDefaultNum"]').val($("#peopleNumber option:selected").text());
			
			$("#addDefaultNum").val($("#peopleNumber option:selected").text());
		});
		
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
		<input type="hidden"				id="month_count" 			name="month_count" 			value="${monthCount }" />
		<input type="hidden"				id="defaultDeptNameK" 		name="defaultDeptNameK" 	value="" />
		<input type="hidden"				id="defaultMMSeq" 			name="defaultMMSeq" 		value="" />
		<input type="hidden"				id="defaultState" 			name="defaultState" 		value="" />
	
		<jsp:include page="/WEB-INF/form/top.jsp"></jsp:include>
		
		<div class="mm-menu-name"><h5>관리자 M/M (당월 M/M 입력)</h5></div>
		
		<table class="mm-search">
			<tr>
				<th class="text-muted" style="width:60px; text-align: right;">작업월</th>
				<td style="width:120px;">
					<select id="search_date" name="search_date" class="form-control">
						<option value="">작업월</option>
						<c:forEach var='item' items="${lMonth }">
							<option value="${item }" ${item == searchBean.search_date ? "selected='selected'" : ""}>${item }</option>
						</c:forEach>
					</select>
				</td>
				<th class="text-muted" style="width:60px; text-align: right;">부서명</th>
				<td style="width:350px;">
					<select id="search_dept_seq" name="search_dept_seq"  class="form-control">
						<option value="">부서명</option>
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
				<td class="text-muted" style="width:60px; text-align: right;">
					<button type="button" class="btn btn-secondary btn-sm" id="btn_search">조회</button>
				</td>
			</tr>
			<tr>
				<td colspan="5" style="margin-top:10px;">
					<button type="button" id="btn_download" name="btn_download" class="btn btn-outline-primary">Excel 다운로드</button>
					<c:forEach var='item' items="${lMonth }" begin="1" end="1">
						<button type="button" id="btn_prev_month" name="btn_prev_month" class="btn btn-outline-primary">${item } 데이터 가져오기</button>
						<input type="hidden" id="prev_month" name="prev_month" value="${item}"/>
					</c:forEach>
					<c:forEach var='item' items="${lMonth }" begin="0" end="0">
						<input type="hidden" id="default_month" name="default_month" value="${item}"/>
					</c:forEach>
					<button type="button" class="btn btn-outline-primary" id="btn_add">추가</button>
					<button type="button" class="btn btn-outline-primary" id="btn_edit">수정</button>
				</td>
			</tr>
		</table>
		
		<table id="defaultAddTable" name="defaultAddTable" align="center"  style="display: none;">
			<tr>
				<td>
					<table id="defaultInserEdit" name="defaultInserEdit"  class="table table-bordered">
						<thead>
							<tr class="table-primary">
								<th scope="col" style="color: #848484;">작업년도</th>
								<th scope="col" style="color: #848484;">부서코드</th>
								<th scope="col" style="color: #848484;">부서명(ERP)</th>
								<th scope="col" style="color: #848484;">부서명</th>
								<th scope="col" style="color: #848484;">사번</th>
								<th scope="col" style="color: #848484;">성명</th>
								<th scope="col" style="color: #848484;">입사일</th>
								<th scope="col" style="color: #848484;">퇴사일</th>
								<th scope="col" style="color: #848484;">급여일수</th>
								<th scope="col" style="color: #848484;">당월 M/M</th>
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
		
		<table class="table">
			<tr>
				<td>
					<table class="table table-bordered">
						<thead>
							<tr class="table-primary">
								<th scope="col" style="color: #848484; text-align: center;"><input type="checkbox" id="allCheckDefault" name="allCheckDefault" onclick="allProject()"/>  선택</th>
								<th scope="col" style="color: #848484;">작업년도</th>
								<th scope="col" style="color: #848484;">부서코드</th>
								<th scope="col" style="color: #848484;">부서명(ERP)</th>
								<th scope="col" style="color: #848484;">부서명</th>
								<th scope="col" style="color: #848484;">사번</th>
								<th scope="col" style="color: #848484;">성명</th>
								<th scope="col" style="color: #848484;">입사일</th>
								<th scope="col" style="color: #848484;">퇴사일</th>
								<th scope="col" style="color: #848484;">급여 일수</th>
								<th scope="col" style="color: #848484;">당월 M/M</th>
							</tr>
						</thead>
						<c:if test="${lDefaultMM.size() != 0 }">
							<c:forEach var="item" items="${lDefaultMM }">
								<tr>
									<td style="text-align: center;">
										<input type="hidden" id="DefaultDeptSeq" name="DefaultDeptSeq" value="${item.i_dept_seq }" />
										<input type="hidden" id="DefaultUserSeq" name="DefaultUserSeq" value="${item.i_user_number }" />
										<input type="checkbox" id="checkDefault" name="checkDefault" value="${item.i_seq_pk }"/>
									</td>
									<td id="DefaultDate" name="DefaultDate">${item.d_job_date }</td>
									<td id="DefaultDeptCode" name="DefaultDeptCode">${item.v_dept_code }</td>
									<td id="DefaultDeptERP" name="DefaultDeptERP">${item.v_dept_code_name }</td>
									<td id="DefaultDeptKor" name="DefaultDeptKor">${item.v_dept_name }</td>
									<td id="DefaultMMNum" name="DefaultMMNum">${item.v_man_seq }</td>
									<td id="DefaultMMName" name="DefaultMMName">${item.v_user_name_k }</td>
									<td id="DefaultMMIndate" name="DefaultMMIndate">${item.d_enter_date }</td>
									<td id="DefaultMMOutdate" name="DefaultMMOutdate">${item.d_retirement_date }</td>
									<td id="DefaultMMDay" name="DefaultMMDay">${item.i_day_count }</td>
									<td id="DefaultMMNow" name="DefaultMMNow">${item.d_mm }</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${lDefaultMM.size() != 0 }">
							<c:forEach var="item" items="${lDefaultMM }" begin="0" end="0">
								<tr>
									<td style="border-right: 1px solid #FFFFFF; border-left: 1px solid #FFFFFF; border-bottom: 1px solid #FFFFFF;"></td>
									<td style="border-right: 1px solid #FFFFFF; border-left: 1px solid #FFFFFF; border-bottom: 1px solid #FFFFFF;"></td>
									<td style="border-right: 1px solid #FFFFFF; border-left: 1px solid #FFFFFF; border-bottom: 1px solid #FFFFFF;"></td>
									<td style="border-right: 1px solid #FFFFFF; border-left: 1px solid #FFFFFF; border-bottom: 1px solid #FFFFFF;"></td>
									<td style="border-right: 1px solid #FFFFFF; border-left: 1px solid #FFFFFF; border-bottom: 1px solid #FFFFFF;"></td>
									<td style="border-right: 1px solid #FFFFFF; border-left: 1px solid #FFFFFF; border-bottom: 1px solid #FFFFFF;"></td>
									<td style="border-right: 1px solid #FFFFFF; border-left: 1px solid #FFFFFF; border-bottom: 1px solid #FFFFFF;"></td>
									<td style="border-right: 1px solid #FFFFFF; border-left: 1px solid #FFFFFF; border-bottom: 1px solid #FFFFFF;"></td>
									<td style="border-right: 1px solid #FFFFFF; border-left: 1px solid #FFFFFF; border-bottom: 1px solid #FFFFFF;"></td>
									<td style="border-left: 1px solid #FFFFFF; border-bottom: 1px solid #FFFFFF;"></td>
									<td id="totalMM" name="totalMM">${item.d_mm_sum }</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				</td>
			</tr>
		</table>
		
		
		<!-- 유저 사번/seq -->
		<table style="display: none;">
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