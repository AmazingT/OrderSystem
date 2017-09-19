$(function(){
	//多选删除
	var all = $("input[name='allSelect']");
	var check = $("input[name='check']");

	all.on("change",function(){
		var $this = $(this);
		if($this.is(":checked")){
			check.attr("checked",true);			
		}else{
			check.attr("checked",false);
		}
	});
	
	$("#delete").on("click",function(){
		var str=new Array();
		for(var i=0;i<check.length;i++){
			if(check[i].checked){
				str.push(check[i].value);//这里的value值就是所勾选记录的id
			}
		}
		if(str==""){
			alert("请选择删除的行!");
		}else{
			if ( window.parent != window) {
				window.parent.location = "../../order/user_deleteSelectUser.action?str="+str.toString();
			}
		}
	});
	
	//查询
	$("#confirm").on('click',function(){
		var username = $("#query").val();
	
		$.ajax({
			type:'get',
			async:'true',
			url:'../../order/user_queryUserByName.action?username='+username,
			success:function(data){
				if(data.status == "true"){
					$(".query-result").html(
						 "<div>"
						+"<span style='font-size:16px;color:#0377c5;'>您查询的用户信息如下:</span>"
						+"<table class='table table-bordered table-responsive'>"
							+"<tr class='title'>"
								+"<td><input type='checkbox' name='allSelect'></td>"
								+"<td>用户ID</td>"									
								+"<td>用户名</td>"
								+"<td>姓名</td>"
								+"<td>性别</td>"
								+"<td>邮箱</td>"
								+"<td>身份</td>"
								+"<td>操作</td>"
							+"</tr>"
							+"<tr class='record'>"
								+"<td><input type='checkbox' name='check' value='"+data.user_id+"'></td>"
								+"<td>"+data.user_id+"</td>"								
								+"<td>"+data.user_name+"</td>"
								+"<td>"+data.user_realname+"</td>"
								+"<td>"+data.user_sex+"</td>"
								+"<td>"+data.user_mail+"</td>"
								+"<td>"+data.user_flag+"</td>"
								+"<td><a href='../../order/user_deleteUser.action?id="+data.user_id+"'>删除</a>"
								+"<span> | </span>"
								+"<a href='../../order/user_updateUI.action?id="+data.user_id+"'>修改</a></td>"
							+"</tr>"
						+"</table>"
						+"</div>"
						);
				}
				if(data.status == "false"){
					$(".query-result").html("<font color='#f60'>"+data.message+"</font>");
				}
			},
			error:function(res){
				alert(res.status);
			}
		});
	});
});
