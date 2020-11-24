package tm.dao;

import tm.pojo.Mart;

import java.util.List;

public interface MartDao {
    public int addMart(Mart mart);
    public int deleteMartById(Integer id);
    public int updateMart(Mart mart);
    public Mart qureyMartById(Integer id);//通过ID查询商品，遮盖力返回值类型应该是Mart对象
    public List<Mart> queryMarts();//查询具有某种特征的商品，返回的是一个list集合，个人觉得这里的形参应该就是我们的category
    Integer queryForPageTotalCount();
    Integer queryForPageCategoryCount(int category);
    List<Mart> queryForPageItems(int begin, int pageSize,int category);
    List<Mart> queryForPageItem(int begin, int pageSize);
}
