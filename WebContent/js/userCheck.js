	function reloadCode(){
		document.getElementById("code").src = "../order/user_Code?q="+Math.random();
	}
	
	//登录，注册ajax请求
	$("input[name='login']").on("click",function(){
		
		var user = $("input[name='user.user_name']").val();
		var pwd  = $("input[name='user.user_pass']").val();
		var code = $("input[name='user.user_code']").val();
		
		if(user == ""){
			$(".result").remove();
			$(".login-content").prepend("<div class='result'>请输入用户名！</div>");
		//	$("input[name='user.user_name']").parents(".form-group").addClass("has-error");
			return;
		}else if(pwd == ""){
			$(".result").remove();
			$(".login-content").prepend("<div class='result'>请输入密码！</div>");
			return;
		}else if(code == ""){
			$(".result").remove();
			$(".login-content").prepend("<div class='result'>请输入验证码！</div>");
			return;
		}
		
		//发送登陆请求
		$.ajax({
			type:'POST',
			url:'../order/user_login.action?user_code='+code,
			dataType:'json',
			data:{
				"user.user_name":user,
				"user.user_pass":pwd
			},
			beforeSend:function(){
				$("input[name='login']").attr({"disabled":"disabled"}).val("提交中...");
			},
			success:function(data){

				if(data.status == "true"){
					location.href = "../index.jsp";
				}
				if(data.status == "false"){
					$(".result").remove();
					$(".login-content").prepend("<div class='result'>"+data.message+"</div>");
				}
			},
			complete:function(){
				$("input[name='login']").removeAttr("disabled").val("登 录");
			},
			error:function(error){
				alert(error.status);			
			}
		});
	});
	
