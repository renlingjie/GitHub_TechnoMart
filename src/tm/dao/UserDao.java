package tm.dao;

import tm.pojo.User;

public interface UserDao {
    /*1、注册*/
    //（1）根据用户名查询用户信息。如果返回null，说明没有这个用户。反之表示查到了，该用户名就不可用了
    public User queryUserByUsername(String username);
    //（2）保存用户信息
    public int saveUser(User user);
    /*2、登录*/
    //根据用户名和密码查询用户。如果返回null，说明用户名或密码错误。反之则正确，可登录
    public User queryUserByUsernameAndPassword(String username,String password);
}
