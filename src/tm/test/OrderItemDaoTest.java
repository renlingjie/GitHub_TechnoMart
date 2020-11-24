package tm.test;

import org.junit.Test;
import tm.dao.OrderDao;
import tm.dao.OrderItemDao;
import tm.dao.impl.OrderDaoImpl;
import tm.dao.impl.OrderItemDaoImpl;
import tm.pojo.Order;
import tm.pojo.OrderItem;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;

public class OrderItemDaoTest {
    @Test
    public void saveOrderItem(){
        OrderItemDao orderItemDao = new OrderItemDaoImpl();
        orderItemDao.saveOrderItem(new OrderItem(null,"智能音箱",1,new BigDecimal(698),new BigDecimal(698),"12345"));//注意，这里用户ID要写数据库中存在的用户的ID
    }
    @Test
    public void queryOrderItemsByOrderId(){
        OrderItemDao orderItemDao = new OrderItemDaoImpl();
        String orderId = "160178971990810";
        List<OrderItem> list = orderItemDao.queryOrderItemsByOrderId(orderId);
        System.out.println(list);
    }
}