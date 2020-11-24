package tm.web;

import tm.pojo.User;
import tm.service.UserService;
import tm.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegistServlet extends HttpServlet {
    //这里为了一目明了，使用多态：父类型（UserService）的引用指向子类型（UserServiceImpl）的对象，我们直接去父类型的接口中看它的方法，就很清晰
    private UserService userService = new UserServiceImpl();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取请求参数
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        //2、校验
        if(userService.existsUsername(username)){//看方法，返回true是已存在
            req.setAttribute("msg","用户名重复，请再试");//回显的信息保存在容器msg中，置于request域中
            System.out.println("用户名["+username+"]已存在！");
            req.getRequestDispatcher("/pageStart/HJJ/signup.jsp").forward(req,resp);//这个时候跳转到这个jsp，在这个地方输出msg
            //System.out.println("1");
        }else{//可用,那就调用UserService的registUser将该请求解析的参数保存到数据库
            userService.registUser(new User(null,username,password,email));
            req.getRequestDispatcher("/pageStart/HJJ/login.jsp").forward(req,resp);
        }
    }
}
