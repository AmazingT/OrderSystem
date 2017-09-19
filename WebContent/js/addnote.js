// JavaScript Document
var subFlag = false;
var optionFlag = false;
function checkSubject()
{
	//通过对象名获取对应的提示文字标签
	var name = document.getElementById("subject").value;	
	var textBox = document.getElementById("mgsubject");
	if(name == ""){
			textBox.innerHTML = "×主题不能为空！";
			textBox.style.color = "red";
		}
	else{
			textBox.innerHTML = "√";
			textBox.style.color = "green";
			subFlag = true;
		}
}
function checkContent()
{
	
	var content = document.getElementById("content").value;	
	var textBox = document.getElementById("mgcontent");		
	if(content == ""){
			textBox.innerHTML = "×内容不能为空！";
			textBox.style.color = "red";
		}
	else{
			textBox.innerHTML = "√";
			textBox.style.color = "green";
			optionFlag = true;
		}

}
function getSub(){
	if(optionFlag && subFlag){
		document.mainForm.action="../test/mg_addMessage.action";
		}
	else{
		document.mainForm.action="#";
		}
		
}
