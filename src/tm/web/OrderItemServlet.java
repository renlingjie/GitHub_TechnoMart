package tm.web;

import tm.pojo.Cart;
import tm.pojo.Order;
import tm.pojo.OrderItem;
import tm.pojo.User;
import tm.service.OrderItemService;
import tm.service.OrderService;
import tm.service.impl.OrderItemServiceImpl;
import tm.service.impl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class OrderItemServlet extends BaseServlet{
    private OrderItemService orderItemService = new OrderItemServiceImpl();
    private OrderService orderService = new OrderServiceImpl();
    //1、查看一个订单中的所有订单项
    protected void showAllOrderItems(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("orderItem方法执行了");
        //1、获取orderId
        String orderId = req.getParameter("orderId");
        System.out.println("接收客户端的订单编号是"+orderId);
        //2、通过orderId执行Service中的queryOrderItemsByOrderId
        List<OrderItem> list = orderItemService.queryOrderItemsByOrderId(orderId);
        //将得到的list集合保存到session域中
        req.getSession().setAttribute("orderItemList", list);
        //这个主要是获取订单状态，然后在订单详情中显示确认收货/已签收
        Integer status = orderService.queryStatusByOrderId(orderId);
        req.getSession().setAttribute("currentStatus", status);
        //不用请求转发回订单中心了，否则弹窗出来后又会重新出来一个order页面
        //req.getRequestDispatcher("/pageStart/HJJ/order.jsp").forward(req, resp);//同样不能用请求转发，否则F5会使之再次提交多个同样的订单
        resp.sendRedirect(req.getContextPath()+"/pageStart/HJJ/order_item.jsp");
    }
}

