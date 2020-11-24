<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>发货管理</title>
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
			发货管理：您可以对查询到的订单的订单状态进行修改
		</div>
	</div>
	<div id="TitleArea_End"></div>
</div>
<!-- 主内容区域（数据列表或表单显示） -->
<div id="MainArea">
	<!-- 表单内容 -->
	<form action="orderServlet" method="get" enctype="multipart/form-data"><%--指定提交的地址--%>
		<input type="hidden" name="action" value="updateOrder">
		<input type="hidden" name="orderId" value="${sessionScope.orderPojo.orderId}">
		<input type="hidden" name="flag" value="1">
		<!-- 本段标题（分段标题） -->
		<div class="ItemBlock_Title" style="font-size: 16px;">
			<img width="8" height="14" border="0" src="static/img/arrow.gif"> 订单信息&nbsp;
		</div>

		<!-- 本段表单字段 -->
		<div class="ItemBlockBorder" style="margin-left: 50px;">
			<div class="ItemBlock">
				<div class="ItemBlock2">
					<table cellpadding="0" cellspacing="0" class="mainForm">
					<tr>
						<td>订单编号:</td>
						<td>${sessionScope.orderPojo.orderId}</td>
					</tr>
					<tr>
						<td>用户编号:</td>
						<td>${sessionScope.orderPojo.userId}</td>
					</tr>
					<tr>
						<td>订单状态:</td>
						<td>
						<c:choose>
							<c:when test="${sessionScope.orderPojo.status==0}">
								未发货
							</c:when>
							<c:when test="${sessionScope.orderPojo.status==1}">
								已发货
							</c:when>
							<c:when test="${sessionScope.orderPojo.status==2}">
								已签收
							</c:when>
						</c:choose>
						</td>
					</tr>
					<tr>
						<td>状态修改:</td>
						<td>
							<select name="statusNeed" style="width:220px;height: 30px; font-size: 20px;">
								<option value="0" style="height: 30px;">未发货(status:0)</option>
								<option value="1" style="height: 30px;">已发货(status:1)</option>
								<option value="2" style="height: 30px;">已签收(status:2)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>订单总价:</td>
						<td>¥${sessionScope.orderPojo.price}</td>
					</tr>
					<tr>
						<td>创建时间:</td>
						<td>${sessionScope.orderPojo.createTime}</td>
					</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 表单操作 -->
		<div id="InputDetailBar">
			<td><input type="submit" value="修改" class="FunctionButtonInput" id="ButtonHover"/></td>
			<a href="javascript:history.go(-1);" class="FunctionButton">返回</a>
		</div>
	</form>
</div>

<%--静态包含页脚内容--%>
<%@include file="/pageStart/common/footer.jsp"%>

</body>
</html>