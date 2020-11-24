<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品管理</title>
	<%-- 静态包含 base标签、css样式、jQuery文件 --%>
	<%@ include file="/pageStart/common/head.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="static/css/manager_blue.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="static/css/manager_blue2.css" />
	<link rel="stylesheet" href="static/css/tooplate-main.css">
</head>
<body>
<div>
	<!-- 标题栏 -->
	<div id="pre-header">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<span>科技商城，带给您的是全新的理念</span>
				</div>
			</div>
		</div>
	</div>
	<!-- 页面logo -->
	<div class="container" style="text-align: center"><%--bootstrap.min.css中规定了container类的格式：宽度100%，内容在div中左右各15px--%>
		<span class="navbar-brand"><img src="static/img/header-logo.png" alt=""></span>
	</div>
</div>
<!-- 页面标题 -->
<div id="TitleArea" style="border-bottom: 0px;">
	<div id="TitleArea_Head"></div>
	<div id="TitleArea_Title">
		<div id="TitleArea_Title_Content">
			商品管理：您可以在现有的文本框中完成商品的添加/修改操作
		</div>
	</div>
	<div id="TitleArea_End"></div>
</div>
<!-- 主内容区域（数据列表或表单显示） -->
<div id="MainArea">
	<!-- 表单内容 -->
	<form action="manager/martServlet" method="get" enctype="multipart/form-data"><%--指定提交的地址--%>
		<%--接收到添加超链接发过来到最后一页的页码，继续发给manager/martServlet标识符定位到到MartServlet
		然后经下面三目判断如果是add，然后我们在add中让它跳转到最后一页--%>
		<input type="hidden" name="pageNo" value="${param.pageNo}">
		<%--同样的添加一个隐藏域，告诉请我们要提交的信息是执行什么方法，通过判断ID属性是否为空，来判断form表单提交的请求
		究竟是添加操作还是修改操作--%>
		<input type="hidden" name="action" value="${empty param.id ? "add":"update"}" />
		<input type="hidden" name="id" value="${ requestScope.mart.id }" /><%--修改操作被封装的sql语句所需要的ID--%>
		<!-- 本段标题（分段标题） -->
		<div class="ItemBlock_Title" style="font-size: 16px;">
			<img width="8" height="14" border="0" src="static/img/arrow.gif"> 商品信息&nbsp;
		</div>
		<!-- 本段表单字段 -->
		<div class="ItemBlockBorder" style="margin-left: 50px;">
			<div class="ItemBlock">
				<div class="ItemBlock2">
					<table cellpadding="0" cellspacing="0" class="mainForm">
					<tr>
						<td>商品类别</td>
						<td>
							<select name="category" value="${requestScope.mart.category}" style="width:220px;height: 30px; font-size: 20px;">
								<option value="1" style="height: 30px;">Book(category:1)</option>
								<option value="2" style="height: 30px;">Electron(category:2)</option>
								<option value="3" style="height: 30px;">Course(category:3)</option>
							</select>
							*<input type="hidden" name="" value="" /></td>
					</tr>
					<tr>
						<td>商品名称</td>
						<td><input type="text" name="name" class="InputStyle" value="${requestScope.mart.name}"/> *</td>
					</tr>
					<tr>
						<td>商品价格</td>
						<td><input type="text" name="price" class="InputStyle" value="${requestScope.mart.price}"/> *</td>
					</tr>
					<tr>
						<td>生产厂商</td>
						<td><input type="text" name="manufacturer" class="InputStyle" value="${requestScope.mart.manufacturer}"/> *</td>
					</tr>
					<tr>
						<td>商品销量</td>
						<td><input type="text" name="sales" class="InputStyle" value="${requestScope.mart.sales}" /> *</td>
					</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 表单操作 -->
		<div id="InputDetailBar">
			<td><input type="submit" value="提交" class="FunctionButtonInput" id="ButtonHover"/></td>
			<a href="javascript:history.go(-1);" class="FunctionButton">返回</a>
		</div>
	</form>
</div>

<%--静态包含页脚内容--%>
<%@include file="/pageStart/common/footer.jsp"%>

</body>
</html>