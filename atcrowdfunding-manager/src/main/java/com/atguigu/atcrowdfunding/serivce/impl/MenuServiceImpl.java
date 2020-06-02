package com.atguigu.atcrowdfunding.serivce.impl;


import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TMenuExample;
import com.atguigu.atcrowdfunding.mapper.TMenuMapper;
import com.atguigu.atcrowdfunding.serivce.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    TMenuMapper menuMapper;

    @Override
    public List<TMenu> listMenu() {
        //查找的是5个父菜单
        List<TMenu> listPartent = new ArrayList<TMenu>();
        Map<Integer, TMenu> cache = new HashMap<>();

        //19个子菜单
        TMenuExample example = new TMenuExample();
        List<TMenu> allMenu = menuMapper.selectByExample(example);

        //迭代  查找父菜单
        for (TMenu menu : allMenu) {
            if (menu.getPid()==0){
                listPartent.add(menu);
                cache.put(menu.getId(),menu);
            }
        }

        //迭代  找孩子  组合父子关系
        for (TMenu menu : allMenu) {
            if (menu.getPid()!=0){
                Integer pid = menu.getPid();
                TMenu parent = cache.get(pid);
                parent.getChildren().add(menu);
            }
        }

        return listPartent;
    }

    @Override
    public List<TMenu> ListAllMenu() {
        TMenuExample example = new TMenuExample();
        List<TMenu> allMenu = menuMapper.selectByExample(example);
        return allMenu;

    }
}
