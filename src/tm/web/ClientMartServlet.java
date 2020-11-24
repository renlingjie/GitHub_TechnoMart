package tm.web;

import tm.pojo.Mart;
import tm.pojo.Page;
import tm.service.MartService;
import tm.service.impl.MartServiceImpl;
import tm.utils.WebUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ClientMartServlet extends BaseServlet {

    private MartService martService = new MartServiceImpl();
    //传过来的参数为空解决功能,解决不了
    protected String isNull1(String s){

        if(s == null){
            s = "1";
        }
        return s;
    }
    protected String isNull6(String s){

        if(s == null){
            s = "6";
        }
        return s;
    }
    protected String isNull0(String s){

        if(s == null){
            s = "0";
        }
        return s;
    }
    //分页功能
    protected void page(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //System.out.println("接收到UserServlet的请求");
        //1、获取请求的参数pageNo/pageSize
        //这里为什么默认值是1呢？这是因为如果用户一开始点进来，发送分页请求反射到这里的时候，用户由于还没有进去
        //自然还没有点击要跳转的页码，那么默认跳转到第一页
        int pageNo = WebUtils.parseInt(isNull1(req.getParameter("pageNo")),1);
        int pageSize = WebUtils.parseInt(isNull6(req.getParameter("pageSize")),6);//这里我们指定每页6个
        int cateGory = WebUtils.parseInt(isNull0(req.getParameter("category")),0);//获取商品发过来的种类
        //2、调用MartService.page(pageNo，pageSize);这里返回的就是page对象
        Page<Mart> page = martService.page(cateGory,pageNo,pageSize);//这里我们采用pojo.Page，泛型是Mart
        //3、保存page对象到request于中
        req.setAttribute("page",page);
        //4、请求转发到/pageStart/HJJ/products.jsp，转发到的是商品列表的那个页面
        req.getRequestDispatcher("/pageStart/HJJ/products.jsp").forward(req,resp);
    }
}
