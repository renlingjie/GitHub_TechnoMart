package tm.test;

import org.junit.Test;
import tm.dao.OrderDao;
import tm.dao.impl.OrderDaoImpl;
import tm.pojo.Order;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;

public class OrderDaoTest {
    @Test
    public void saveOrder(){
        OrderDao orderdao = new OrderDaoImpl();
        //orderdao.saveOrder(new Order("12345",new Date(),new BigDecimal(100),0,1));//注意，这里用户ID要写数据库中存在的用户的ID
    }
    @Test
    public void queryOrdersByUserId(){
        OrderDao orderDao = new OrderDaoImpl();
        Integer userId = 89;
        List<Order> list = orderDao.queryOrdersByUserId(userId);
        System.out.println(list);
    }
    @Test
    public void queryStatusByOrderId(){
        OrderDao orderDao = new OrderDaoImpl();
        String orderId = "160076919097211";
        Integer status = orderDao.queryStatusByOrderId(orderId);
        System.out.println(status);
    }
    @Test
    public void updateOrderStatusByStatusNeed(){
        OrderDao orderDao = new OrderDaoImpl();
        String orderId = "160076919097211";
        Integer statusNeed = 2;
        orderDao.updateOrderStatusByStatusNeed(statusNeed,orderId);
    }
}