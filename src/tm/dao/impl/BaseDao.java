package tm.dao.impl;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import tm.utils.JdbcUtils;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public abstract class BaseDao {//这个类主要是给别的程序复用代码的，所以定义成抽象类就行
    private QueryRunner queryRunner = new QueryRunner();
    //更新（插入、更新、删除）JavaBean对象，也就是我们建立的User类
    public int update(String sql,Object ... args){
        //调用我们的JdbcUtils.java封装类里面的建立连接的方法
        Connection connection = JdbcUtils.getConnection();
        try {//对update进行捕捉异常
            return queryRunner.update(connection,sql,args);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JdbcUtils.close(connection);
        }
        return -1;
    }
    /**
     * type  返回的对象类型
     * sql  执行的sql语句
     * args  sql对应的参数值
     * <T>  返回的类型的泛型
     */
    //查询返回一个javaBean的sql语句（如返回id是3的user对象数据）
    public <T> T queryForOne(Class<T> type,String sql,Object ... args){
        Connection con =JdbcUtils.getConnection();
        try {//对query进行捕捉异常
            return queryRunner.query(con,sql,new BeanHandler<T>(type),args);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JdbcUtils.close(con);
        }
        return null;
    }
    //查询返回多个javaBean的sql语句（如返回id是从2～18的user对象数据）
    public <T>List<T> queryForList(Class<T> type,String sql,Object ... args){
        Connection con =JdbcUtils.getConnection();
        try {//对query进行捕捉异常
            //System.out.println(queryRunner.query(con,sql,new BeanListHandler<T>(type),args));
            return queryRunner.query(con,sql,new BeanListHandler<T>(type),args);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JdbcUtils.close(con);
        }
        return null;
    }
    //查询返回单个值（如最高的薪资、最小的年龄）的sql语句
    public Object queryForSingleValue(String sql,Object ... args){
        Connection con = JdbcUtils.getConnection();
        try {//对query进行捕捉异常
            return queryRunner.query(con,sql,new ScalarHandler(),args);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JdbcUtils.close(con);
        }
        return null;
    }
}
