package tm.service;

import tm.pojo.Mart;
import tm.pojo.Page;

import java.util.List;

public interface MartService {
    public void addMart(Mart mart);
    public void deleteMartById(Integer id);
    public void updateMart(Mart mart);
    public Mart queryMartById(Integer id);
    public List<Mart> queryMarts();
    Page<Mart> page(int category,int pageNo, int pageSize);
}
