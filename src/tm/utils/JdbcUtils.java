package tm.utils;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidDataSourceFactory;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;

//两个方法，一个获取连接，一个关闭连接
public class JdbcUtils {
    private static DruidDataSource dataSource;
    static {//用静态代码块做初始化
        try {//捕获createDataSource、load的异常
            //1、创建一个配置文件对象，作为载体承载流中加载的数据
            Properties properties = new Properties();
            //2、读取jdbc.properties属性配置文件，并返回一个输入流
            InputStream inputStream = JdbcUtils.class.getClassLoader().getResourceAsStream("jdbc.properties");
            //3、从流中加载数据到配置文件对象中
            properties.load(inputStream);
            //4、通过配置文件对象中的信息（上一步通过流加载进来）获取连接池对象，然后就可以通过该连接池对象执行
            //getConnection()和close方法。（我们用的是Druid连接池）
            dataSource = (DruidDataSource) DruidDataSourceFactory.createDataSource(properties);
            /*测试：如果从连接池中得到信息，就说明连接成功.
            System.out.println(dataSource.getConnection());*/
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /*public static void main(String[] args) {
    执行上面测试程序，当main函数执行，main函数所在当类就会加载，就会执行静态代码块中当程序，自然会执行上面当测试
    语句执行结果：控制台打印输出类一个连接对象"com.mysql.cj.jdbc.ConnectionImpl@c540f5a"，说明连接成功
    }*/
    //获取数据库连接池中的连接，走连接池，避免多次建立多次握手。如果返回null，说明获取连接失败，有值就是获取连接成功
    public static Connection getConnection(){
        Connection conn = null;
        try {//通过数据库连接池对象直接调用getConnection方法
            conn = dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
    //关闭连接，放回数据库连接池
    public static void close(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
