package tm.pojo;

import java.util.List;

public class Page<T> {
    public static final Integer PAGE_SIZE = 5;
    //当前页码
    private Integer pageNo;
    //总页码
    private Integer pageTotal;
    //当前页显示数量
    private Integer pageSize = PAGE_SIZE;
    //总记录数
    private  Integer pageTotalCount;
    //当前页数据
    private List<Mart> items;
    //前端发来的分类
    private Integer category;

    public Integer getCategory() {
        return category;
    }

    public void setCategory(Integer category) {
        this.category = category;
    }

    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getPageTotal() {
        return pageTotal;
    }

    public void setPageTotal(Integer pageTotal) {
        this.pageTotal = pageTotal;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getPageTotalCount() {
        return pageTotalCount;
    }

    public void setPageTotalCount(Integer pageTotalCount) {
        this.pageTotalCount = pageTotalCount;
    }

    public List<Mart> getItems() {
        return items;
    }

    public void setItems(List<Mart> items) {
        this.items = items;
    }

    @Override
    public String toString() {
        return "Page{" +
                "pageNo=" + pageNo +
                ", pageTotal=" + pageTotal +
                ", pageSize=" + pageSize +
                ", pageTotalCount=" + pageTotalCount +
                ", items=" + items +
                ", category=" + category +
                '}';
    }
}
