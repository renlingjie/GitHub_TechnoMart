
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%--用JSTL遍历集合所需要用的包--%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<script type="text/javascript" src="http://localhost:8080/technoMart/static/jquery-3.1.1.min.js"></script>
		<meta charset="utf-8">
		<%--base标签库--%>
		<%@ include file="/pageStart/common/base.jsp"%>
		<link rel="stylesheet" type="text/css" href="static/css/cartandorderStyle.css">
		<link rel="stylesheet" href="static/css/managerPush.css">
		<title>订单中心</title>
	</head>
	<body>
	<%-----------------------------查看详情开始-------------------------------------
	<script>
		触发"订单详情"单击事件的时候，执行Show
		function Show(){
			document.getElementById('shade').classList.remove('hide');
			document.getElementById('modal').classList.remove('hide');
		}
		function Hide(){
			document.getElementById('shade').classList.add('hide');
			document.getElementById('modal').classList.add('hide');
		}
	</script>
	上面Show/Hide作用的表单
	<div id="shade" class="c1 hide"></div>表单边框
	<div id="modal" class="c2 hide">
		<div class="ztxx fr" style="float: left;margin-left: 20px">
			<div class="left fl">
				<ul >
					<li style="float: left;width: 120px;text-align: center"><span>商品名称</span></li>
					<li style="float: left">|</li>
					<li style="float: left;width: 80px;text-align: center"><span>商品数量</span></li>
					<li style="float: left">|</li>
					<li style="float: left;width: 80px;text-align: center"><span>商品单价</span></li>
					<li style="float: left">|</li>
					<li style="float: left;width: 80px;text-align: center"><span>商品总价</span></li>
				</ul>
			</div>
			<c:forEach items="${sessionScope.orderItemList}" var="item">
				<ul >
					<li style="float: left;width: 120px;text-align: center"><span>${item.name}</span></li>
					<li style="float: left">|</li>
					<li style="float: left;width: 80px;text-align: center"><span>${item.count}</span></li>
					<li style="float: left">|</li>
					<li style="float: left;width: 80px;text-align: center"><span>${item.price}</span></li>
					<li style="float: left">|</li>
					<li style="float: left;width: 80px;text-align: center"><span>${item.totalPrice}</span></li>
				</ul>
			</c:forEach>
		</div>
		<input type="button" value="关闭" onclick="Hide();" style="width: 56px;height: 28px;font-size: 18px;margin-bottom: auto;margin-left:172px">
	</div>
	---------------------------查看详情结束---------------------------------------%>
	<!-- start header -->
		<header>
			<div class="top center">
				<div class="left fl">
					<ul>
						<li><span>科技商城</span>&nbsp;</li>
						<li>|</li>
						<li>&nbsp;<span>安全</span>&nbsp;</li>
						<li>|</li>
						<li>&nbsp;<span>快捷</span>&nbsp;</li>
						<li>|</li>
						<li>&nbsp;<span>新颖</span>&nbsp;</li>
					</ul>
				</div>
				<div class="right fr">
					<div class="gouwuche fr"><a href="">我的订单</a></div>
					<div class="fr">
						<ul>
							<li><a href="${pageScope.basePath}clientMartServlet?action=page&category=0"; >商品列表</a></li>
							<li>|</li>
							<li><a href="/technoMart/pageStart/HJJ/carts.jsp"; >查看购物车</a></li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div>
		</header>
	<!--end header -->
	<!-- start banner_x -->
		<div class="banner_x center" style="text-align: center;margin-top: 25px">
			<span ><img src="static/img/header-logo.png" alt=""></span><br><br>
			<div >亲爱的「<span style="color:orangered;">${sessionScope.username}</span>」：您可以点击"订单详情"对商品明细进行查看哦</div>
		</div>
<!-- end banner_x -->
<!-- self_info -->
	<div class="grzxbj">
		<div class="selfinfo center">
		<div class="rtcont fr"  style="margin-right: 115px;">
			<div class="ddxq">
				<div class="ztxx fr" style="float: left;margin-left: 50px">
					<c:if test="${ not empty sessionScope.cart.items}">
					<ul style="color: #1e1e1e">
						<li style="width: 200px">生成订单号</li>
						<li style="width: 110px">订单状态</li>
						<li>订单总额</li>
						<li style="width: 200px">订单生成日期</li>
						<li>查看详情</li>
						<div class="clear"></div>
					</ul>
					</c:if>
					<c:if test="${empty sessionScope.orderList}">
						<div style="margin-top: 15px;margin-left: 230px">
							<span><a style="color: #545b62;font-size: 20px" href="${pageScope.basePath}clientMartServlet?action=page&category=0">亲，当前订单为空，<span style="color:orangered;">点我</span>再去逛一逛吧</a></span>
						</div>
					</c:if>
					<c:forEach items="${sessionScope.orderList}" var="item">
					<ul >
						<li style="width: 200px">${item.orderId}</li>
						<li style="width: 110px">
							<c:choose>
								<c:when test="${item.status==0}">
									未发货
								</c:when>
								<c:when test="${item.status==1}">
									已发货
								</c:when>
								<c:when test="${item.status==2}">
									已签收
								</c:when>
							</c:choose>
						</li>
						<li>￥${item.price}</li>
						<li style="width: 200px">${item.createTime}</li>
						<li><a onclick="window.open('orderItemServlet?action=showAllOrderItems&orderId='+${item.orderId});window.close()" style="cursor: pointer" >订单详情></a></li>
						<div class="clear"></div>
					</ul>
					</c:forEach>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<div class="clear"></div>
		</div>
	</div>
<!-- self_info -->
		<footer class="mt20 center">			
			<div class="mt20"style="font-size: 20px;">您的支持，就是对我们最大的鼓励</div>
		</footer>
	</body>
</html>