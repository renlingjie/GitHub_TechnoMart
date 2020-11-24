package tm.dao;

import tm.pojo.Order;

import java.util.List;

public interface OrderDao {
    public int saveOrder(Order order);
    public List<Order> queryOrdersByUserId(Integer userId);//查询订单，返回的是一个list集合
    public Integer queryStatusByOrderId(String orderId);//根据订单详情发过来的订单号来查询订单号对应的订单状态
    public int updateOrderStatusByStatusNeed(Integer statusNeed, String orderId);//根据发过来的请求更改的状态值修改对应订单好的状态值
    public Order queryOrderByOrderId(String orderId);//根据客户端发过来的滚蛋好查询订单信息
}
