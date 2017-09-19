
	$(".drop-menu").each(function(){
		var $this = $(this);
		var theMenu = $this.find(".submenu");
		var tarHeight = theMenu.height();
		theMenu.css({height:0});
		$this.hover(
			function(){
				$(this).addClass("menu-hover");
				theMenu.stop().show().animate({height:tarHeight},100);
			},
			function(){
				$(this).removeClass("menu-hover");
				theMenu.stop().animate({height:0},100,function(){
					$(this).css({display:"none"});
				});
			}
		);
	});
	
	var search = document.getElementById('searchContent');
	search.onfocus = function(){
		document.onkeydown = function(event) {
			var ev = event || window.event;
			var keyCode = ev.keyCode;

			if (keyCode == 13) {//enter键值
				searchMenu();
				event.preventDefault(); //阻止默认行为
			}
		}

	}
	
	search.onblur = function(){
		return;
	}
	
	function searchMenu() {
		var menuName = search.value;
		if(menuName == ""){
			alert("搜索关键词不能为空！");
			return;
		}
		document.myForm.submit();
	}
	
	function getTime(){
		var time = document.getElementById("time");
		time.innerHTML = new Date().toLocaleString();
		setTimeout("getTime()",1000);
	}