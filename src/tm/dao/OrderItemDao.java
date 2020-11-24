package tm.dao;

import tm.pojo.Order;
import tm.pojo.OrderItem;

import java.util.List;

public interface OrderItemDao {
    public int saveOrderItem(OrderItem orderItem);
    public List<OrderItem> queryOrderItemsByOrderId(String orderId);//查询订单项，返回的是一个list集合
}
