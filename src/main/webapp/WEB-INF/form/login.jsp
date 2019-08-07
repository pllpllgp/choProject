<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Gravity M/M</title>
<script type="text/javascript" src="/mm/common/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="/mm/common/js/common.js"></script>
<script type="text/javascript">
	$(function() {
	
		//로그인 클릭
		$("#loginEnter").click(function() {

				$("#urlPage").val("login");
				$("#methodType").val("login");
				doSubmit();
		});
		
	})
</script>
</head>
<body>
	
	<form id="userInfo"	name="userInfo" method="post">
		<input type="hidden"				id="urlPage" 				name="urlPage" 				value=""/>
		<input type="hidden"				id="methodType" 			name="methodType" 			value=""/>
		
		<div><h5>아이디를 입력해 주세요.</h5></div>
		<div><input type='text' id='userID' name='userID' style='width: 150px;' /> <button type="button" id="loginEnter" name="loginEnter">로그인</button></div>
		
	</form>
	
</body>

</html>