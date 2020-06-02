package com.atguigu.atcrowdfunding.controller;


import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.serivce.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class MenuController {

    @Autowired
    MenuService menuService;

    @ResponseBody
    @RequestMapping("menu/initTree")
    public List<TMenu> initTree(){
        List<TMenu> list = menuService.ListAllMenu();
       // System.out.println(list);
        return list;//将集合序列化为json数据格式
    }


    @RequestMapping("menu/index")
    public String index(){

        return "menu/index";
    }



}
