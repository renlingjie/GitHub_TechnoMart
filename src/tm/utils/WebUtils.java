package tm.utils;

import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;

public class WebUtils {
    //public static void copyParameterToBean(HttpServletRequest req,Object bean){
    //之所以按照下面改，是因为虽然，一个是请求req,一个是传过来的Map集合，里面都包含了用户提交的键值对，但是HttpServletRequest
    //只能应用于三层架构的Web层（其他两层没有这个API），而Map因为性质只是一个集合所以可以用在任何三层架构之上（Dao/Service/Web）
    public static <T> T copyParameterToBean(Map value, T bean){//把Map值注入到对应的JavaBean属性中
        System.out.println("注入之前"+bean);
        try {
            //BeanUtils.populate(bean,req.getParameterMap());
            BeanUtils.populate(bean,value);//这里对应的值就要换成Map的value
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("注入之后"+bean);
        return bean;//将用户提交过来的键值对信息封装成的Mart对象作为返回值返回
    }
    //封装的一个工具类：将字符串转换成为int类型
    public static int parseInt(String strInt,int defaultValue){
        try{//其实没有异常，但是有一种情况就是：假如转换失败，那么就需要将这个异常进行捕捉，同时返回这个默认值
            return Integer.parseInt(strInt);
        }catch (Exception e){
            e.printStackTrace();
        }
        return defaultValue;
    }
}
