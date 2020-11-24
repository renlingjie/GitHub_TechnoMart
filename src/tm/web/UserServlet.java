package tm.web;

import com.google.gson.Gson;
import com.google.gson.internal.$Gson$Preconditions;
import tm.pojo.User;
import tm.service.UserService;
import tm.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import static com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY;

public class UserServlet extends BaseServlet {
    private UserService userService = new UserServiceImpl();

    protected void regist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取谷歌声明在Session域中的验证码
        String token = (String)req.getSession().getAttribute(KAPTCHA_SESSION_KEY);
        req.getSession().removeAttribute(KAPTCHA_SESSION_KEY);//马上删除，避免它再获取第二次
        //2、获取请求参数
        String code = req.getParameter("code");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        //User user = new User();参数多时就用这个
        //WebUtils.copyParameterToBean(req,user);
        //3.1、校验验证码
        if(token != null && token.equalsIgnoreCase(code)){
            //3.2、校验用户请求信息
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
        else {
            System.out.println("验证码错误啦");
            req.setAttribute("msg2","验证码错误啦");//回显的信息保存在容器msg中，置于request域中
            req.getRequestDispatcher("/pageStart/HJJ/signup.jsp").forward(req,resp);//这个时候跳转到这个jsp，在这个地方输出msg2
        }
    }
    protected void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取请求参数
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        //2、校验用户名密码，这里是调用userService中的login方法来实现
        User loginUser = userService.login(new User(null,username,password,null));
        if (loginUser == null) {//为空说明登录失败，重新进入login界面
            System.out.println("用户名或密码错误啦");
            req.setAttribute("msg1","用户名或密码错误啦");//回显的信息保存在容器msg1中，置于request域中
            req.getRequestDispatcher("/pageStart/HJJ/login.jsp").forward(req,resp);
        }else {//登录成功，进入商城主界面
            System.out.println("欢迎光临");
            //保存用户登录的用户名到Session域中
            req.getSession().setAttribute("username",username);
            //保存用户对象到Session域中（原来只保存了一个用户名，以为就够用了，后面才知道订单还需要用到登录的用户对象的ID）
            req.getSession().setAttribute("user",loginUser);
            //req.getRequestDispatcher("/pageStart/HJJ/products.jsp").forward(req,resp);//不能用，405解决了，但是仍跳转不到页面
            //resp.sendRedirect("pageStart/HJJ/products.jsp");用的是请求重定向，但也不用这个了，因为我们要重定向到CilentMartServlet
            resp.sendRedirect(req.getContextPath()+"/clientMartServlet?action=page");
        }
    }
    protected void ajaxExistsUsername(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1、获取请求的参数username
        String username = req.getParameter("username");
        //2、调用userService.existsUsername();
        boolean existsUsername = userService.existsUsername(username);
        //3、把返回结果封装成为map对象
        Map<String,Object> resultMap = new HashMap<>();
        resultMap.put("existsUsername",existsUsername);
        //4、转换成JSON返回
        Gson gson = new Gson();
        String json = gson.toJson(resultMap);
        //5、通过响应的字符输出流输出来返回
        resp.getWriter().write(json);
    }
}
