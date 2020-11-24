<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/5
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    String basePath = request.getScheme()
            + "://"
            + request.getServerName()
            + ":"
            + request.getServerPort()
            + request.getContextPath()
            + "/";
    //把这个路径放到域中，在mart_manager将这个路径取出（就是在跳转页面时，我们给的路径不能是localhost，那样那个是我们主机的，别人访问不到）
    pageContext.setAttribute("basePath",basePath);
%>

<!--写base标签，永远固定相对路径跳转的结果-->
<base href="<%=basePath%>">
<link type="text/css" rel="stylesheet" href="static/css/manager.css" >
<script type="text/javascript" src="static/jquery-3.1.1.min.js"></script>