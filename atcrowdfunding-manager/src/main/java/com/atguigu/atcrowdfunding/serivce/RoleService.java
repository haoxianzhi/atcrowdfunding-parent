package com.atguigu.atcrowdfunding.serivce;


import com.atguigu.atcrowdfunding.bean.TRole;
import com.github.pagehelper.PageInfo;

import java.util.Map;

public interface RoleService  {

    PageInfo<TRole> listPage(Map<String, Object> paramMap);


    void saveRole(TRole role);

    TRole getRole(Integer id);

    void UpdateRole(TRole role);

    void deleteRole(Integer id);
}
