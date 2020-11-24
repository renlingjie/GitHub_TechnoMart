package tm.dao.impl;

import tm.dao.UserDao;
import tm.pojo.User;

public class UserDaoImpl extends BaseDao implements UserDao {
    //继承接口并重写接口中要实现的方法
    @Override
    public User queryUserByUsername(String username) {
        String sql = "select id,username,password,email from user where username = ?";
        return queryForOne(User.class,sql,username);
    }

    @Override
    public int saveUser(User user) {
        String sql = "insert into user(username,password,email) values(?,?,?)";
        return update(sql,user.getUsername(),user.getPassword(),user.getEmail());
    }

    @Override
    public User queryUserByUsernameAndPassword(String username, String password) {
        String sql = "select id,username,password,email from user where username = ? and password = ?";
        return queryForOne(User.class,sql,username,password);
    }
}
