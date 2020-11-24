package tm.test;

import org.junit.Test;
import tm.dao.UserDao;
import tm.dao.impl.UserDaoImpl;
import tm.pojo.User;

public class UserDaoTest {
    @Test
    public void queryUserByUsername(){//未查找到返回null
        UserDao userDao = new UserDaoImpl();
        System.out.println(userDao.queryUserByUsername("1"));
    }
    @Test
    public void queryUserByUsernameAndPassword(){//未查找到返回null
        UserDao userDao = new UserDaoImpl();
        System.out.println(userDao.queryUserByUsernameAndPassword("test","test1"));
    }
    @Test
    public void saveUser(){//失败返回-1，说明插入失败，什么时候会插入失败？用户名相同了，因为我们建表时username为unique
        UserDao userDao = new UserDaoImpl();
        System.out.println(userDao.saveUser(new User(null,"qwertyui","22222","3")));
    }
}
