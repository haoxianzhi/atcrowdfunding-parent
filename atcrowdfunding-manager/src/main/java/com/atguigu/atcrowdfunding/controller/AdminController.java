package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.serivce.AdminService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;

@Controller
public class AdminController {

    Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    AdminService adminService;



    @RequestMapping("/admin/deleteBatch")
    public String deleteBatch(String ids,Integer pageNum){
        adminService.deleteBatchAdmin(ids);
        return "redirect:/admin/index?pageNum="+pageNum;//避免表单重复提交
    }

    @RequestMapping("/admin/doDelete")
    public String doDelete(Integer id,Integer pageNum){
        adminService.deleteAdmin(id);
        return "redirect:/admin/index?pageNum="+pageNum;//避免表单重复提交
    }


    @RequestMapping("/admin/doUpdate")
    public String doUpdate(TAdmin admin,Integer pageNum){
        adminService.updateAdmin(admin);
        return "redirect:/admin/index?pageNum="+pageNum;//避免表单重复提交
    }

    @RequestMapping("/admin/doAdd")
    public String doAdd(TAdmin admin){
        adminService.saveAdmin(admin);
        return "redirect:/admin/index";//避免表单重复提交
    }

    @RequestMapping("/admin/toAdd")
    public String toAdd(){
        return "admin/add";
    }

    @RequestMapping("/admin/toUpdate")
    public String toUpdate(Integer id,Model model){
        TAdmin admin = adminService.getAdminById(id);
        model.addAttribute("admin",admin);
        return "admin/update";//避免表单重复提交
    }


    @RequestMapping("/admin/index")
    public String index(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                        @RequestParam(value = "pageSize",required = false,defaultValue = "2")Integer pageSize,
                        @RequestParam(value = "condition",required = false,defaultValue = "")String condition,
                        Model model){

        logger.debug("pageNum={}",pageNum);
        logger.debug("pageSize={}",pageSize);
        logger.debug("condition={}",condition);

        PageHelper.startPage(pageNum,pageSize);//通过线程本地变量ThreadLocal传递，将当前的数据传递给业务成

        //将数据打包回去   参数变动灵活
        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("condition",condition);
        PageInfo<TAdmin> page = adminService.listPage(paramMap);//通过方法的参数传递数据
        model.addAttribute("page",page);//框架会将数据放到请求与中，地层相当于调用request.setAttribute（“page",page）；

        logger.debug("page={}",page);
      return "admin/index";
    }
}
