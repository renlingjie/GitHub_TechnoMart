<%--
  Created by IntelliJ IDEA.
  User: renlingjie
  Date: 2020/9/4
  Time: 8:51 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<% String basePath = request.getScheme()
    +"://"
    +request.getServerName()
    +":"
    +request.getServerPort()
    +request.getContextPath()
    +"/";
%>
<base href="<%=basePath%>">