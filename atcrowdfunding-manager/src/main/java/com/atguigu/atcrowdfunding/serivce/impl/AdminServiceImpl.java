package com.atguigu.atcrowdfunding.serivce.impl;

import com.atguigu.atcrowdfunding.LoginacctException;
import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
import com.atguigu.atcrowdfunding.serivce.AdminService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.DateUtil;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    TAdminMapper adminMapper;


    @Override
    public TAdmin getAdminByLoginacctUserpswd(String loginacct, String userpswd) {
        TAdminExample example = new TAdminExample();
        example.createCriteria().andLoginacctEqualTo(loginacct);
        List<TAdmin> list = adminMapper.selectByExample(example);

        if (list==null || list.size()==0){
            throw new LoginacctException(Const.LOGIN_LOGINACCT_ERROR);
        }

        TAdmin admin = list.get(0);
        if (!admin.getUserpswd().equals(MD5Util.digest(userpswd))){
            throw new LoginacctException(Const.LOGIN_USERPSWD_ERROR);

        }
        return admin;
    }

    @Override
    public PageInfo<TAdmin> listPage(Map<String, Object> paramMap) {
        String condition = (String) paramMap.get("condition");

        List<TAdmin> list = null;
        TAdminExample example = new TAdminExample();
        if (!StringUtils.isEmpty(condition)){//查询所有进行分页

        //}else {//更具条件查询进行分页
            example.createCriteria().andCreatetimeLike("%"+condition+"%");

            TAdminExample.Criteria criteria2 = example.createCriteria();
            criteria2.andUsernameLike("%"+condition+"%");

            TAdminExample.Criteria criteria3 = example.createCriteria();
            criteria3.andEmailLike("%"+condition+"%");

            example.or(criteria2);
            example.or(criteria3);
        }
        //增加时间   倒序排序
        example.setOrderByClause("createtime desc");

        list = adminMapper.selectByExample(example);
        PageInfo<TAdmin> page = new PageInfo<TAdmin>(list,5);


        return page;
    }

    @Override
    public void saveAdmin(TAdmin admin) {

        admin.setCreatetime(DateUtil.getFormatTime());
        admin.setUserpswd(MD5Util.digest(Const.DEFALUT_PASSWORD));
        adminMapper.insertSelective(admin);//有选择的添加 属性值不为空  生成insert语句时，这个字段就会添加操作
    }

    @Override
    public TAdmin getAdminById(Integer id) {
        return adminMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateAdmin(TAdmin admin) {
        //密码和创建的和时间不参与操作的，所以，使用updateByPriyKeySelective方法，
        //不要选择updateByPriyKey方法，否者，就会将数据库的密码和创建时间字段值更新为null
        adminMapper.updateByPrimaryKeySelective(admin);
    }

    @Override
    public void deleteAdmin(Integer id) {
        adminMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteBatchAdmin(String ids) {
        if (!StringUtils.isEmpty(ids)){
            String[] split = ids.split(",");
            List<Integer> idList = new ArrayList<Integer>();

            for (String idStr: split) {
                int id = 0;
                try {
                    id = Integer.parseInt(idStr);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
                idList.add(id);
            }

            TAdminExample example = new TAdminExample();
            example.createCriteria().andIdIn(idList);
            adminMapper.selectByExample(example);
        }
    }

}
