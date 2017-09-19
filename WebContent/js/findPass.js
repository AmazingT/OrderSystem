	//登录，注册ajax请求
	$("button[name='next']").on("click",function(){
		var user = $("input[name='user.user_realname']").val();
		var mail  = $("input[name='mail']").val();
		var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
		var code = $("input[name='validateCode']");
		var test = reg.test(mail);
	
		if(user == ""){
			$(".result").remove();
			$(".find-content").prepend("<div class='result'>请输入姓名！</div>");
			return;
		}else if(mail == ""){
			$(".result").remove();
			$(".find-content").prepend("<div class='result'>请输入邮箱！</div>");
			return;
		}else if(!test){
			$(".result").remove();
			$(".find-content").prepend("<div class='result'>邮箱格式不正确！</div>");
			return;
		}
		//发送登陆请求
		$.ajax({
			type:'POST',
			url:'../order/user_findPass.action',
			dataType:'json',
			data:{
				"user.user_realname":user,
				"user.user_mail":mail,
				"vaildateCode":code
			},
			success:function(data){

				if(data.status == "true"){
					location.href = "userUpdate.jsp";
				}
				if(data.status == "false"){
					$(".result").remove();
					$(".find-content").prepend("<div class='result'>"+data.message+"</div>");
				}
			},
			error:function(error){
				alert(error.status);
			}
		});
	});
	