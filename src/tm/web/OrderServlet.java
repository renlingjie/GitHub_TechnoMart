package tm.web;

import tm.pojo.Cart;
import tm.pojo.Order;
import tm.pojo.User;
import tm.service.OrderService;
import tm.service.impl.OrderServiceImpl;
import tm.utils.WebUtils;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class OrderServlet extends BaseServlet{
    private OrderService orderService = new OrderServiceImpl();
    //1、生成订单
    protected void createOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("接收到客户端结算请求");
        //1、想要生成订单，首先要获取cart对象，将之变成订单项，同时还要获取用户ID，这两个都保存在session域中
        Cart cart = (Cart) req.getSession().getAttribute("cart");
        User loginUser = (User) req.getSession().getAttribute("user");
        //这里还需要注意一点，如果一开始不是做成我们的那种先登录才能进入网站的，那么用户不登录也可以下单，这个时候用户并没有保存到session域中
        //那么这个时候loginUser会报空指针异常,所以应该加一个判断，若为null，返回登录界面
        Integer userId = loginUser.getId();
        //2、调用orderService,会返回订单号，同时将订单信息保存到数据库中。然后我们将返回的订单号保存到session域中，让客户端进行接收
        Order order = orderService.createOrder(cart, userId);
        req.getSession().setAttribute("userId", userId);
        req.getSession().setAttribute("order", order);//到时候就不用了，而是用list集合遍历输出多个订单
        //req.setAttribute("orderId", orderId);改用重定向，就不能保存在request域了，因为重定向不支持而request域共享。所以是session域
        //3、这个时候转发到showAllOrders，在该方法中执行"连带刚才新建的订单将全部订单展示"
        resp.sendRedirect(req.getContextPath()+"/orderServlet?action=showAllOrders");
    }
    //2、查看所有订单
    protected void showAllOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取userId
        User loginUser = (User) req.getSession().getAttribute("user");
        Integer userId = loginUser.getId();
        System.out.println(userId);
        //2、通过userId执行Service中的queryOrdersByUserId
        List<Order> list = orderService.queryOrdersByUserId(userId);
        //将得到的list集合保存到session域中
        req.getSession().setAttribute("orderList", list);
        //3、请求转发回订单中心
        //req.getRequestDispatcher("/pageStart/HJJ/order.jsp").forward(req, resp);同样不能用请求转发，否则F5会使之再次提交多个同样的订单
        resp.sendRedirect(req.getContextPath()+"/pageStart/HJJ/order.jsp");
    }
    //3、修改订单状态
    protected void updateOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer statusNeed = WebUtils.parseInt(req.getParameter("statusNeed"),0);
        System.out.println("需要修改的订单状态为"+statusNeed);
        String orderId = req.getParameter("orderId");
        System.out.println("接收客户端的订单编号是"+orderId);
        String flag = req.getParameter("flag");
        System.out.println("flag="+flag);
        orderService.updateOrderStatus(statusNeed, orderId);
        if (flag == null){
            //req.getRequestDispatcher("/pageStart/HJJ/order_item.jsp").forward(req,resp);
            req.getRequestDispatcher("/orderItemServlet?action=showAllOrderItems").forward(req,resp);
            //resp.sendRedirect(req.getHeader("Referer"));
        }else{
            //resp.sendRedirect(req.getContextPath()+"/pageStart/HJJ/order_edit.jsp");
            req.getRequestDispatcher("/orderServlet?action=queryOrder&queryOrderId="+orderId).forward(req,resp);
        }
    }
    //4、根据orderId查询订单
    protected void queryOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String queryOrderId = req.getParameter("queryOrderId");
        System.out.println("接收到要查询的orderId为："+queryOrderId);
        Order order = orderService.queryOrderByOrderId(queryOrderId);
        if (order != null){
            req.getSession().setAttribute("orderPojo", order);
            resp.sendRedirect(req.getContextPath()+"/pageStart/HJJ/order_edit_success.jsp");
        }
        else {
            resp.sendRedirect(req.getContextPath()+"/pageStart/HJJ/order_edit.jsp");
        }
    }

}
