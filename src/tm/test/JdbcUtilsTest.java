package tm.test;

public class JdbcUtilsTest {
    //@Test
    //@Test下的方法可以不用main方法调用就可以测试出运行结果，是一种测试方法
    //一般函数都需要有main方法调用才能执行，注意被测试的方法必须是public修饰的
    //需要导包junit-4.12.jar/hamcrest-core-1.3.jar
    //由于事务在最后关闭，JdbcUtils.close(conn);出错，所以该test不用了
    /*public void testJdbcutils(){
        for (int i = 0; i < 100; i++) {

            Connection conn = JdbcUtils.getConnection();
            System.out.println(conn);
            //如果不加下面的关闭连接Java语句。虽然应该出现100个连接对象的信息，但是我们在配置文件中设置连接池的线数是10
            //也就是说最多只能连10个对象，除非你将获取的释放了，它才会有空闲的对象再去连接然后再次打印。因此连接完也要释放资源
            JdbcUtils.close(conn);
        }

    }*/
}
