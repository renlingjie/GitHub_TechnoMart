<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%--用JSTL遍历集合所需要用的包--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <script type="text/javascript" src="static/jquery-3.1.1.min.js"></script>
    <meta charset="utf-8">
    <title>Products</title>
    <%@ include file="/pageStart/common/base.jsp"%>
    <!-- 样式一：引入压缩后的bootstrap（带min）框架，该框架能够自适应于台式机、平板电脑和手机 -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet">
    <!-- 样式二：网页标签的样式 -->
    <link rel="stylesheet" href="static/css/tooplate-main.css">
    <link rel="stylesheet" href="static/css/managerPush.css">

  </head>
  <body>

  <script>
    <%--我们发现当请求重定向后的页面是嵌套在前一个iframe标签中的，我们需要将这个页面置顶，也就是将这个页面最大化--%>
    if(window != window.top){
      window.top.location=location;
    }
    <%--触发"后台管理"单击事件的时候，执行Show--%>
    function Show(){
      document.getElementById('shade').classList.remove('hide');
      document.getElementById('modal').classList.remove('hide');
    }
    function Hide(){
      document.getElementById('shade').classList.add('hide');
      document.getElementById('modal').classList.add('hide');
    }
  </script>
  <c:if test="${session.getAttribute(msgX)!=null}">
    <h1>${sessionScope.msgX}</h1>
  </c:if>
  <%--上面Show/Hide作用的表单--%>
  <div id="shade" class="c1 hide"></div><%--表单边框--%>
  <div id="modal" class="c2 hide">
    <form class="login-form" action="http://localhost:8080/technoMart/managerServlet" method="post">
      <input type="hidden" name="action" value="loginManager">
      <%--= session.getAttribute("msgX")==null?:session.getAttribute("msgX")--%>
      <label>
        <span class="spanStyle" style="font-size: 17px">后台管理权限请求失败则跳转回当前页面</span>
      </label>
      <label>
        <span class="spanStyle">管理员账号：</span><input type="text" name="account" required placeholder="Account">
      </label>
      <label >
        <span class="spanStyle">管理员密码：</span><input type="text" name="password" required placeholder="Password">
      </label>
      <input type="submit" value="确定" id="yes">
      <input type="button" value="取消" onclick="Hide();">
    </form>
  </div>

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
  <!-- 导航,去往不同的页面 -->
  <%--nav标签，只起语义的作用，也就是告诉人们这块区域是导航链接部分，没有实际的显示效果--%>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top"><%--可以看出，class后面根了多个类，每个类都用空格隔开，那么这两个类
  都对这个元素（这里是nav标签）起作用，如果产生冲突，那么后面的类将替代前面的类--%>
    <div class="container"><%--bootstrap.min.css中规定了container类的格式：宽度100%，内容在div中左右各15px--%>
      <span class="navbar-brand"><img src="static/img/header-logo.png" alt=""></span><%--alt属性规定在图像无法显示时的替代文本，同时如果图片显示，鼠标悬停于上会显示alt属性的内容--%>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="/technoMart/pageStart/HJJ/pageStart.jsp">注册/登录</a><!--去往注册登录页面-->
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/technoMart/pageStart/HJJ/carts.jsp">我的购物车</a><!--去往购物车页面-->
          </li>
          <li class="nav-item">
            <a class="nav-link" style="cursor:pointer" onclick="window.open('orderServlet?action=showAllOrders')">订单中心</a><!--去往订单详情页面-->
          </li>
          <li class="nav-item">
            <%--SSS<a class="nav-link" href="/technoMart/pageStart/HJJ/manager.jsp">后台管理</a><!--去往后台管理页面-->--%>
            <span class="nav-link" onclick="Show()" style="cursor: pointer">后台管理</span>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- 菜单栏提示 -->
  <div class="featured-page">
    <div class="container">
      <div class="row">
        <div class="col-md-4 col-sm-12">
          <div class="section-heading">
            <div class="line-dec"></div>
            <h1 style="color: olivedrab">Hi 亲爱的「<span style="color:orangered;">${sessionScope.username}</span>」(•‾⌣‾•)❤</h1>
            <c:if test="${not empty sessionScope.cart.items}">
            <h1 style="color: olivedrab;">您的购物车中有「<span style="color:orangered;">${sessionScope.cart.totalCount}</span>」件商品，您刚刚
              将「<span style="color:orangered;">${sessionScope.lastName}</span>」加入了购物车</h1>
            </c:if>
            <c:if test="${empty sessionScope.cart.items}">
            <h1 style="color: olivedrab;">您的购物车空空如也(°皿°)，选择您喜欢的商品下单吧～</h1>
            </c:if>
          </div>
        </div>
        <div class="col-md-8 col-sm-12" style="margin-top: 20px;">
          <div id="filters" class="button-group" style="margin-top: 35px;"><!--应该在这里绑定单击事件-->
            <button class="btn btn-primary" id="all" style="color: #e83e8c">All</button>
            <%--test1--%>
            <script type="text/javascript" >
              $(function () {
                $("#all").click(function(){
                  window.location.href = "${pageScope.basePath}clientMartServlet?action=page&category=0";
                })
              })
            </script>
            <button class="btn btn-primary" id="book" style="color: #20c997">Book</button>
            <%--test2--%>
            <script type="text/javascript" >
              $(function () {
                $("#book").click(function(){
                  window.location.href = "${pageScope.basePath}clientMartServlet?action=page&category=1";
                })
              })
            </script>
            <button class="btn btn-primary" id="electron" style="color: #9fcdff">Electron</button>
            <%--test3--%>
            <script type="text/javascript" >
              $(function () {
                $("#electron").click(function(){
                  window.location.href = "${pageScope.basePath}clientMartServlet?action=page&category=2";
                })
              })
            </script>
            <button class="btn btn-primary" id="course" style="color: #ffe57d">Course</button>
            <%--test4--%>
            <script type="text/javascript" >
              $(function () {
                $("#course").click(function(){
                  window.location.href = "${pageScope.basePath}clientMartServlet?action=page&category=3";
                })
              })
            </script>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--商品标签的开始-->
  <div class="featured container no-gutter">
      <div class="row posts">
          <c:forEach items="${requestScope.page.items}" var="mart">
          <div class="item new col-md-4" >

              <div class="featured-item"  id="imgBox"><%--imgbox/imgAuto完成图片缩放与定位--%>
                <%--<img src="static/img/product-01.jpg" alt="">--%>
                <img src="static/img/${mart.name}.jpg" alt="" id="imgAuto">
                <div style="position:absolute; 	bottom: 30px;">
                  <h4>商品名称：${mart.name}</h4>
                  <h4>生产厂家：${mart.manufacturer}</h4>
                  <h4>商品销量：${mart.sales}</h4>
                  <h5 style="color: #c82333">商品价格：¥${mart.price}</h5>
                  <a href="cartServlet?action=addItem&martId=${mart.id}"><!--点击购物车按钮，请求转发给CartServlet的addItem方法，执行加入商品项的操作,同时需要将商品编号传过去-->
                    <img src="static/img/cart.jpeg" style="height: 40px;width: 40px; position:absolute;bottom:12px;left:250px;border:3px;" alt="">
                  </a>
                </div>
              </div>

          </div>
          </c:forEach>
      </div>
  </div>
  <!--商品标签的结束-->
<%--根据不同的category（该category是那四个按钮提交给服务器，服务器有保存在request域中的）执行不同的分页标签，其
实大同小异，主要就是将提交的请求（比如首页、末页之类的）都加上category的值，从而根据不同的值在服务器中获取不同的总页
码以及商品，然后根据总页码以及商品求出其他属性，进而使用这些属性构建出不同种类商品对应的分页条--%>
  <c:choose>
  <c:when test="${requestScope.page.category == 0}">
    <%--分页条的开始--%>
    <div id="divPage">
        <%--我们要实现一个功能：若是首页则不显示"上一页"，如果是末页则不显示"下一页，此时就要调用JSTL的c标签库中的if标签"--%>
        <%--大于首页，才显示--%>
      <c:if test="${requestScope.page.pageNo > 1}">
        <a href="clientMartServlet?action=page&pageNo=1">首页</a>
        <a href="clientMartServlet?action=page&pageNo=${requestScope.page.pageNo-1}">上一页</a>
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
          <a href="clientMartServlet?action=page&pageNo=${i}">${i}</a>
        </c:if>
      </c:forEach>
        <%--页码输出的结束--%>
        <%--小于末页，才显示--%>
      <c:if test="${requestScope.page.pageNo < requestScope.page.pageTotal}">
        <a href="clientMartServlet?action=page&pageNo=${requestScope.page.pageNo+1}">下一页</a>
        <a href="clientMartServlet?action=page&pageNo=${requestScope.page.pageTotal}">末页</a>
      </c:if>
      共${requestScope.page.pageTotal}页，${requestScope.page.pageTotalCount}条记录
      到第<input value="" name="pn" id="pn_input" />页

        <%--想要实现下面按钮的功能，就需要给按钮绑定一个单击事件，所以给一个ID以便选择--%>
      <input type="button" value="确定" id="searchPageBtn">
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
              location.href = "${pageScope.basePath}clientMartServlet?action=page&pageNo="+pageNo;
            }
          })
        })
      </script>
    </div>
    <%--分页条的结束--%>
  </c:when>
  <c:when test="${requestScope.page.category ==1}">
    <%--分页条的开始--%>
    <div id="divPage">
        <%--我们要实现一个功能：若是首页则不显示"上一页"，如果是末页则不显示"下一页，此时就要调用JSTL的c标签库中的if标签"--%>
        <%--大于首页，才显示--%>
      <c:if test="${requestScope.page.pageNo > 1}">
        <a href="clientMartServlet?action=page&pageNo=1&category=1">首页</a>
        <a href="clientMartServlet?action=page&pageNo=${requestScope.page.pageNo-1}&category=1">上一页</a>
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
          <a href="clientMartServlet?action=page&pageNo=${i}">${i}</a>
        </c:if>
      </c:forEach>
        <%--页码输出的结束--%>
        <%--小于末页，才显示--%>
      <c:if test="${requestScope.page.pageNo < requestScope.page.pageTotal}">
        <a href="clientMartServlet?action=page&pageNo=${requestScope.page.pageNo+1}&category=1">下一页</a>
        <a href="clientMartServlet?action=page&pageNo=${requestScope.page.pageTotal}&category=1">末页</a>
      </c:if>
      共${requestScope.page.pageTotal}页，${requestScope.page.pageTotalCount}条记录
      到第<input value="" name="pn" id="pn_input" />页

        <%--想要实现下面按钮的功能，就需要给按钮绑定一个单击事件，所以给一个ID以便选择--%>
      <input type="button" value="确定" id="searchPageBtn">
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
              location.href = "${pageScope.basePath}clientMartServlet?action=page&category=1&pageNo="+pageNo;
            }
          })
        })
      </script>
    </div>
    <%--分页条的结束--%>
  </c:when>
  <c:when test="${requestScope.page.category ==2 }">
    <%--分页条的开始--%>
    <div id="divPage">
        <%--我们要实现一个功能：若是首页则不显示"上一页"，如果是末页则不显示"下一页，此时就要调用JSTL的c标签库中的if标签"--%>
        <%--大于首页，才显示--%>
      <c:if test="${requestScope.page.pageNo > 1}">
        <a href="clientMartServlet?action=page&pageNo=1&category=2">首页</a>
        <a href="clientMartServlet?action=page&pageNo=${requestScope.page.pageNo-1}&category=2">上一页</a>
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
          <a href="clientMartServlet?action=page&category=2&pageNo=${i}">${i}</a>
        </c:if>
      </c:forEach>
        <%--页码输出的结束--%>
        <%--小于末页，才显示--%>
      <c:if test="${requestScope.page.pageNo < requestScope.page.pageTotal}">
        <a href="clientMartServlet?action=page&category=2&pageNo=${requestScope.page.pageNo+1}">下一页</a>
        <a href="clientMartServlet?action=page&category=2&pageNo=${requestScope.page.pageTotal}">末页</a>
      </c:if>
      共${requestScope.page.pageTotal}页，${requestScope.page.pageTotalCount}条记录
      到第<input value="" name="pn" id="pn_input" />页

        <%--想要实现下面按钮的功能，就需要给按钮绑定一个单击事件，所以给一个ID以便选择--%>
      <input type="button" value="确定" id="searchPageBtn">
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
              location.href = "${pageScope.basePath}clientMartServlet?action=page&category=2&pageNo="+pageNo;
            }
          })
        })
      </script>
    </div>
    <%--分页条的结束--%>
  </c:when>
  <c:when test="${requestScope.page.category ==3 }">
    <%--分页条的开始--%>
    <div id="divPage">
        <%--我们要实现一个功能：若是首页则不显示"上一页"，如果是末页则不显示"下一页，此时就要调用JSTL的c标签库中的if标签"--%>
        <%--大于首页，才显示--%>
      <c:if test="${requestScope.page.pageNo > 1}">
        <a href="clientMartServlet?action=page&category=3&pageNo=1">首页</a>
        <a href="clientMartServlet?action=page&category=3&pageNo=${requestScope.page.pageNo-1}">上一页</a>
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
          <a href="clientMartServlet?action=page&category=3&pageNo=${i}">${i}</a>
        </c:if>
      </c:forEach>
        <%--页码输出的结束--%>
        <%--小于末页，才显示--%>
      <c:if test="${requestScope.page.pageNo < requestScope.page.pageTotal}">
        <a href="clientMartServlet?action=page&category=3&pageNo=${requestScope.page.pageNo+1}">下一页</a>
        <a href="clientMartServlet?action=page&category=3&pageNo=${requestScope.page.pageTotal}">末页</a>
      </c:if>
      共${requestScope.page.pageTotal}页，${requestScope.page.pageTotalCount}条记录
      到第<input value="" name="pn" id="pn_input" />页

        <%--想要实现下面按钮的功能，就需要给按钮绑定一个单击事件，所以给一个ID以便选择--%>
      <input type="button" value="确定" id="searchPageBtn">
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
              location.href = "${pageScope.basePath}clientMartServlet?action=page&category=3&pageNo="+pageNo;
            }
          })
        })
      </script>
    </div>
    <%--分页条的结束--%>
  </c:when>
  </c:choose>

  </body>
</html>