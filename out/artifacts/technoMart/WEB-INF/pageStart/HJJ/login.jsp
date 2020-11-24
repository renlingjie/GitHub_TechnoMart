<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>表单验证</title>
		<%--base标签库--%>
		<%@ include file="/pageStart/common/base.jsp"%>
		<link rel="stylesheet" type="text/css" href="static/css/login.css"  /><!--6、../../-->
	</head>
	<body>
		<script>

			window.onload = function(){//页面加载完毕执行此function
				/*
				//用户名————————————————————————————————————————————————————————————————————————————————————————
				var flag = false;//设置一个全局变量的标记
				document.getElementById("text1").onblur = function(){//当出现失焦事件，获取id为text1的键入值
					var username = document.getElementById("text1").value;
					var usernametest = /^[A-Za-z0-9]{6,14}$/;//指定正则表达式，要求只能是6～14位的数字或字母
					var ok = usernametest.test(username);
					if(ok){
						document.getElementById("tip").innerHTML="<span style='color: #00FFFF;'>用户名格式合法</span>";
						flag = true;
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
				*/
				//登录——————————————————————————————————————————————————————————————————————————————————————————————————
				//表单提交有两种，一种是type="submit",这种是无论合法与否都会提交；一种是type="button"，然后在点击button事件中先判
				//断是否合法，若合法通过获取表单对象，通过表单对象调用它特有的submit()方法来提交，此方法实现了先判断再提交的实际需求
				document.getElementById("btn").onclick = function(){//当出现点击事件，获取id为btn的键入值
						alert("提交成功");
						var userFormElt = document.getElementById("userForm");//合法就获取表单对象
						userFormElt.submit();//然后调用表单对象的submit()方法，也是可以实现表单提交。
				}
			}

		</script>
		<h1 style="color:#50a3a2; margin: 0; text-align: center" >Login</h1>
		<span class="spanStyle"><%= request.getAttribute("msg1")==null?"请输入用户名和密码":request.getAttribute("msg1")%></span>

		<!--登录窗口中的超链接，链接至登录窗口-->
		<a href="/technoMart/pageStart/HJJ/signup.jsp" >没有账号？立即注册</a>
		<form id="userForm" action="http://localhost:8080/technoMart/userServlet" method="post" class="container">
		<input type="hidden" name="action" value="login">
		<input type="text" name="username" id="text1" placeholder="用户姓名" />
		<span id ="tip" style="color: red;font size: 12px;"></span>
		<br>
		<input type="text" name="password" id="text2" placeholder="用户密码" />
		<br>
		<input type="button" value="登录" id="btn"  />
	</body>
</html>
