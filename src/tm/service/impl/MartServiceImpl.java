package tm.service.impl;

import tm.dao.MartDao;
import tm.dao.impl.MartDaoImpl;
import tm.pojo.Mart;
import tm.pojo.Page;
import tm.service.MartService;

import java.util.List;

public class MartServiceImpl implements MartService {
    private MartDao martDao = new MartDaoImpl();
    @Override
    public void addMart(Mart mart) {
        martDao.addMart(mart);
    }

    @Override
    public void deleteMartById(Integer id) {
        martDao.deleteMartById(id);
    }

    @Override
    public void updateMart(Mart mart) {
        martDao.updateMart(mart);
    }

    @Override
    public Mart queryMartById(Integer id) {
        return martDao.qureyMartById(id);
    }

    @Override
    public List<Mart> queryMarts() {
        return martDao.queryMarts();
    }

    @Override
    public Page<Mart> page(int category,int pageNo, int pageSize) {
        //想要获取前端请求的参数，就需要先创建一个page对象，然后调用get/set方法对该对象对属性值进行赋值
        Page<Mart> page = new Page<Mart>();
        page.setCategory(category);
        int cateGory = page.getCategory();
        //1、保存每页显示的数量
        page.setPageSize(pageSize);
        //2.1、求总记录条数（该方法需通过调用Dao层的方法对数据库进行操作，故在Dao层创建一个该名称对应的方法）
        Integer pageTotalCount;
        if(cateGory != 0){
            pageTotalCount = martDao.queryForPageCategoryCount(cateGory);
        }else {
            pageTotalCount = martDao.queryForPageTotalCount();
        }

        //2.1、保存总记录条数
        page.setPageTotalCount(pageTotalCount);
        //3.1、求总页码
        Integer pageTotal = pageTotalCount/pageSize;
        if(pageTotalCount%pageSize > 0 ){
            pageTotal++;
        }
        //3.2、保存总页码
        page.setPageTotal(pageTotal);
        //4.1、数据边界检查(防止前端指定页面跳转时有人在地址栏中输入不合法的页码)
        if (pageNo < 1){
            pageNo = 1;
        }
        if(pageNo > pageTotal){
            pageNo = pageTotal;
        }
        //4.2、保存当前页码（当数据边界检查保证页码正确后，再保存）
        page.setPageNo(pageNo);
        //5.1、获取当前页数据
        int begin = (page.getPageNo() - 1)*pageSize;
        List<Mart> items;
        if(cateGory != 0){
             items = martDao.queryForPageItems(cateGory,begin,pageSize);
        }else{
             items = martDao.queryForPageItem(begin,pageSize);
        }
        //5.2、保存当前页数据
        page.setItems(items);
        return page;

    }
}
