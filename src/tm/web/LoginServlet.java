package tm.web;

import tm.pojo.User;
import tm.service.UserService;
import tm.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取请求参数
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        //2、校验，这里是调用userService中的login方法来实现
        User loginUser = userService.login(new User(null,username,password,null));
        if (loginUser == null) {//为空说明登录失败，重新进入login界面
            System.out.println("用户名或密码错误啦");
            req.setAttribute("msg1","用户名或密码错误");//回显的信息保存在容器msg1中，置于request域中
            req.getRequestDispatcher("/pageStart/HJJ/login.jsp").forward(req,resp);
        }else {//登录成功，进入商城主界面
            System.out.println("欢迎光临");
        }
    }
}
