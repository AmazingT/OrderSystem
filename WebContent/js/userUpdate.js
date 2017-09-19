$(function(){
	$("input[type='button']").on("click",function(){
		var user_pass = $("input[name='user.user_pass']").val();
		var pass  = $("input[name='pass']").val();
	
		if(user_pass == ""){
			$(".result").remove();
			$(".update-content").prepend("<div class='result'>请输入新密码！</div>");
			return;
		}else if(pass == ""){
			$(".result").remove();
			$(".update-content").prepend("<div class='result'>请再次输入密码！</div>");
			return;
		}else if(user_pass != pass){
			$(".result").remove();
			$(".update-content").prepend("<div class='result'>两次密码输入不一致！</div>");
			return;
		}
	
		$.ajax({
			type:'POST',
			url:'../order/user_updateUserPass.action',
			dataType:'json',
			data:{
				"user.user_pass":user_pass
			},
			beforeSend:function(){
				$("input[type='button']").attr({"disabled":"disabled"}).val("提交中...");
			},
			success:function(data){

				if(data.status == "true"){
					$(".result").remove();
					$(".update-content").prepend("<div class='result-true'>"+data.message+"，返回<a href='userLogin.jsp'>登录</a></div>");
				}
				if(data.status == "false"){
					$(".result").remove();
					$(".update-content").prepend("<div class='result'>"+data.message+"</div>");
				}
			},
			complete:function(){
				$("input[type='button']").removeAttr("disabled").val("确定");
			},
			error:function(error){
				alert(error.status);
			}
		});
	});
	
});