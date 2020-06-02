<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 2020/5/21
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@include file="/WEB-INF/jsp/common/css.jsp"%>
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>
<jsp:include page="/WEB-INF/jsp/common/top.jsp"></jsp:include>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/jsp/common/menu.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="searchBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button id="addBtn" type="button" class="btn btn-primary" style="float:right;" ><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">

                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>





<!-添加 Modal -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加角色</h4>
            </div>
            <div class="modal-body">
                <form id="addForm" role="form">
                    <div class="form-group">
                        <label >角色名称</label>
                        <input type="text" class="form-control" name="name" placeholder="请输入角色名称">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="saveBtn" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>




<!-修改 Modal -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改角色</h4>
            </div>
            <div class="modal-body">
                <form id="updateForm" role="form">
                    <div class="form-group">
                        <label >角色名称</label>
                        <input type="hidden" name="id" >
                        <input type="text" class="form-control" name="name" placeholder="请输入角色名称">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateBtn" type="button" class="btn btn-primary">修改</button>
            </div>
        </div>
    </div>
</div>











<%@include file="/WEB-INF/jsp/common/js.jsp"%>
<script type="text/javascript">
    $(function () {//当前的页面浏览器加载完成后，触发一个事件，想当于boyd标签的onload事件
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });

        showData(1);//页面加载完成后，调用自定义函数，加载分页数据，默认显示第一页数据
    });

//---------------分页查询--------------------------------------------------------------------------------------
    var json = {
        pageNum:1,
        pageSize:2,
        condition:''
    };

    function showData(pageNum){

        json.pageNum=pageNum;
        var index = -1;
        //发起异步请求，然后进行局部刷新
        $.ajax({
            type:"post",
            url:"${PATH}/role/loadData",
            data:json,
            beforeSend:function () {

                //发起异步请求     进行单表校验   告诉用户正在进行加载
                index = layer.load(2,{time:10*10000});
                return true;//表示继续发起请求，false表示取消异步请求

            },
            success:function (result) {  //result==>PageInfor对象
               json.pages= result.pages;


              //异步请求成功，返回结果通同时处理
                layer.close(index);
                    console.log(result);//
                //显示表格数据
                var list = result.list;
                showTable(list);
                showNavg(result);
            }
        });
    }


    $("tbody .btn-success").click(function(){
        window.location.href = "assignPermission.html";
    });
    function showTable(list) {
           //显示信息数据
            var content = '';
            //显示表格数据
            $.each(list,function(i,e){//e就是role角色对象
                content+='<tr>';
                content+='  <td>'+(i+1)+'</td>';
                content+='  <td><input type="checkbox"></td>';
                content+='  <td>'+e.name+'</td>';
                content+='  <td>';
                content+='	  <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                content+='	  <button type="button" roleId="'+e.id+'" class="updateBtnClass btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                content+='	  <button type="button" roleId="'+e.id+'" class="deleteBtnClass btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                content+='  </td>';
                content+='</tr>';
            });
            $("tbody").html(content);
        }

        function showNavg(pageInfo) { //这个页面里面实际传入的就是ajax请求的到的result即后台的PageInfo对象
            //显示分页条
            var content = '';
            if(pageInfo.isFirstPage){
                content+='<li class="disabled"><a href="#">上一页</a></li>';
            }else{
                content+='<li><a onclick="showData('+(pageInfo.pageNum-1)+')">上一页</a></li>';
            }

            $.each(pageInfo.navigatepageNums,function(i,num){//i是遍历的角标，num是遍历的数据
                if(num == pageInfo.pageNum){
                    content+='<li class="active"><a onclick="showData('+num+')">'+num+'</a></li>';
                }else{
                    content+='<li><a onclick="showData('+num+')">'+num+'</a></li>';
                }
            });

            if(pageInfo.isLastPage){
                content+='<li class="disabled"><a href="#">下一页</a></li>';
            }else{
                content+='<li><a onclick="showData('+(pageInfo.pageNum+1)+')">下一页</a></li>';
            }

            $(".pagination").html(content);

        }


    //----------------条件查询--------------------------------------------------------------------------------
    $("#searchBtn").click(function () {
        var condition=$("#condition").val();
        console.log(condition);

        json.condition=condition;
        showData(1);
    });


    //----------------新增功能--------------------------------------------------------------------------------

    $("#addBtn").click(function () {
        //弹出模态框
        $("#addModal").modal({
            show:true,           //立即显示模态框
            backdrop:'static',  //表示点击背景页面时，模态框不消失
            keyboard:false       //点击esc键不消失
        });
    });

    //----------------模态块保存按钮--------------------------------------------------------------------------------
    $("#saveBtn").click(function () {
        //获取表单数据
        var  name = $("#addModal input[name='name']").val();
        //发起异步请求，保存数据
        $.ajax({
          type: "post",
          url: "${PATH}/role/doAdd",
          data: {
              name:name
          },
            beforeSend:function () {
              return true;
            },
            success:function (result) {//异步保存成功只需返回"ok"字符串
                if (result == "ok") {
                    layer.msg("保存成功", {icon: 6, time: 2000},function () {
                      $("#addModal").modal('hide');//隐藏模态框
                      showData(json.pages+1);//根据分页合理化自动去到最后一页
                        //val()函数，用于获取表单元素的value属性值，如果指定参数，就是给表单元素属性赋值
                        $("#addModal input[name='name']").val('');//清空文本框的值
                    });
                } else {
                    layer.msg("保存失败", {icon: 5, time: 2000, shift: 6});
                }
            }
        });
    });


    //----------------修改功能-  回显数据-------------------------------------------------------------------------------
    //页面的表格数据局部刷新出来的，称为后来的元素，给后来的元素添加事件是不能使用cleck（）函数，不起作用
    //对于后来的元素可以使用on（）函数事件处理
    //$(".updateBtnClass").click(function () {


        $("tbody").on("click",".updateBtnClass",function () {
            var roleId = $(this).attr("roleId");
            //console.log(roleId);
            //发起异步请求，查询角色对象，数据回显
            $.get("${PATH}/role/get",{id:roleId},function (result) {//result 就是查询角色对象
                var role = result;
               // console.log(role.name)
                $("#updateModal input[name='name']").val(role.name);
                $("#updateModal input[name='id']").val(role.id);

                //回显
                $("#updateModal").modal({
                    show: true,
                    keyboard: false,
                    backdrop: 'static'
                });
            });
        });


    //----------------修改功能------------------------------------------------------------------------------
  $("#updateBtn").click(function () {
     //获取表单数据
      var name = $("#updateModal input[name='name']").val();
      var id = $("#updateModal input[name='id']").val();
      //发起异请求，进行数据修改
       $.post("${PATH}/role/doUpdate",{id:id,name:name},function (result) {
           if (result == "ok") {
               layer.msg("修改成功", {icon: 6, time: 2000},function () {
                   $("#updateModal").modal('hide');//隐藏模态框
                   //val()函数，用于获取表单元素的value属性值，如果指定参数，就是给表单元素属性赋值
               showData(json.pageNum);//根据分页的合理化自动去到最后一页
               });
           } else {
               layer.msg("修改失败", {icon: 5, time: 2000, shift: 6});
           }
       });
  });


    //----------------删除功能------------------------------------------------------------------------------


  $("tbody").on("click",".deleteBtnClass",function () {
      var roleId= $(this).attr("roleId");
      layer.confirm("你确定要删除吗",{btn:["确定","取消"]},function(index){
         // var roleId= $(this).attr("roleId");//放在这个位置是layer的确认按钮，不是删除按钮
          $.post("${PATH}/role/doDelete",{id:roleId},function (result) {
              if (result == 'ok') {
                  layer.msg("删除成功", {icon: 6, time: 2000},function () {
                      //val()函数，用于获取表单元素的value属性值，如果指定参数，就是给表单元素属性赋值
                      showData(json.pageNum);//根据分页的合理化自动去到最后一页
                  });
              } else {
                  layer.msg("删除失败", {icon: 5, time: 2000, shift: 6});
              }
          });

          layer.close(index);
      },function (index) {
          layer.close(index);
  });



  });












</script>
</body>
</html>
