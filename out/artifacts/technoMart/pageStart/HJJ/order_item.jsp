<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<script type="text/javascript" src="http://localhost:8080/technoMart/static/jquery-3.1.1.min.js"></script>
		<meta charset="utf-8">
		<title>订单详情</title>
		<%--base标签库--%>
		<%@ include file="/pageStart/common/base.jsp"%>
		<link rel="stylesheet" href="static/css/cartandorderStyle.css">
	</head>
	<body>
	<script type="text/javascript">
	</script>
		<div class="banner_x center">
			<a href="" target="_blank"><div class="logo fl"></div></a>
			<div class="wdgwc fl ml40">我的订单详情</div>
			<div class="wxts fl ml20">温馨提示：如对订单项商品有任何疑问，请及时联系客服进行处理</div>
			<div class="dlzc fr">
				<ul>
					<li><a href="javascript:self.close()" style="color: #c82333;font-size: 35px;">×</a></li>
				</ul>

			</div>
			<div class="clear"></div>
		</div>
		<div class="xiantiao"></div>
		<div class="gwcxqbj">
			<div class="gwcxd center">
				<div class="top2 center">
					<div class="sub_top fl">商品订单号</div>
					<div class="sub_top fl">商品名称</div>
					<div class="sub_top fl" >商品数量</div>
					<div class="sub_top fl">商品单价</div>
					<div class="sub_top fl">商品总价</div>
					<div class="clear"></div>
				</div>
				<c:forEach items="${sessionScope.orderItemList}" var="entry"><%--进行遍历，得到键值对中的键entry，然后对值进行输出--%>
				<div class="content2 center">
					<div class="sub_content fl ft20">${entry.orderId}</div>
					<div class="sub_content fl " style="margin-left: 155px">${entry.name}</div>
					<div class="sub_content fl" style="margin-left: 63px">${entry.count}</div>
					<div class="sub_content fl" style="margin-left: -110px">${entry.price}</div>
					<div class="sub_content fl" style="margin-left: 38px;width: 100px">${entry.totalPrice}</div>
				</div>
				</c:forEach>
				<%--如果该用户的所有订单中的这个"订单详情对应的订单的状态不是2，说明就是没有签收，用户有权限进行确认收货"--%>
				<c:if test="${sessionScope.currentStatus != 2}">
					<div class="jiesuandan mt20 center">
						<div class="jiesuan fr">
							<div class="jsanniu fr" onclick="window.open('orderServlet?action=updateOrder&statusNeed=2&orderId='+${sessionScope.orderItemList[0].orderId});window.close()"><input class="jsan" type="submit" name="jiesuan"  value="确认收货"/></div>
							<div class="clear"></div>
						</div>
						<div class="clear"></div>
					</div>
				</c:if>
				<c:if test="${sessionScope.currentStatus == 2}">
					<div class="jiesuandan mt20 center">
						<div class="jiesuan fr">
							<div class="jsanniu fr"><input class="jsan" readonly="readonly" name="jiesuan" style="background-color: #545b62;text-align: center" value="已签收"/></div>
							<div class="clear"></div>
						</div>
						<div class="clear"></div>
					</div>
				</c:if>
			</div>
			<%--<div>${sessionScope.currentStatus==0}</div>实验时状态为0，打印在页面上也为true--%>
	<!-- footer -->
	<footer class="center">
			<div class="mt20"style="font-size: 20px;">您的支持，就是对我们最大的鼓励</div>
	</footer>
</html>
