package com.atguigu.atcrowdfunding.serivce;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.github.pagehelper.PageInfo;

import java.util.Map;

public interface AdminService {
    TAdmin getAdminByLoginacctUserpswd(String loginacct, String userpswd);

    PageInfo<TAdmin> listPage(Map<String, Object> paramMap);

    void saveAdmin(TAdmin admin);

    TAdmin getAdminById(Integer id);


    void updateAdmin(TAdmin admin);

    void deleteAdmin(Integer id);

    void deleteBatchAdmin(String ids);
}
