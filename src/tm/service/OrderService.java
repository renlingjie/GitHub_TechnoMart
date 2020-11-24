package tm.service;

import tm.pojo.Cart;
import tm.pojo.Order;

import java.util.List;

public interface OrderService {
    //生成订单
    public Order createOrder(Cart cart, Integer userId);
    //查询所有订单
    public List<Order> queryOrdersByUserId(Integer userId);
    //根据"查看详情"发过来的订单编号查询订单状态
    public Integer queryStatusByOrderId(String orderId);
    //根据请求修改订单状态
    public void updateOrderStatus(Integer statusNeed,String orderId);
    //根据发过来的订单编号查询订单信息
    public Order queryOrderByOrderId(String orderId);
}
