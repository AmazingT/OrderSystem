var num1=true;
var num2=true;

function showToday()
{
	var change = document.getElementById("today");
	if(num1==true)
	{
		change.innerHTML = "<form action='../test/order_searchUserOrder.action?flag=fg' method='post'><table>" +
				"<tr><td align='left' height='35px'>请输入用户名：</td></tr><tr><td height='35px'><input type='text' name='username'/></td></tr>" +
				"<tr><td align='right' height='35px'><input type='submit' value='查询'/></td></tr></table></form>";
		num1=false;
	}
	else
	{
		change.innerHTML = "";
		num1=true;
	}
}

function showAll()
{
	var change = document.getElementById("all");
	if(num2==true)
	{
		change.innerHTML = "<form action='../test/order_searchUserOrder.action' method='post'><table>" +
			"<tr><td align='left' height='35px'>请输入用户名：</td></tr><tr><td height='35px'><input type='text' name='username'/></td></tr>" +
			"<tr><td align='right' height='35px'><input type='submit' value='查询'/></td></tr></table></form>";
		num2=false;
	}
	else
	{
		change.innerHTML = "";
		num2=true;
	}
}