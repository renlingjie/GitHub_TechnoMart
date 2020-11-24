package tm.service.impl;

import tm.dao.OrderItemDao;
import tm.dao.impl.OrderItemDaoImpl;
import tm.pojo.Order;
import tm.pojo.OrderItem;
import tm.service.OrderItemService;

import java.util.List;

public class OrderItemServiceImpl implements OrderItemService {
    private OrderItemDao orderItemDao = new OrderItemDaoImpl();
    @Override
    public List<OrderItem> queryOrderItemsByOrderId(String orderId) {
        List<OrderItem> list = orderItemDao.queryOrderItemsByOrderId(orderId);
        return list;
    }
}
