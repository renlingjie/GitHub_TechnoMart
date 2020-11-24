package tm.service;

import tm.pojo.User;

public interface UserService {
    //注册
    public void registUser(User user);
    //登录
    public User login(User user);
    //检查用户名是否可用,返回true表示存在，返回false表示不存在可用
    public boolean existsUsername(String username);
}
