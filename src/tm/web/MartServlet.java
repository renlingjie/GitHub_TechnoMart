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
import java.util.List;

public class MartServlet extends BaseServlet {
    private MartService martService = new MartServiceImpl();
    protected void add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //获取客户端发过来的最后一页，我们要往最后一页跳转
        int pageNo = WebUtils.parseInt(req.getParameter("pageNo"),0);
        //但有一个问题，若你添加的商品导致页面加1，那么发过来的就是老页面最大值了，这个时候解决办法是无论是否页面加1，我都让它加1，因为超限，会返回最大页码
        pageNo++;
        //1、获取请求的参数，并封装成为Mart对象
        Mart mart = WebUtils.copyParameterToBean(req.getParameterMap(),new Mart());//调用该方法将用户信息封装成了Mart对象返回了
        //2、调用MartService.addMart()保存商品
        martService.addMart(mart);//将上面封装得到的mart对象作为实参传递到martService的addMart方法中
        //3、跳到商品列表页面
        //F5会有Bug，所以不用：req.getRequestDispatcher("/manager/martServlet?action=list").forward(req,resp);
        //相较于重定向，还需要加一个工程名,同时因为是添加，跳转到客户端发过来到最后一页上
        resp.sendRedirect(req.getContextPath()+"/manager/martServlet?action=page&pageNo="+pageNo);
    }
    protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取到要删除商品的ID（由于得到的是字符串，因此需要调用封装的工具类进行转换）
        int id = WebUtils.parseInt(req.getParameter("id"),0);//这里面我们将默认值设为0
        //2、根据所获得的ID调用MartService的deleteMartById()方法从数据库中删除该ID对应的信息
        martService.deleteMartById(id);
        //3、同样是反射list，刷新列表
        resp.sendRedirect(req.getContextPath()+"/manager/martServlet?action=page&pageNo="+req.getParameter("pageNo"));
    }
    protected void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取请求参数，封装成为Mart对象
        Mart mart = WebUtils.copyParameterToBean(req.getParameterMap(),new Mart());
        //2、调用MartService.updateMart(mart)修改商品
        martService.updateMart(mart);
        //3、重定向回list刷新
        resp.sendRedirect(req.getContextPath()+"/manager/martServlet?action=page&pageNo="+req.getParameter("pageNo"));
    }
    protected void getMart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取请求的商品编号（我们在"修改"超链接中也将ID的值一并转发，不过也是字符串，也需要调用WebUtils中的parseInt方法）
        int id = WebUtils.parseInt(req.getParameter("id"),0);//这里面我们将默认值设为0
        //2、调用martService.queryMartById方法查询接收到的ID对应的商品
        Mart mart = martService.queryMartById(id);
        //3、保存查询到的mart对象到request域中
        req.setAttribute("mart",mart);
        //4、请求转发到mart_edit.jsp中
        req.getRequestDispatcher("/pageStart/HJJ/mart_edit.jsp").forward(req,resp);
    }
    //列表的查询，其实通过id查询用处不多，我们用不到，因为我们都是从所有里面筛选出我们需要的
    protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、在此查询出全部商品
        List<Mart> marts = martService.queryMarts();
        //2、将商品全部保存到request域中
        req.setAttribute("marts",marts);
        //3、请求转发给pageStart/HJJ/mart_manager.jsp页面
        System.out.println("信息都保存到request域中了");
        req.getRequestDispatcher("/pageStart/HJJ/mart_manager.jsp").forward(req,resp);
    }
    //分页功能
    //传过来的参数为空解决功能,解决不了
    protected String isNull1(String s){

        if(s == null){
            s = "1";
        }
        return s;
    }
    protected String isNull5(String s){//默认值是5

        if(s == null){
            s = "5";
        }
        return s;
    }
    protected String isNull0(String s){

        if(s == null){
            s = "0";
        }
        return s;
    }
    protected void page(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取请求的参数pageNo/pageSize
        //这里为什么默认值是1呢？这是因为如果用户一开始点进来，发送分页请求反射到这里的时候，用户由于还没有进去
        //自然还没有点击要跳转的页码，那么默认跳转到第一页
        int pageNo = WebUtils.parseInt(isNull1(req.getParameter("pageNo")),1);
        int pageSize = WebUtils.parseInt(isNull5(req.getParameter("pageSize")), Page.PAGE_SIZE);//如果前端没有指定，那就用默认值（在pojo中已经定义为4）
        int cateGory = WebUtils.parseInt(isNull0(req.getParameter("category")),0);
        //2、调用MartService.page(pageNo，pageSize);这里返回的就是page对象
        // 因为我们后续添加了一个功能：分类，所以page这个方法我们多了一个参数category,该参数实际上是分类用的，所以在MartServlet.java中是用不到的，但是
        //这个方法毕竟有此参数，因此我们由manager_manu提交过来的请求中加了一个&category=0，然后跳转到martService的page方法中去判断，由于是0，实际上执行的还是原来两个参数的方法
        Page<Mart> page = martService.page(cateGory,pageNo,pageSize);//这里我们采用pojo.Page，泛型是Mart
        //3、保存page对象到request于中
        req.setAttribute("page",page);
        //4、请求转发到/pageStart/HJJ/mart_manager.jsp
        //System.out.println("信息都保存到request域中了");
        req.getRequestDispatcher("/pageStart/HJJ/mart_manager.jsp").forward(req,resp);
    }
}
