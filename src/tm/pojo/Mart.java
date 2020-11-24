package tm.pojo;

import java.math.BigDecimal;

public class Mart {
    private Integer id;
    private String name;
    private String manufacturer;
    private BigDecimal price;
    private Integer sales;
    private Integer category;
    private String img_path = "static/img/";
    //创建一个图书的默认地址，当我们不赋值（addMart中路径参数为null时）的时候，就使用默认值，也就是说会用默认路径的图片

    public Mart() {
    }

    public Mart(Integer id, String name, String manufacturer, BigDecimal price, Integer sales, Integer category, String imgpath) {
        this.id = id;
        this.name = name;
        this.manufacturer = manufacturer;
        this.price = price;
        this.sales = sales;
        this.category = category;
        if(imgpath != null && !"".equals(imgpath)){//要求给定的图片只有当路径不为空且不为空的字符串，我们才能对它进行赋值
            this.img_path = imgpath;
        }

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getSales() {
        return sales;
    }

    public void setSales(Integer sales) {
        this.sales = sales;
    }

    public Integer getCategory() {
        return category;
    }

    public void setCategory(Integer category) {
        this.category = category;
    }

    public String getImg_path() {
        return img_path;
    }

    public void setImg_path(String imgpath) {
        if(imgpath != null && !"".equals(imgpath)){//要求给定的图片只有当路径不为空且不为空的字符串，我们才能对它进行赋值
            this.img_path = imgpath;
        }
    }

    @Override
    public String toString() {
        return "Mart{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", manufacturer='" + manufacturer + '\'' +
                ", price=" + price +
                ", sales=" + sales +
                ", category=" + category +
                ", imgpath='" + img_path + '\'' +
                '}';
    }
}
