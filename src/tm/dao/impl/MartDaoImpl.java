package tm.dao.impl;

import tm.dao.MartDao;
import tm.pojo.Mart;

import java.util.List;

public class MartDaoImpl extends BaseDao implements MartDao {
    @Override
    public int addMart(Mart mart) {//ID自增，所以不写进去，其他的每有一个属性，在后面的values就对应一个占位符
        String sql = "insert into t_mart(name,manufacturer,price,sales,category,img_path) values(?,?,?,?,?,?)";
        return update(sql,mart.getName(),mart.getManufacturer(),mart.getPrice(),mart.getSales(),mart.getCategory(),mart.getImg_path());
    }

    @Override
    public int deleteMartById(Integer id) {
        String sql = "delete from t_mart where id = ?";
        return update(sql,id);
    }

    @Override
    public int updateMart(Mart mart) {
        //该方法以及上面的方法都是调用BaseDao中的update方法，将执行的sql语句的结果放在名为sql的容器中，作为参数传递给update方法
        String sql = "update t_mart set name=?,manufacturer=?,price=?,sales=?,category=?,img_path=? where id=?";
        return update(sql,mart.getName(),mart.getManufacturer(),mart.getPrice(),mart.getSales(),mart.getCategory(),mart.getImg_path(),mart.getId());
    }

    @Override
    //只查询一个Mart对象的方法
    public Mart qureyMartById(Integer id) {//按照老师的意思这里还需要来一个XXX别名，但是这里就不要了
        //String sql = "select name,manufacturer,price,sales,category,img_path as XXX from t_mart where id=?";
        String sql = "select id,name,manufacturer,price,sales,category,img_path from t_mart where id=?";
        return queryForOne(Mart.class,sql,id);
    }

    @Override
    public List<Mart> queryMarts() {//不是通过id查找的，自然不会出现where id=?，不写这个条件，我们看下面的sql语句，实际上意思是输出了所有
        String sql = "select id,name,manufacturer,price,sales,category,img_path from t_mart";//也是没有别名
        return queryForList(Mart.class,sql);
    }

    @Override
    public Integer queryForPageCategoryCount(int category) {
        String sql = "select count(*) from t_mart where category=?";
        Number count = (Number) queryForSingleValue(sql,category);//将操作数据库得到的信息通过该方法进行返回，返回的是number类型(JS的)
        return  count.intValue();
    }
    @Override
    public Integer queryForPageTotalCount() {
        String sql = "select count(*) from t_mart";
        Number count = (Number) queryForSingleValue(sql);//将操作数据库得到的信息通过该方法进行返回，返回的是number类型(JS的)
        return  count.intValue();
    }

    @Override
    public List<Mart> queryForPageItems(int cateGory,int begin, int pageSize) {
        String sql = "select id,name,manufacturer,price,sales,category,img_path from t_mart where category=? limit ?,?";
        return queryForList(Mart.class,sql,cateGory,begin,pageSize);
    }
    @Override
    public List<Mart> queryForPageItem(int begin, int pageSize) {
        String sql = "select id,name,manufacturer,price,sales,category,img_path from t_mart limit ?,?";
        return queryForList(Mart.class,sql,begin,pageSize);
    }
}
