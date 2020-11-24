package tm.service.impl;

import tm.dao.MartDao;
import tm.dao.OrderDao;
import tm.dao.OrderItemDao;
import tm.dao.impl.MartDaoImpl;
import tm.dao.impl.OrderDaoImpl;
import tm.dao.impl.OrderItemDaoImpl;
import tm.pojo.*;
import tm.service.OrderService;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class OrderServiceImpl implements OrderService {
    //生成订单 还需要传进来订单和订单项对象，后续要调用他们的保存订单/订单项方法
    private OrderDao orderDao = new OrderDaoImpl();
    private OrderItemDao orderItemDao = new OrderItemDaoImpl();
    private MartDao martDao = new MartDaoImpl();//下单的时候改变销量
    @Override
    public Order createOrder(Cart cart, Integer userId) {
        //生成订单要做的操作其实就是保存订单和订单项，而且顺序是先有订单再有订单项
        //1、创建订单对象
        //每次调用该方法就自动生成一个订单号，为了保证唯一性，我们用时间戳,再为了避免同时下单时间戳都相同，后面再拼接上用户ID
        String orderId = System.currentTimeMillis()+""+userId;
        //将当前时间转换成简洁的格式
        Date nowTime = new Date();
        SimpleDateFormat timeForm = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String newFormTime = timeForm.format(nowTime) ;
        //将上面转好格式的String类型的时间传给Order，创建订单对象
        Order order = new Order(orderId,newFormTime,cart.getTotalPrice(),0,userId);
        //2、调用保存订单的方法
        orderDao.saveOrder(order);
        //3、保存订单项
        //说白了就是将购物车Cart中的每一个CartItem都转换成OrderItem
        //3.1、遍历购物车中每一个商品项转换成为订单项
        for(Map.Entry<Integer, CartItem>entry:cart.getItems().entrySet()){
            CartItem cartItem = entry.getValue();
            OrderItem orderItem = new OrderItem(null,cartItem.getName(),cartItem.getCount(),cartItem.getPrice(),cartItem.getTotalPrice(),orderId);//得到的每一个商品项都是订单项
            //3.2、调用保存订单项的方法
            orderItemDao.saveOrderItem(orderItem);
            //3.3、每遍历一次得到一个商品，就改变这个商品的一次销量（其实也就是一次加一）
            Mart mart = martDao.qureyMartById(cartItem.getId());
            mart.setSales(mart.getSales() + cartItem.getCount());
            martDao.updateMart(mart);
        }
        cart.clear();//结账后清空购物车
        return order;//返回生成的订单号
    }

    @Override
    public List<Order> queryOrdersByUserId(Integer userId) {
        List<Order> list = orderDao.queryOrdersByUserId(userId);
        return list;
    }

    @Override
    public Integer queryStatusByOrderId(String orderId) {
        Integer status = orderDao.queryStatusByOrderId(orderId);
        return status;
    }

    @Override
    public void updateOrderStatus(Integer statusNeed,String orderId) {
        orderDao.updateOrderStatusByStatusNeed(statusNeed,orderId);
    }

    @Override
    public Order queryOrderByOrderId(String orderId) {
        Order order = orderDao.queryOrderByOrderId(orderId);
        return order;
    }
}
