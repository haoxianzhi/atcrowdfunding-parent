package com.atguigu.atcrowdfunding.controller;


import com.atguigu.atcrowdfunding.LoginacctException;
import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.serivce.AdminService;
import com.atguigu.atcrowdfunding.serivce.MenuService;
import com.atguigu.atcrowdfunding.util.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class DispatcherController  {


    @Autowired
    AdminService adminService;

    @Autowired
    MenuService menuService;
//菜单不需要每次都要去数据库去查  所以从session域查找   没有  才去从数据库加载数据（立即加载，不是懒加载）
    @RequestMapping("/main")
    public String main(HttpSession session){
        System.out.println("*********** main ***********");

        //所有父菜单。每一个父children集合存放子菜单
        List<TMenu> listParent =  (List<TMenu>)session.getAttribute("listParent");
        if (listParent == null){
            listParent =menuService.listMenu();
            //request   session   application
            session.setAttribute("listParent",listParent);
        }

        return "main";//   WEB-INF/jsp/main.jsp
    }

//    @RequestMapping("/main")
//    public String main(HttpSession session){
//        System.out.println("*********** main ***********");
//
//        //所有父菜单。每一个父children集合存放子菜单
//        List<TMenu> listParent =  menuService.listMenu();
//
//        //request   session   application
//        session.setAttribute("listParent",listParent);
//
//        return "main";//   WEB-INF/jsp/main.jsp
//    }

    @RequestMapping("/login")
    public String login(String loginacct, String userpswd, HttpSession session){
        System.out.println("loginacct = " + loginacct);
        System.out.println("userpswd = " + userpswd);

        try {
            TAdmin admin = adminService.getAdminByLoginacctUserpswd(loginacct,userpswd);
            session.setAttribute(Const.LOGIN_ADMIN,admin);
        } catch (LoginacctException e) {
            e.printStackTrace();
            session.setAttribute("message",e.getMessage());
            session.setAttribute("loginacct",loginacct);
            return "redirect:/login.jsp";
        }catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message","登录失败.");
            session.setAttribute("loginacct",loginacct);
            return "redirect:/login.jsp";
        }
        //转发（请求路径是不变的），导致表单重复提交，重复登录。
        //return "main"; //   WEB-INF/jsp/main.jsp
        //重定向（路径跳转，会变）
        return "redirect:/main";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        if(session!=null){
            session.invalidate();
        }
        return "redirect:/login.jsp";
    }

}
