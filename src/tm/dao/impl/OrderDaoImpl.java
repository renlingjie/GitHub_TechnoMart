package tm.dao.impl;

import tm.dao.OrderDao;
import tm.pojo.Order;

import java.util.List;

public class OrderDaoImpl extends BaseDao implements OrderDao {
    @Override
    public int saveOrder(Order order) {
        String sql = "insert into t_order(orderId,createTime,price,status,userId) values(?,?,?,?,?)";
        //将数据库要执行的sql语句已经需要的参数返回给数据库，注意参数顺序应该和前面sql语句"？"代表的参数的顺序对上
        return update(sql,order.getOrderId(),order.getCreateTime(),order.getPrice(),order.getStatus(),order.getUserId());
    }

    @Override
    public List<Order> queryOrdersByUserId(Integer userId) {
        String sql = "select * from t_order where userId= ? ";
        return queryForList(Order.class,sql,userId);
    }

    @Override
    public Integer queryStatusByOrderId(String orderId) {
        String sql = "select status from t_order where orderId= ? ";
        return (Integer) queryForSingleValue(sql,orderId);
    }

    @Override
    public int updateOrderStatusByStatusNeed(Integer statusNeed , String orderId) {
        String sql = "update t_order set status = ? where orderId= ?";
        return update(sql,statusNeed,orderId);
    }

    @Override
    public Order queryOrderByOrderId(String orderId) {
        String sql = "select * from t_order where orderId= ? ";
        return queryForOne(Order.class, sql, orderId);
    }
}
