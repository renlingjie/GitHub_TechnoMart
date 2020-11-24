<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/5
  Time: 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<div>
    <%--当点击商品管理的超链接时，该请求通过反射会执行MartService类中的list方法，这个方法将需要的商品信息存储到了request域中
				同时进行请求转发，页面会跳转到商品管理的jsp页面--%>
    <a href="manager/martServlet?action=page&category=0">商品管理</a>
    <a href="order_manager.jsp">订单管理</a>
    <a href="${pageScope.basePath}clientMartServlet?action=page&category=0">返回商城</a>
</div>