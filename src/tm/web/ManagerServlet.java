package tm.web;

import tm.pojo.Manager;
import tm.pojo.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ManagerServlet extends BaseServlet{
    protected void loginManager(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取请求参数
        String account = req.getParameter("account");
        String password = req.getParameter("password");
        //2、校验用户名密码，这里是调用userService中的login方法来实现
        Manager loginManager = new Manager();
        if (loginManager.getManagerName().equals(account) && loginManager.getManagerPassword().equals(password)) {
            System.out.println("欢迎光临");
            //保存管理者对象到Session域中
            req.getSession().setAttribute("manager",loginManager);
            //resp.sendRedirect(req.getContextPath()+"/pageStart/HJJ/manager.jsp");
            resp.sendRedirect(req.getContextPath()+"/manager/martServlet?action=page&category=0");
        }else {//登录失败，错误回显
            System.out.println("用户名或密码错误啦");
            req.getSession().setAttribute("msgX","账号或密码错误啦");//回显的信息保存在容器msgX中，置于session域中
            resp.sendRedirect(req.getHeader("Referer"));
        }

    }
}
