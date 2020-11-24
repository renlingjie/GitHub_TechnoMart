package tm.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;

public abstract class BaseServlet extends HttpServlet {
    @Override
    //避免405,必须得来一个doGet，不过还是让它实际上执行doPost
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //解决post请求中文乱码问题，一定要在获取请求参数之前调用才有效
        req.setCharacterEncoding("UTF-8");
        //解决响应中文乱码
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        try {
            //获取action业务鉴别字符串，获取相应的业务方法反射对象.获取业务方法的时候获取参数，括号里就不只是action
            Method method = this.getClass().getDeclaredMethod(action,HttpServletRequest.class,HttpServletResponse.class);
            //通过反射调用目标业务方法
            //三个参数分别是：当前对象实例、HttpServletRequest.class的参数、HttpServletResponse.class的参数
            method.invoke(this,req,resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
