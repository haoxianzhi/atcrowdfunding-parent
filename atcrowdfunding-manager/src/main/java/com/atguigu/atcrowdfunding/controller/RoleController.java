package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.serivce.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class RoleController {

    Logger logger = LoggerFactory.getLogger(RoleController.class);

    @Autowired
    RoleService roleService;




    //读属性
    @ResponseBody
    @RequestMapping("/role/doDelete")
    public String doDelete(Integer id){
        roleService.deleteRole(id);
        return "ok";//不进行视图解析，直接返回OK字符串
    }



    //读属性
    @ResponseBody
    @RequestMapping("/role/doUpdate")
    public String doUpdate(TRole role){
        roleService.UpdateRole(role);
        return "ok";//不进行视图解析，直接返回OK字符串
    }

    //读属性
    @ResponseBody
    @RequestMapping("/role/get")
    public TRole get(Integer id){
        TRole role = roleService.getRole(id);
        return role ;//不进行视图解析，直接返回OK字符串
    }




    //读属性
    @ResponseBody
   @RequestMapping("/role/doAdd")
    public String doAdd(TRole role){
        roleService.saveRole(role);
      return "ok";
    }



    //异步请求处理，将数据已json格式返回给浏览器
    @ResponseBody
    @RequestMapping("/role/loadData")
    public PageInfo<TRole> loadData(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                                    @RequestParam(value = "pageSize",required = false,defaultValue = "2")Integer pageSize,
                                    @RequestParam(value = "condition",required = false,defaultValue = "")String condition){


        logger.debug("pageNum={}",pageNum);
        logger.debug("pageSize={}",pageSize);
        logger.debug("condition={}",condition);
        PageHelper.startPage(pageNum,pageSize);//通过线程本地变量ThreadLocal传递，将当前的数据传递给业务成

        //将数据打包回去   参数变动灵活
        Map<String, Object> paramMap = new HashMap<String,Object>();
        paramMap.put("condition",condition);
        PageInfo<TRole> page = roleService.listPage(paramMap);//通过方法的参数传递数据


        return page;//异步开发方式，不在进行视图解析  直接返回结果
    }

    @RequestMapping("/role/index")
    public String index(){
        return "role/index";
    }
}
