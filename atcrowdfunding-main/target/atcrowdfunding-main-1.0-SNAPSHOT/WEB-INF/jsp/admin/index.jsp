<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 2020/5/20
  Time: 22:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh_CN">
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
                    <form id="searchPageForm" class="form-inline" role="form" style="float:left;" action="${PATH}/admin/index" method="post">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input  class="form-control has-success" type="text" name="condition" value="${param.condition}" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button  type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button id="deleteBatchBtn" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${PATH}/admin/toAdd'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input id="theadCheckbox" type="checkbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${page.list}" var="admin" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td><input type="checkbox" adminId="${admin.id}"></td>
                                    <td>${admin.loginacct}</td>
                                    <td>${admin.username}</td>
                                    <td>${admin.email}</td>
                                    <td>
                                        <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
                                        <button type="button" class="btn btn-primary btn-xs" onclick="window.location.href='${PATH}/admin/toUpdate?id=${admin.id}&pageNum=${page.pageNum}'"><i class=" glyphicon glyphicon-pencil"></i></button>
                                        <button type="button" class="deleteBtnClass btn btn-danger btn-xs" myhref="${PATH}/admin/doDelete?id=${admin.id}&pageNum=${page.pageNum}"><i class=" glyphicon glyphicon-remove"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <c:if test="${page.isFirstPage}">
                                            <li class="disabled"><a href="#">上一页</a></li>
                                        </c:if>
                                        <c:if test="${!page.isFirstPage}">
                                            <li><a href="${PATH}/admin/index?condition=${param.condition}&pageNum=${page.pageNum-1}">上一页</a></li>
                                        </c:if>

                                        <c:forEach items="${page.navigatepageNums}" var="num">
                                            <c:if test="${num==page.pageNum}">
                                                <li class="active"><a href="${PATH}/admin/index?condition=${param.condition}&pageNum=${num}">${num}</a></li>
                                            </c:if>
                                            <c:if test="${num!=page.pageNum}">
                                                <li><a href="${PATH}/admin/index?condition=${param.condition}&pageNum=${num}">${num}</a></li>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${page.isLastPage}">
                                            <li class="disabled"><a href="#">下一页</a></li>
                                        </c:if>
                                        <c:if test="${!page.isLastPage}">
                                            <li><a href="${PATH}/admin/index?condition=${param.condition}&pageNum=${page.pageNum+1}">下一页</a></li>
                                        </c:if>
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

<%@include file="/WEB-INF/jsp/common/js.jsp"%>
<script type="text/javascript">
    $(function () {
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
    });

    $("#searchBtn").click(function () {
        $("#searchPageForm").submit();
    });

    //再循环操作的时候中，不用操作的id选择器，而应该使用样式类选择器，否则，绑定事件有问题
    $(".deleteBtnClass").click(function () {
        var href = $(this).attr("myhref");//dom对象转化为jQuery对象

        layer.confirm("你确定要删除吗？",{btn:["确认","取消"]},function(index){
            window.location.href=href;
            layer.close(index);
        },function (index){
            layer.close(index);
        });
    });

    //---------------------------------------------------------------------------------------
    $("#theadCheckbox").click(function () {
        var checkedStatus = this.checked;
       var tbodyCheckboxList = $("tbody input[type='checkbox']")
        $.each(tbodyCheckboxList,function (i,e) {//i是索引   e是迭代元素（e是dom对象）
          e.checked=checkedStatus;
        })
       // alert(tbodyCheckboxList.length);
    });

    $("#deleteBatchBtn").click(function () {
        //获取tbody里的被勾选的复选框
        var tbodyCheckboxList = $("tbody input[type='checkbox']:checked");
        if (tbodyCheckboxList.length == 0) {
            layer.msg("至少选择一条数据进行删除", {time: 2000, icon: 5, shift: 6});
            return false;
        }

        layer.confirm("你确定要删除吗",{btn:["确定","取消"]},function (index){
            var idStr = ''; //13,11
            var idsArray = new Array();

            $.each(tbodyCheckboxList,function (i,e) {
                // var adminId = e.adminId;//$(e) 将dom对象转化为jQuery对象，通过attr()函数来获取自定义的属性
                var adminId = $(e).attr("adminId");//$(e) 将dom对象转化为jQuery对象，通过attr()函数来获取自定义的属性
                idsArray.push(adminId);
            });
            idStr= idsArray.join(",");

            window.location.href="${PATH}/admin/deleteBatch?pageNum=${page.pageNum}&ids="+idStr;
            layer.close(index);
        },function (index){
            layer.close(index);
        });
    });


</script>
</body>
</html>
