package com.atguigu.atcrowdfunding.serivce.impl;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.bean.TRoleExample;
import com.atguigu.atcrowdfunding.mapper.TRoleMapper;
import com.atguigu.atcrowdfunding.serivce.RoleService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    TRoleMapper roleMapper;
//    private roleMapper roleMapper;

    @Override
    public PageInfo<TRole> listPage(Map<String, Object> paramMap) {

        String condition = (String) paramMap.get("condition");

        List<TRole> list = null;
        TRoleExample example = new TRoleExample();
        if (!StringUtils.isEmpty(condition)){//查询所有进行分页
            example.createCriteria().andNameLike("%"+condition+"%");
        }
        list = roleMapper.selectByExample(example);
        PageInfo<TRole> page = new PageInfo<TRole>(list,5);


        return page;
    }

    @Override
    public void saveRole(TRole role) {
        roleMapper.insertSelective(role);
    }

    @Override
    public TRole getRole(Integer id) {
        return roleMapper.selectByPrimaryKey(id);
    }

    @Override
    public void UpdateRole(TRole role) {
        roleMapper.updateByPrimaryKeySelective(role);
    }

    @Override
    public void deleteRole(Integer id) {
       roleMapper.deleteByPrimaryKey(id);
    }
}
