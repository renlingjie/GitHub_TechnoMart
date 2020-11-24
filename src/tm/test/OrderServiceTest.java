package tm.test;

import org.junit.Test;
import tm.pojo.Cart;
import tm.pojo.CartItem;
import tm.service.OrderService;
import tm.service.impl.OrderServiceImpl;

import java.math.BigDecimal;


public class OrderServiceTest {
    @Test
    public void createOrder(){
        Cart cart = new Cart();
        cart.addItem(new CartItem(1,"鬼谷子",1,new BigDecimal(100.00),new BigDecimal(100.00)));
        cart.addItem(new CartItem(1,"鬼谷子",1,new BigDecimal(100.00),new BigDecimal(100.00)));
        cart.addItem(new CartItem(2,"鬼谷子111",1,new BigDecimal(200.00),new BigDecimal(200.00)));
        OrderService orderService = new OrderServiceImpl();
        System.out.println("订单号是："+orderService.createOrder(cart, 1));
    }
    @Test
    public void queryOrderByOrderId(){
       OrderService orderService = new OrderServiceImpl();
        System.out.println("对应的订单是"+orderService.queryOrderByOrderId("160076726526211"));
    }
}