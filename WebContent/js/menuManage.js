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
				window.parent.location = "../../order/menu_deleteSelectMenu.action?str="+str.toString();
			}
		}
	});
	
	//查询
	$("#confirm").on('click',function(){
		var menuname = $("#query").val();
	
		$.ajax({
			type:'get',
			async:'true',
			url:'../../order/menu_queryMenuByName.action?menuName='+menuname,
			success:function(data){
				if(data.status == "true"){
					$(".query-result").html(
						 "<div>"
							+"<span style='font-size:16px;color:#0377c5;'>您查询的菜单信息如下:</span>"
							+"<div class='table-responsive'>"
								+"<table class='table table-bordered table-responsive'>"
									+"<tr class='title'>"
										+"<td><input type='checkbox' name='allSelect'></td>"
										+"<td>菜单ID</td>"									
										+"<td>菜名</td>"
										+"<td>单价（元）</td>"
										+"<td>描述</td>"
										+"<td>操作</td>"
									+"</tr>"
									+"<tr class='record'>"
										+"<td><input type='checkbox' name='check' value='"+data.menu_id+"'></td>"
										+"<td>"+data.menu_id+"</td>"
										+"<td>"+data.menu_name+"</td>"								
										+"<td>"+data.menu_price+"</td>"
										+"<td>"+data.menu_content+"</td>"								
										+"<td><a href='../../order/menu_deleteMenuById.action?id="+data.menu_id+"'>删除</a>"
										+"<span> | </span>"
										+"<a href='../../order/menu_searchMenuById.action?id="+data.menu_id+"'>修改</a></td>"
									+"</tr>"
								+"</table>"
							+"</div>"
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
