<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>表单验证</title>
		<%--base标签库--%>
		<%@ include file="/pageStart/common/base.jsp"%>
		<link rel="stylesheet" type="text/css" href="static/css/signup.css"  /><!--8、../../-->
	</head>
	<body>
		<script type="text/javascript" src="static/jquery-3.1.1.min.js"></script>
		<script type="text/javascript">//T1--<script>

			window.onload = function(){//页面加载完毕执行此function
				//用户名————————————————————————————————————————————————————————————————————————————————————————
				var flag = false;//设置一个全局变量的标记
				document.getElementById("text1").onblur = function(){//当出现失焦事件，获取id为text1的键入值
					var username = document.getElementById("text1").value;
					var usernametest = /^[A-Za-z0-9]{6,14}$/;//指定正则表达式，要求只能是6～14位的数字或字母
					var ok = usernametest.test(username);
					if(ok){
						//如果格式正确，通过Ajax请求确认用户名是否可用
						$.getJSON("http://localhost:8080/technoMart/userServlet","action=ajaxExistsUsername&username=" + username,function (data) {
							if (data.existsUsername) {
								document.getElementById("tip").innerHTML="<span style='color: orangered;'>用户名已存在</span>";
								flag = false;
							} else {
								document.getElementById("tip").innerHTML="<span style='color: #00FFFF;'>用户名可用</span>";
								flag = true;
							}
						});
					}else{
						document.getElementById("tip").innerHTML="<span style='color:orangered;'>用户名格式不合法，必须是6～14位的数字或字母</span>";
						flag = false;
					}
				}
				document.getElementById("text1").onfocus = function(){//当出现聚焦事件开始执行
					if(flag==false){//聚焦事件发生，如果键入值不合法，清空span标签提示以及用户输入内容
						document.getElementById("tip").innerHTML="";//将span标签的内容改为空字符串（这样就不显示了）
						document.getElementById("text1").value="";//获取用户键入值并清空清空
					}
				}
				//密码————————————————————————————————————————————————————————————————————————————————————————————
				var flag1 = false;//设置一个全局变量的标记
				var password1;//由于两个密码要比较，不能在各自的函数中设置这些变量，否则会变成局部无法比较
				var password2;
				document.getElementById("text2").onblur = function(){//当出现失焦事件，获取id为text2的键入值
					password1 = document.getElementById("text2").value;
					//当初下面的if只在下一个function中有，这就产生一bug：当先输入确认密码，再输入密码时，即使一致也会报错，或者两次输入的不一致，把密码
					//改成确认密码错误同样消失不了。原因是上面程序是从上往下执行，解决办法是在这里也加一个if，保证判断不分先后，只要失焦，也可跳回来判断
					if(password1 == password2){//if函数必须得在function里面，否则按照从上往下的顺序只会执行一次
						flag1 = true;
						document.getElementById("tip1").innerHTML="<span style='color: #00FFFF;'>前后两次输入密码一致</span>";
					}else{
						flag1 = false;
						document.getElementById("tip1").innerHTML="<span style='color:orangered;'>前后两次输入密码不一致</span>";
					}
				}
				document.getElementById("text3").onblur = function(){//当出现失焦事件，获取id为text2的键入值
					password2 = document.getElementById("text3").value;
					if(password1 == password2){//if函数必须得在function里面，否则按照从上往下的顺序只会执行一次
						flag1 = true;
						document.getElementById("tip1").innerHTML="<span style='color: #00FFFF;'>前后两次输入密码一致</span>";
					}else{
						flag1 = false;
						document.getElementById("tip1").innerHTML="<span style='color:orangered;'>前后两次输入密码不一致</span>";
					}
				}
				document.getElementById("text3").onfocus = function(){//当出现聚焦事件开始执行
					if(flag1==false){//聚焦事件发生，前后两次密码不一致，清空span标签提示以及用户输入内容
						document.getElementById("tip1").innerHTML="";//将span标签的内容改为空字符串（这样就不显示了）
						document.getElementById("text3").value="";//清空用户输入内容
					}
				}
				//邮箱——————————————————————————————————————————————————————————————————————————————————————————————
				var flag2 = false;//设置一个全局变量的标记
				document.getElementById("text4").onblur = function(){//当出现失焦事件，获取id为text4的键入值
					var email = document.getElementById("text4").value;
					var emailtest = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;//指定正则表达式，要求符合邮箱格式
					var ok = emailtest.test(email);
					if(ok){
						document.getElementById("tip2").innerHTML="<span style='color: #00FFFF;'>邮箱格式合法</span>";
						flag2 = true;
					}else{
						document.getElementById("tip2").innerHTML="<span style='color:orangered;'>邮箱格式不合法</span>";
						flag2 = false;
					}
				}
				document.getElementById("text4").onfocus = function(){//当出现聚焦事件开始执行
					if(flag2==false){//聚焦事件发生，如果键入值不合法，清空span标签提示以及用户输入内容
						document.getElementById("tip2").innerHTML="";//将span标签的内容改为空字符串（这样就不显示了）
						document.getElementById("text4").value="";//获取用户键入值并清空清空
					}
				}
				//提交——————————————————————————————————————————————————————————————————————————————————————————————————
				//表单提交有两种，一种是type="submit",这种是无论合法与否都会提交；一种是type="button"，然后在点击button事件中先判
				//断是否合法，若合法通过获取表单对象，通过表单对象调用它特有的submit()方法来提交，此方法实现了先判断再提交的实际需求
				document.getElementById("btn").onclick = function(){//当出现点击事件，获取id为btn的键入值
					if(flag==true&&flag1==true&&flag2==true){//所有文本框内容都合法，提交表单
						alert("提交成功");
						var userFormElt = document.getElementById("userForm");//合法就获取表单对象
						userFormElt.submit();//然后调用表单对象的submit()方法，也是可以实现表单提交。
						//同时将页面跳转至登录界面，采用onclick=window.open("要跳转的页面");来实现
						//*bug//onclick=window.open("pageStart.jsp");
					}else{
						alert("提交失败，存在不合法输入");
					}
				}
				//重制——————————————————————————————————————————————————————————————————————————————————————————————————
				document.getElementById("res").onclick = function(){//当出现点击事件，获取id为res的键入值
					document.getElementById("tip").innerHTML="";
					document.getElementById("tip1").innerHTML="";
					document.getElementById("tip2").innerHTML="";
				}
				<%--alert(<%=request.getAttribute("msg")==null?request.getAttribute("msg"):"222"%>);--%>
				//验证码————————————————————————————————————————————————————————————————————————————————————————————————
				document.getElementById("code_img").onclick = function () {
					//在事件响应的function函数中有一个this对象，这个this对象，是当前正在响应时间的dom对象
					//也就是说，由于我们点击了这个图片而触发的单击事件的dom对象就是这个图片，this就是这个图片
					//src表示验证码img标签的图片路径，它可读可写，这里面我们重新对它赋值(加上/kaptcha.jpg)
					//他就会重新发起一次请求
					this.src="http://localhost:8080/technoMart/Kaptcha.jpg?id=" + new Date();
				}
			}
		</script>
		<%--因为是从上往下，所以最开始下面这个span标签的margin就决定了下面所有标签的高度--%>
		<h1 style="color:#50a3a2; margin: 0; text-align: center" >Sign up</h1>
		<span class="spanStyle"><%= request.getAttribute("msg")==null?"请您完成下面的注册":request.getAttribute("msg")%></span>
		<!--注册窗口中的超链接，链接至登录窗口-->
		<a href="/technoMart/pageStart/HJJ/login.jsp" >已有账号？立即登录</a>
		<form id="userForm" action="http://localhost:8080/technoMart/userServlet" method="post" class="container"><%--S2registServlet--%>
		<input type="hidden" name="action" value="regist"><%--S1--%>
		<input type="text" name="username" id="text1" placeholder="用户姓名" />
		<span id ="tip" style="color: red;font size: 12px;"></span>
		<br>
		<input type="text" name="password" id="text2" placeholder="用户密码" />
		<br>
		<input type="text" id="text3"  placeholder="确认密码"/>
		<span id ="tip1" style="color: red;font size: 12px;"></span>
		<br>
		<input type="text" name="email" id="text4"  placeholder="用户邮箱"/>
		<span id ="tip2" style="color: red;font size: 12px;"></span>
		<br>
		<input type="text" name="code"  style="width: 150px; margin-left: 29.5%;display:inline;float: left" placeholder="验证码"/>
		<span style="color: red;font size: 12px;"></span>
		<img src="http://localhost:8080/technoMart/Kaptcha.jpg" alt="" style="width: 150px;margin-left: -102px; height: 48px;" id="code_img">
		<br>
		<input type="reset" value="重制"  id="res" style="margin-top: 10px;"/> &nbsp;&nbsp;
		<input type="button" value="提交" id="btn" style="margin-top: 10px;"/>
		<%--若验证码错误，弹窗回显--%>
		<%String msg2 = (String)request.getAttribute("msg2");//从request域中获取存储"服务器对验证码的校验结果"的容器msg2
		if(msg2 != null) {%>
		<script type="text/javascript" language="javascript">
		alert("<%=msg2%>"); // 弹出错误信息
		</script>
		<%}%>
	</body>
</html>
