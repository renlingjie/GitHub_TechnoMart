<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<script type="text/javascript" src="http://localhost:8080/technoMart/static/jquery-3.1.1.min.js"></script>
		<meta charset="utf-8">
		<title>我的购物车</title>
		<%--base标签库--%>
		<%@ include file="/pageStart/common/base.jsp"%>
		<link rel="stylesheet" href="static/css/cartandorderStyle.css">
	</head>
	<body>
	<script type="text/javascript">
		$(function () {
			// 给输入框绑定 onchange内容发生改变事件
			$("input.shuliang").change(function () {
				//获取商品ID
				var id = $(this).attr("martId");
				//获取商品数量
				var count = this.value;
				if(count <= 0){
					alert("输入的商品数量要大于0，且格式要规范哦!");
					this.value = this.defaultValue;//输入数量有误，因此给出提示后返回原来的商品数量
					count = this.defaultValue;//一定要注意，除了文本显示的this.value应该改回原来的，发送给服务器的也要改回成原来的，否则这个就按错误的发送给服务器了
				}
				location.href ="http://localhost:8080/technoMart/cartServlet?action=updateCount&count="+count+"&id="+id;
			});
			<%--给删除操作绑定一个确认的单击事件--%>
			$("#clearConfirm").click(function () {
				return confirm("你确定要清除全部商品吗？")
			})
		});

	</script>
		<div class="banner_x center">
			<a href="" target="_blank"><div class="logo fl"></div></a>
			
			<div class="wdgwc fl ml40">我的购物车</div>
			<div class="wxts fl ml20">温馨提示：产品是否购买成功，以最终下单为准哦，请尽快结算</div>
			<div class="dlzc fr">
				<ul>
					<li><a href="/technoMart/pageStart/HJJ/order.jsp">订单中心</a></li>
					<li>|</li>
					<li><a href="${pageScope.basePath}clientMartServlet?action=page&category=0"; >商品列表</a></li>
				</ul>
				
			</div>
			<div class="clear"></div>
		</div>
		<div class="xiantiao"></div>
		<div class="gwcxqbj">
			<div class="gwcxd center">
				<div class="top2 center">
					
					<div class="sub_top fl">商品名称</div>
					<div class="sub_top fl">单价</div>
					<div class="sub_top fl" >数量</div>
					<div class="sub_top fl">小计</div>
					<div class="sub_top fr">操作</div>
					<div class="clear"></div>
				</div>
				<c:forEach items="${sessionScope.cart.items}" var="entry"><%--进行遍历，得到键值对中的键entry，然后对值进行输出--%>
				<div class="content2 center">
					<div class="sub_content fl ft20">${entry.value.name}</div>
					<div class="sub_content fl ">${entry.value.price}</div>
					<div class="sub_content fl" >
						<input class="shuliang" id="countUpdate" type="number" value="${entry.value.count}"
							   martId="${entry.value.id}" step="1" min="1" style="margin-top: 42px;">
					</div>
					<div class="sub_content fl" >${entry.value.totalPrice}</div>
					<div class="sub_content fl" style="width: 50px;"><a id="delConfirm" href="cartServlet?action=deleteItem&martId=${entry.value.id}">×</a></div>
				</div>
				</c:forEach>
			</div>
			<%--判断一下，如果购物车中没有商品，那么下面对标签不进行显示--%>
			<c:if test="${ not empty sessionScope.cart.items}">
			<div class="jiesuandan mt20 center">
				<div class="tishi fl ml20">
					<ul>
						<li><a href="cartServlet?action=clear" id="clearConfirm">清空购物车</a></li>
						<li>|</li>
						<li>共<span>${sessionScope.cart.totalCount}</span>件商品</li>
						<div class="clear"></div>
					</ul>
				</div>
				<div class="jiesuan fr">
					<div class="jiesuanjiage fl">合计（不含运费）：<span>${sessionScope.cart.totalPrice}</span></div>
					<div class="jsanniu fr" onclick="window.open('orderServlet?action=createOrder');window.close()"><input class="jsan" type="submit" name="jiesuan"  value="去结算"/></div>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div>
			</c:if>
			<c:if test="${empty sessionScope.cart.items}">
				<div style="text-align: center;margin-top: 15px">
					<span ><a style="color: #545b62;font-size: 20px" href="${pageScope.basePath}clientMartServlet?action=page&category=0">亲，当前购物车为空，<span style="color:orangered;">点我</span>再去逛一逛吧</a></span>
				</div>
			</c:if>
		</div>
		</div>
	</body>
	<!-- footer -->
	<footer class="center">
			<div class="mt20"style="font-size: 20px;">您的支持，就是对我们最大的鼓励</div>
	</footer>
</html>
