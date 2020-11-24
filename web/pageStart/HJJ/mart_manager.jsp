<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品管理</title>

	<%-- 静态包含head.jsp,因为它里面有有 base标签（指定了该页面所有链接的跳转base）、css样式（manager.css）、jQuery文件， --%>
	<%@ include file="/pageStart/common/head.jsp"%>
	<%--在script标签中给行61下的"删除"超链接绑定一个确认删除事件--%>
	<script type="text/javascript">
		$(function () {
			// 给删除的a标签绑定单击事件，用于删除的确认提示操作
			$("a[name='del']").click(function () {<%--这是一个组合选择器，选择a标签中ID是deleteBtn的那个标签对象，给这个a(超链接)绑定事件--%>
				// 在事件的function函数中，有一个this对象。这个this对象，是当前正在响应事件的dom对象（也就是我们点击的"删除"）。
				/**
				 * confirm是确认提示框函数
				 * 参数是它的提示内容
				 * 它有两个按钮，一个确认，一个是取消。
				 * 返回true表示点击了，确认，返回false表示点击取消。
				 */
				//这句话是当前对象（也就是上面我们触发点击事件的那个a标签）的父标签td的父标签tr的第一行的文本，也就是获取的名字，也就相当域提示确认要删除XXX吗？
				//其中XXX为这一行tr中的名字。将收到的用户选择作为返回值进行返回
				return confirm("你确定要删除【" + $(this).parent().parent().find("td:first").text() + "】?");
				// return false// 阻止元素的默认行为===不提交请求
			});
			/*$("FunctionButton").click(function () {
				return confirm("你确定要删除【" + $(this).parent().parent().find("td:first").text() + "】?");
			});*/
		});
	</script>
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
		<!-- 页面标题 -->
		<div id="TitleArea">
			<div id="TitleArea_Head"></div>
			<div id="TitleArea_Title">
				<div id="TitleArea_Title_Content">
					商品管理:您可以执行添加/修改/删除商品的操作
				</div>
				<a href="${pageScope.basePath}clientMartServlet?action=page&category=0" style="margin-left: 1250px">返回商城</a>
				<a href="pageStart/HJJ/order_edit.jsp" style="margin-left: 30px">发货管理</a>
				<a href="manager/martServlet?action=page&category=0" style="margin-left: 30px">刷新页面</a>
			</div>
			<div id="TitleArea_End"></div>
		</div>
		<%-- 静态包含 manager管理模块的菜单，其实就是三个超链接  --%>
		<%--之所以这三个超链接能放的比较规整，是因为在manager.css样式中
		第103行定义了凡是ID是header的div，都会浮动，并浮动至右边（只要有位置），同时还让它距离父标签顶端55px（向下移动了一些）--%>
		<link href="static/css/manager_blue.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="static/css/manager_blue2.css" />
		<link rel="stylesheet" href="static/css/tooplate-main.css">
	</div>
	
	<div id="MainArea">
		<table class="MainArea_Content" align="center" cellspacing="0" cellpadding="0">
			<thead>
			<tr align="center" valign="middle" id="TableTitle">
				<td>商品名称</td>
				<td>商品价格</td>
				<td>生产厂商</td>
				<td>商品销量</td>
				<td>商品类别</td>
				<td>管理操作</td>
			</tr>
			</thead>
			<tbody id="TableData">
			<c:forEach items="${requestScope.page.items}" var="mart"><%--调用的是JSTL标签库中的core核心库中的forEach遍历标签
			其中我们request域中保存的key是marts，所以就是requestScope.marts--%>
				<%--在这里面进行遍历输出，输出的元素都放在对应表格的对应位置，从而保证每一轮输出都产生一行格式和上面一样的数据--%>
				<%--说明一下，这里var后面表示参与循环的变量，这里就是一个个的mart对象。将要遍历的东西写给items，当它接收到后，就按照items对我们的mart进行遍历--%>
				<tr class="TableDetail1">
					<td style="width: 400px;">${mart.name}</td>
					<td>${mart.price}</td>
					<td>${mart.manufacturer}</td>
					<td>${mart.sales}</td>
					<td>${mart.category}</td>
					<%--增加两个超链接，每个超链接都通过反射去执行Servlet程序中的一些方法，他们都是将该行（要修改/删除）的id获取然后随着请求一起发送到服务器，服务器将此参数
					传到反射对应的方法中，然后完成对应的操作--%>
					<%--修改的路径是先跳转到servlet获取要修改到图书信息，然后反射list，重定向至mart_edit.jsp--%>
					<td style="width: 280px;"><a href="manager/martServlet?action=getMart&id=${mart.id}&pageNo=${requestScope.page.pageNo}" class="FunctionButton" style="margin-left: 40px;">修改</a><%--此行和下一行都删除了分页，后面再加上--%>
					<%--pageNo=${requestScope.page.pageNo}也是将删除的页码给他发过去--%>
					<a name="del" id="deleteBtn" class="FunctionButton" style="margin-left: 50px;" href="manager/martServlet?action=delete&id=${mart.id}&pageNo=${requestScope.page.pageNo}">删除</a></td>
				</tr>
			</c:forEach>
			<%--这个是一个空着的一行，即使按列对这一行进行了划分，但是由于没有填任何数据，因此这一行是空着的，只有该行最右边的那个单元格里面有一个超链接
			这个超链接指向用于添加商品的jsp页面，也就是mart_edit.jsp。还要注意的是，按照从上往下，这个会随着上面的遍历输出而持续向下移动，一直位于该表格的末尾--%>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<%--这里面之所以pageNo=${}，是想让添加完商品跳到最后一页，因此把最后一页页码pageTotal也发给mart_edit.jsp--%>
				<td><div class="FunctionButton" style="margin-left: 80px;"><a href="pageStart/HJJ/mart_edit.jsp?pageNo=${requestScope.page.pageTotal}">添加商品</a></div></td>
			</tr>
			</tbody>
		</table>
		<%--分页条的开始--%>
		<div id="page_nav" style="font-size: 25px;color: #545b62">
			<%--我们要实现一个功能：若是首页则不显示"上一页"，如果是末页则不显示"下一页，此时就要调用JSTL的c标签库中的if标签"--%>
			<%--大于首页，才显示--%>
			<c:if test="${requestScope.page.pageNo > 1}">
				<a href="manager/martServlet?action=page&pageNo=1">首页</a>
				<a href="manager/martServlet?action=page&pageNo=${requestScope.page.pageNo-1}">上一页</a>
			</c:if>

			<%--下面功能主要是为了实现当前页码左右有前后页码的跳转，根据当前页码与总页码数又有几种不同的情况。--%>
			<%--页码输出的开始。假设我们要求当前页码前后各一个，也就是3个页码--%>
			<c:choose>
				<%--情况1：如果总页码小于等于3的情况，页码的范围是：1-总页码--%>
				<c:when test="${ requestScope.page.pageTotal <= 3 }">
					<c:set var="begin" value="1"/>
					<c:set var="end" value="${requestScope.page.pageTotal}"/>
				</c:when>
				<%--情况2：总页码大于3的情况--%>
				<c:when test="${requestScope.page.pageTotal > 3}">
					<c:choose>
						<%--小情况1：当前页码1的情况，页码范围是：1～2.--%>
						<c:when test="${requestScope.page.pageNo <= 1}">
							<c:set var="begin" value="1"/>
							<c:set var="end" value="2"/>
						</c:when>
						<%--小情况2：当前页码为最后1个，页码范围是：总页码减1～总页码--%>
						<c:when test="${requestScope.page.pageNo > requestScope.page.pageTotal-1}">
							<c:set var="begin" value="${requestScope.page.pageTotal-1}"/>
							<c:set var="end" value="${requestScope.page.pageTotal}"/>
						</c:when>
						<%--小情况3：其他情况，页码范围是：当前页码减1 - 当前页码加1--%>
						<c:otherwise>
							<c:set var="begin" value="${requestScope.page.pageNo-1}"/>
							<c:set var="end" value="${requestScope.page.pageNo+1}"/>
						</c:otherwise>
					</c:choose>
				</c:when>
			</c:choose>

			<c:forEach begin="${begin}" end="${end}" var="i">
				<c:if test="${i == requestScope.page.pageNo}">
					[${i}]<%--同时当前所在页页码应没有链接，无法点击跳转--%>
				</c:if>
				<c:if test="${i != requestScope.page.pageNo}">
					<%--而不是当前所在页页码的有链接，可以点击跳转--%>
					<a href="manager/martServlet?action=page&pageNo=${i}">${i}</a>
				</c:if>
			</c:forEach>
			<%--页码输出的结束--%>
			<%--小于末页，才显示--%>
			<c:if test="${requestScope.page.pageNo < requestScope.page.pageTotal}">
				<a href="manager/martServlet?action=page&pageNo=${requestScope.page.pageNo+1}">下一页</a>
				<a href="manager/martServlet?action=page&pageNo=${requestScope.page.pageTotal}">末页</a>
			</c:if>
			共${requestScope.page.pageTotal}页，${requestScope.page.pageTotalCount}条记录,
			到第<input value="" name="pn" id="pn_input" style="font-size: 25px"/>页

			<%--想要实现下面按钮的功能，就需要给按钮绑定一个单击事件，所以给一个ID以便选择--%>
			<input type="button" value="确定" id="searchPageBtn" style="font-size: 20px">
				<script type="text/javascript">
					$(function () {
						//绑定单击事件，就需要先获取它的参数,这里通过ID获取这个按钮，然后绑定
						$("#searchPageBtn").click(function(){
							//在这个单击事件中，先获取ID是pn_input的文本框中的内容
							var pageNo = $("#pn_input").val();
							//我们获取到这个内容后要判断是否在现有的页码范围内，若不在则报错
							var pageTotal = ${requestScope.page.pageTotal};
							if(pageNo < 1 ||pageNo > pageTotal){
								alert("请输入正确范围内的页码");
							}else {//说明输入了正确页码，这个时候才能跳转
								//然后引入JS语言中的location对象，它有一个href方法，可获取地址栏中的地址，但在这，我们用的是它
								//另一个功能：它还可以设置地址栏中的地址，也就是说，我们把地址栏中的地址续上上面文本框内容，完成转发地址设置
								location.href = "${pageScope.basePath}manager/martServlet?action=page&pageNo="+pageNo;
							}
						})
					})
				</script>
		</div>
		<%--分页条的结束--%>

	</div>
	<br>
	<br>
	<br>
	<%--静态包含页脚内容--%>
	<%@include file="/pageStart/common/footer.jsp"%>


</body>
</html>