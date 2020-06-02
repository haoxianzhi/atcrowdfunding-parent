package com.atguigu.atcrowdfunding.serivce;

import com.atguigu.atcrowdfunding.bean.TMenu;

import java.util.List;

public interface MenuService {
    //组合父子关系集合结果  用于侧边菜单
    List<TMenu> listMenu();

    //无需组合父子关系集合结果
    List<TMenu> ListAllMenu();
}
