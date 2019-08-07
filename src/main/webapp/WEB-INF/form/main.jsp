<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Gravity M/M</title>
<script type="text/javascript" src="/mm/common/js/jquery-3.3.1.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/form/top.jsp"></jsp:include>
	
	<form id="userInfo"	name="userInfo" method="post">
		<input type="hidden"				id="urlPage" 				name="urlPage" 				value=""/>
		<input type="hidden"				id="methodType" 			name="methodType" 			value=""/>
		<input type="hidden"				id="userSEQ"				name="userSEQ" 				value="${userBean.userSEQ }"/>
		<input type="hidden"				id="userID"					name="userID"				value="${userBean.userID }"/>
		<input type="hidden"				id="userName" 				name="userName" 			value="${userBean.userName }"/>
		<input type="hidden"				id="userMail" 				name="userMail" 			value="${userBean.userMail }"/>
		<input type="hidden"				id="userNum" 				name="userNum" 				value="${userBean.userNum }"/>
		<input type="hidden"				id="userAuth" 				name="userAuth" 			value="${userBean.userAuth }"/>
	</form>
    
</body>

</html>