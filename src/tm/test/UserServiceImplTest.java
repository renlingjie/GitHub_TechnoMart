package tm.test;

import org.junit.Test;
import tm.pojo.User;
import tm.service.UserService;
import tm.service.impl.UserServiceImpl;


public class UserServiceImplTest {
    UserService userService = new UserServiceImpl();
    @Test
    public void registUser() {
        userService.registUser(new User(null,"zaicicishi","6666","309@qq.com"));
    }

    @Test
    //验证登录，只用传递的参数是用户名和密码，下面第一个是错误的用户名和密码，返回的应该是null
    //第二个是正确的用户名和密码，返回的应该为为这个用户本身（详情可见底层的UserDaoImpl中封装的
    //queryUserByUsernameAndPassword的返回值以及）
    public void login() {
        System.out.println(userService.login(new User(null,"4368","sgkfg",null)));
        System.out.println(userService.login(new User(null,"test1","test1",null)));
    }

    @Test
    public void existsUsername() {
        if(userService.existsUsername("test1")){
            System.out.println("用户名已存在");
        }else{
            System.out.println("用户名可用");
        }
    }
}