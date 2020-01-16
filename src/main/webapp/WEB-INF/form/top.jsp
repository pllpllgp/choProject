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
<script type="text/javascript" src="https://unpkg.com/popper.js@1.14.7/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="/mm/common/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/mm/common/js/common.js"></script>
<script type="text/javascript" src="/mm/common/js/select2.js"></script>
<script type="text/javascript">

window.onload = function() {
	var urlpage = $("#urlPage").val();
	var urlAuth = $("#userAuth").val();
	var userDeptAuth = $("#userDeptAuth").val();
	
	if(userDeptAuth == "N" && urlAuth == "N") {
		
		$("#teamMM-tab").hide();
	}
	
	if(urlAuth == "N") {
		
		$("#projectCode-tab").hide();
		$("#otherPeople-tab").hide();
		$("#confirmor-tab").hide();
		$("#defaultMM-tab").hide();
		$("#adminTeam-tab").hide();
		$("#userSuperintend-tab").hide();
		$("#teamSuperintend-tab").hide();
	}
	
	document.getElementById("userMM-tab").className = "nav-link";
	document.getElementById("teamMM-tab").className = "nav-link";
	document.getElementById("projectCode-tab").className = "nav-link";
	document.getElementById("otherPeople-tab").className = "nav-link";
	document.getElementById("confirmor-tab").className = "nav-link";
	document.getElementById("defaultMM-tab").className = "nav-link";
	document.getElementById("adminTeam-tab").className = "nav-link";
	document.getElementById("userSuperintend-tab").className = "nav-link";
	document.getElementById("teamSuperintend-tab").className = "nav-link";
	
	document.getElementById(urlpage + "-tab").className = "nav-link active";
}

function topMenu(page){

	$("#urlPage").val(page);
	$("#methodType").val("normal");
	doSubmit();
	
}
	
</script>
</head>
<body>

	<header style="width:1600px; margin:auto; margin-top:50px">
		<div class="text-left" style="height: 70px; margin-top: 10px; margin-left: 10px;">
			<img src="/common/images/gravity_Ci.png" width="207" height="49"/>
		</div>
		
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item">
				<a class="nav-link active" id="userMM-tab" href="#userMM" role="tab" aria-controls="userMM" aria-selected="false" onclick="topMenu('userMM');">유저 본인 입력</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="teamMM-tab" href="#teamMM" role="tab" aria-controls="teamMM" aria-selected="true" onclick="topMenu('teamMM');">팀별 입력 현황</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="projectCode-tab" href="#projectCode" role="tab" aria-controls="projectCode" onclick="topMenu('projectCode');">프로젝트 관리(관리자)</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="otherPeople-tab" href="#otherPeople" role="tab" aria-controls="otherPeople" onclick="topMenu('otherPeople');">대리입력 지정(관리자)</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="confirmor-tab" href="#confirmor" role="tab" aria-controls="confirmor" onclick="topMenu('confirmor');">확인자 지정(관리자)</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="defaultMM-tab" href="#defaultMM" role="tab" aria-controls="defaultMM" onclick="topMenu('defaultMM');">당월 M/M 입력(관리자)</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="adminTeam-tab" href="#adminTeam" role="tab" aria-controls="adminTeam" onclick="topMenu('adminTeam');">팀별입력 현황(관리자)</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="userSuperintend-tab" href="#userSuperintend" role="tab" aria-controls="userSuperintend" onclick="topMenu('userSuperintend');">직원 관리(관리자)</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="teamSuperintend-tab" href="#teamSuperintend" role="tab" aria-controls="teamSuperintend" onclick="topMenu('teamSuperintend');">팀 관리(관리자)</a>
			</li>
		</ul>
	</header>
	
</body>
</html>