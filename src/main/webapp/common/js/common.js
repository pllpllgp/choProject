function doSubmit(){
	
	var urlPage = $("#urlPage").val() + ".grv";
	$("#userInfo").attr('action',urlPage).submit();
	
}