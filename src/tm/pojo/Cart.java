package tm.pojo;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

//购物车对象
public class Cart {
    //private Integer totalCount;
    //private BigDecimal totalPrice;
    //Map集合，其中key的每一个元素都是CartItem的id，value的每一个元素都是一个CartItem
    private Map<Integer,CartItem> items = new LinkedHashMap<Integer,CartItem>();
    //添加商品项
    public void addItem(CartItem cartItem){
        /*items.add(cartItem);不能直接往CartItem的Map集合的引用items中添加CartItem对象。
        因为这个如果添加的是同一件商品，这样写会新建一个对象，而不是将商品数量+1，因此先判断集合中是否
        已经存在该商品，如果存在，将存在的商品数量+1，总金额累积，不存在再执行items.add(cartItem);*/
        //通过获取传进来的商品对象的ID，作为key去查找Map集合中是否存在此ID对应的value（也就是商品对象）
        CartItem item = items.get(cartItem.getId());
        if(item == null){//说明集合中没有，之前没有添加这个商品
            items.put(cartItem.getId(),cartItem);//那你就添加上，传入这个商品对象的ID和对象本身
        }else {//已经添加，那就数量累加，总金额更新。通过CartItem的引用item调用cartItem对象的get/set方法
            item.setCount(item.getCount() + 1);
            //multiply，乘法，里面传的是BigDecimal，我们就new一个，同时将item的ID传进来
            item.setTotalPrice(item.getPrice().multiply(new BigDecimal(item.getCount())));
        }
    }
    //删除商品项
    public void deleteItem(Integer id){
        items.remove(id);//直接通过Map集合中的key（也就是这里传进来的ID）来删除对应的CartItem对象。
    }
    //清空购物车
    public void clear(){
        items.clear();//直接清空这个集合
    }
    //修改商品数量
    public void updateItem(Integer id,Integer count){
        //先查看购物车中是否有此商品，如果有，则修改商品数量，更新总金额
        //这里传进来的就是ID，所以不像addItem中由于传进来的是对象，还要获取对象的ID
        CartItem item = items.get(id);
        if(item != null){//说明请求修改数量的商品对象确实在Map集合（购物车集合）中存在
            item.setCount(count);//修改商品数量
            item.setTotalPrice(item.getPrice().multiply(new BigDecimal(item.getCount())));//更新总金额
        }
    }
    public Integer getTotalCount() {
        Integer totalCount = 0;
        //遍历引用items对应的Map集合中的每一个键值对
        for(Map.Entry<Integer,CartItem>entry:items.entrySet()){
            //而这里我们只需要每一个键值对的值即可
            totalCount += entry.getValue().getCount();
        }
        return totalCount;
    }


    public BigDecimal getTotalPrice() {
        BigDecimal totalPrice = new BigDecimal(0);
        //遍历引用items对应的Map集合中的每一个键值对
        for(Map.Entry<Integer,CartItem>entry:items.entrySet()){
            //而这里我们只需要每一个键值对的值即可
            totalPrice = totalPrice.add(entry.getValue().getTotalPrice());
        }
        return totalPrice;
    }


    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void setItems(Map<Integer, CartItem> items) {
        this.items = items;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "totalCount=" + getTotalCount() +
                ", totalPrice=" + getTotalPrice() +
                ", items=" + items +
                '}';
    }
}
