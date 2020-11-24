package tm.test;

import org.junit.Test;
import tm.pojo.Cart;
import tm.pojo.CartItem;

import java.math.BigDecimal;

import static org.junit.Assert.*;

public class CartTest {

    @Test
    public void addItem() {
        Cart cart = new Cart();
        cart.addItem(new CartItem(1,"鬼谷子",1,new BigDecimal(100.00),new BigDecimal(100.00)));
        cart.addItem(new CartItem(1,"鬼谷子",1,new BigDecimal(100.00),new BigDecimal(100.00)));
        cart.addItem(new CartItem(2,"鬼谷子111",1,new BigDecimal(200.00),new BigDecimal(200.00)));
        System.out.println(cart);
    }

    @Test
    public void deleteItem() {
        Cart cart = new Cart();//我们还是得先add一些，然后才能删除，我们用上面的，然后删除ID是1的
        cart.addItem(new CartItem(1,"鬼谷子",1,new BigDecimal(100.00),new BigDecimal(100.00)));
        cart.addItem(new CartItem(1,"鬼谷子",1,new BigDecimal(100.00),new BigDecimal(100.00)));
        cart.addItem(new CartItem(2,"鬼谷子111",1,new BigDecimal(200.00),new BigDecimal(200.00)));
        cart.deleteItem(1);
        System.out.println(cart);
    }

    @Test
    public void clear() {
        Cart cart = new Cart();//我们还是得先add一些，然后才能删除，我们用上面的，然后删除ID是1的
        cart.addItem(new CartItem(1,"鬼谷子",1,new BigDecimal(100.00),new BigDecimal(100.00)));
        cart.addItem(new CartItem(1,"鬼谷子",1,new BigDecimal(100.00),new BigDecimal(100.00)));
        cart.addItem(new CartItem(2,"鬼谷子111",1,new BigDecimal(200.00),new BigDecimal(200.00)));
        cart.clear();
        System.out.println(cart);
    }

    @Test
    public void updateItem() {
        Cart cart = new Cart();//我们还是得先add一些，然后才能删除，我们用上面的，然后删除ID是1的
        cart.addItem(new CartItem(1,"鬼谷子",1,new BigDecimal(100.00),new BigDecimal(100.00)));
        cart.addItem(new CartItem(1,"鬼谷子",1,new BigDecimal(100.00),new BigDecimal(100.00)));
        cart.addItem(new CartItem(2,"鬼谷子111",1,new BigDecimal(200.00),new BigDecimal(200.00)));
        cart.updateItem(1,3);
        System.out.println(cart);
    }
}