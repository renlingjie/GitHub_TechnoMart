<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>科技是第一生产力</title>
		<%--base标签库--%>
		<%@ include file="/pageStart/common/base.jsp"%>
		<link rel="stylesheet" type="text/css" href="static/css/pageStart.css"  /><!--2、../../-->
		<script type="text/javascript" src="static/jquery-3.1.1.min.js"></script><!--3、../../-->
		<script type="text/javascript">
			
		</script>
	</head>
	<body >
		<!--1、背景动画-->
		<video style="width:100% ; height: 100%;" autoplay muted loop>
			<source src="static/video/s1.mp4"></source><!--4、../../-->
		</video>
		<!--2、登录表单-->
		<div class="divStyle">
			<iframe align="center" width="100%" height="170%" src="/technoMart/pageStart/HJJ/login.jsp"
			border="0" frameborder="no" marginheight="0" marginheight="0"></iframe>
		</div>
		<!--3、一开始是注册窗口，去掉注释可用，但需要把上面的登录窗口注释掉
		<div class="divStyle">
			<iframe align="center" width="100%" height="170%" src="signup.jsp"
			border="0" frameborder="no" marginheight="0" marginheight="0"></iframe>
		</div>
		-->
	</body>
	
</html>
