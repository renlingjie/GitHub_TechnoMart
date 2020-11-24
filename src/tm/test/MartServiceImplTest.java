package tm.test;

import org.junit.Test;
import tm.pojo.Mart;
import tm.service.MartService;
import tm.service.impl.MartServiceImpl;

import java.math.BigDecimal;

import static org.junit.Assert.*;

public class MartServiceImplTest {
    private MartService martService = new MartServiceImpl();
    @Test
    public void addMart() {
        martService.addMart(new Mart(null,"GX2012","SUN",new BigDecimal(3998),0,2,null));
    }

    @Test
    public void deleteMartById() {
        martService.deleteMartById(3);
    }

    @Test
    public void updateMart() {
        martService.updateMart(new Mart(4,"GX2048","SUN",new BigDecimal(3998),0,2,null));
    }

    @Test
    public void queryMartById() {
        System.out.println(martService.queryMartById(1));
    }

    @Test
    public void queryMarts() {//foreach中，冒号前面的为元素类型、元素变量，后面的为遍历对象。快捷方式为直接打出遍历对象
        //martService.queryMarts()，然后在其后面来一个.for，就会出来foreach选项
        for (Mart queryMart : martService.queryMarts()) {
            System.out.println(martService.queryMarts());
        }
    }

    @Test
    public void page(){
        System.out.println(martService.page(2,3,0));
    }
}