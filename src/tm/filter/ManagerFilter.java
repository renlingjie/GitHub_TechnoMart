package tm.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class ManagerFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        //首先需要获取session，才能判断session域中是否有对象。但是servletRequest没有getSession这个方法，我们选择将之转换成HttpServletRequest，再调用这个方法
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        Object manager = httpServletRequest.getSession().getAttribute("manager");//Manager中将manager对象保存在了容器manager中，容器又保存到了session域中
        if(manager == null){
            httpServletRequest.getRequestDispatcher("/pageStart/HJJ/pageStart.jsp").forward(servletRequest, servletResponse);
        }else {
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {

    }
}
