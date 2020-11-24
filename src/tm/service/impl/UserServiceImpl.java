package tm.service.impl;

import tm.dao.UserDao;
import tm.dao.impl.UserDaoImpl;
import tm.pojo.User;
import tm.service.UserService;

public class UserServiceImpl implements UserService {
    private UserDao userDao = new UserDaoImpl();
    @Override
    //注册方法实际上就是将用户信息插入到数据库中，我们已经在UserDaoImpl中对save
    //进行了封装，这里直接插入用户对象，就可以完成将用户对象插入到数据库中
    public void registUser(User user) {
        userDao.saveUser(user);
    }

    @Override
    //登录方法实际上就是对用户名密码的查询操作，我们我们已经在UserDaoImpl中对queryUserByUsernameAndPassword
    //进行了封装，在这里直接插入用户信息，就可以完成将用户的用户名和密码与数据库进行匹配的问题
    public User login(User user) {
        return userDao.queryUserByUsernameAndPassword(user.getUsername(),user.getPassword());
    }

    @Override
    public boolean existsUsername(String username) {
        if(userDao.queryUserByUsername(username) == null){
            //仍然是调用UserDaoImpl中的queryUserByUsername方法，当它为空，说明用户名不存在
            //返回false表示不存在，表示可用
            return false;
        }
        return true;//否则返回true，表示存在，表示不可用
    }
}
