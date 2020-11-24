package tm.service;

import tm.pojo.OrderItem;

import java.util.List;

public interface OrderItemService {
    //查询所有订单
    public List<OrderItem> queryOrderItemsByOrderId(String orderId);
}
