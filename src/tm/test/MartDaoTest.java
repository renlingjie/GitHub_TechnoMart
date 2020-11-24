package tm.test;

import org.junit.Test;
import tm.dao.MartDao;
import tm.dao.impl.MartDaoImpl;
import tm.pojo.Mart;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.Assert.*;

public class MartDaoTest {
    private MartDao martDao = new MartDaoImpl();
    @Test
    public void addMart() {
        martDao.addMart(new Mart(null,"科技简史","ASD",new BigDecimal(98),0,1,null));//如果这里不赋值我们就会使用默认值
    }

    @Test
    public void deleteMartById() {
        martDao.deleteMartById(2);
    }

    @Test
    public void updateMart() {
        martDao.updateMart(new Mart(2,"科技简史","ASD",new BigDecimal(998),0,1,null));
    }

    @Test
    public void qureyMartById() {
        Mart mart = martDao.qureyMartById(2);
        System.out.println(mart);
    }

    @Test
    public void queryMarts() {
        for (Mart queryMart : martDao.queryMarts()) {
            System.out.println(queryMart);
        }
    }

    @Test
    public void queryForPageTotalCount() {
        System.out.println(martDao.queryForPageTotalCount());
    }

    @Test
    public void queryForPageItems() {
        for(Mart mart :martDao.queryForPageItems(0,3,0)){
            System.out.println(mart);
        }
    }
}