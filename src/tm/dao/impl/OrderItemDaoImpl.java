package tm.dao.impl;

import tm.dao.OrderItemDao;
import tm.pojo.Order;
import tm.pojo.OrderItem;

import java.util.List;

public class OrderItemDaoImpl extends BaseDao implements OrderItemDao {
    @Override
    public int saveOrderItem(OrderItem orderItem) {
        String sql = "insert into t_order_item(name,count,price,totalPrice,orderId) values(?,?,?,?,?)";//ID自增不写
        //将数据库要执行的sql语句已经需要的参数返回给数据库，注意参数顺序应该和前面sql语句"？"代表的参数的顺序对上
        return update(sql,orderItem.getName(),orderItem.getCount(),orderItem.getPrice(),orderItem.getTotalPrice(),orderItem.getOrderId());
    }

    @Override
    public List<OrderItem> queryOrderItemsByOrderId(String orderId) {
        String sql = "select * from t_order_item where orderId= ? ";
        return queryForList(OrderItem.class,sql,orderId);
    }
}
