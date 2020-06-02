package com.atguigu;


import com.atguigu.atcrowdfunding.util.Const;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

//服务启动或停止执行相关操作
public class SystemStartInitListerner implements ServletContextListener {

    //服务器启动时进行初始化
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("系统开始初始化拉 ");
        ServletContext application = sce.getServletContext();
        String contextPath = application.getContextPath();
        System.out.println("contextPath=" + contextPath);
        application.setAttribute(Const.PATH,contextPath);
    }

    //服务器停止时进行初注销，释放资源
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("系统释放资源了 ");

    }
}
