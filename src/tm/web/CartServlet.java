package tm.web;

import tm.pojo.Cart;
import tm.pojo.CartItem;
import tm.pojo.Mart;
import tm.service.MartService;
import tm.service.impl.MartServiceImpl;
import tm.utils.WebUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CartServlet extends BaseServlet {
    private MartService martService = new MartServiceImpl();
    //加入购物车
    protected void addItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取请求的参数：商品ID
        int id = WebUtils.parseInt(req.getParameter("martId"),0);//获取请求发来的ID值
        //System.out.println(id);//测试输出
        //2、调用martService.queryMartById(id)得到商品信息
        Mart mart = martService.queryMartById(id);
        //3、把商品信息转换成为CartItem商品项
        CartItem cartItem = new CartItem(mart.getId(),mart.getName(),1,mart.getPrice(),mart.getPrice());//单个商品，单价和总价一样
        //4、调用Cart.daaItem(CartItem)添加商品项
        //我们需要new一个cart对象去接收：Cart cart = new Cart();但是这个不能直接，否则每次请求都会重新new一次，那么商品数量以及总金额都会一直刷新而无法累加
        //我们要做的是查看是否有cart，如果有，则就用这个，如果没有，再new。从哪里查呢？而我们用的是Session版本，因此购物车都是存储在Session域中， 因从从这个域中进行查找
        Cart cart = (Cart)req.getSession().getAttribute("cart");
        if(cart == null){//如果是空，那么我们创建一个
            cart = new Cart();
            //创建好后同样将之放在Session域中。其实第一次查询Session域，都是null，所以自然就执行这个分支了，后续就不执行该分支了
            req.getSession().setAttribute("cart",cart);
        }
        cart.addItem(cartItem);
        //System.out.println(cart);//测试是否已经将商品项添加到cart中了
        //5、重定向回商品列表页面，一般要求都是刚才的下单的那页，所以我们下单的时候要将这页的地址也发送给服务器，然后服务器再用此地址重定向回去
        resp.sendRedirect(req.getHeader("Referer"));
        //6、保存添加到购物车的商品的名称到session域中
        req.getSession().setAttribute("lastName",cartItem.getName());
    }
    protected void deleteItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取请求的参数：商品ID
        int id = WebUtils.parseInt(req.getParameter("martId"),0);//获取请求发来的ID值
        //2、获取购物车对象
        Cart cart = (Cart)req.getSession().getAttribute("cart");
        //3、如果购物车对象不为空，就把ID值对应对CartItem商品项删除
        if(cart != null){
            cart.deleteItem(id);
            //4、删除完之后重定向，和添加一样，从哪来回哪去
            resp.sendRedirect(req.getHeader("Referer"));
        }
    }
    protected void clear(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取购物车对象
        Cart cart = (Cart)req.getSession().getAttribute("cart");
        //2、如果购物车对象不为空，就把购物车中的CartItem商品项删除
        if(cart != null){
            cart.clear();
            //3、清空完之后重定向，和添加一样，从哪来回哪去
            resp.sendRedirect(req.getHeader("Referer"));
        }
    }
    //根据客户端修改购物车的数量，来编写此方法
    protected void updateCount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("购物车数量有变动");
        //1、获取请求的参数
        int id = WebUtils.parseInt(req.getParameter("id"),0);//获取请求发来的ID值
        int count = WebUtils.parseInt(req.getParameter("count"),1);//获取请求发来的count值
        //System.out.println(id);
        //System.out.println(count);
        //2、获取购物车对象
        Cart cart = (Cart)req.getSession().getAttribute("cart");
        //3、如果购物车对象不为空，就把购物车中的CartItem商品项删除
        if(cart != null){
            cart.updateItem(id,count);//调用这个类的updateItem方法，这个方法会修改商品数量，并更新总金额
            //4、修改完之后重定向，和添加一样，从哪来回哪去
            resp.sendRedirect(req.getHeader("Referer"));
        }
    }
}
