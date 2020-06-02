<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 2020/5/19
  Time: 21:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ch_CN">
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
    </style>
</head>

<body>


<jsp:include page="/WEB-INF/jsp/common/menu.jsp"></jsp:include>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/jsp/common/menu.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">修改</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">


                    <form id="updateForm" role="form" action="${PATH}/admin/doUpdate" method="post">
                        <div class="form-group">
                            <label >登陆账号</label>
                            <input type="hidden" name="id" value="${admin.id}">
                            <input type="hidden" name="pageNum" value="${param.pageNum}">
                            <input type="text" class="form-control" readonly name="loginacct" value="${admin.loginacct}" placeholder="请输入登陆账号">
                        </div>
                        <div class="form-group">
                            <label >用户名称</label>
                            <input type="text" class="form-control" name="username"  value="${admin.username}" placeholder="请输入用户名称">
                        </div>
                        <div class="form-group">
                            <label>邮箱地址</label>
                            <input type="email" class="form-control" name="email" value="${admin.email}" placeholder="请输入邮箱地址">
                            <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <button id="updaBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 修改</button>
                        <button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                    </form>


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

    $("#addBtn").click(function () {
        $("#addForm").submit();
    })

    $("#updaBtn").click(function () {
        $("#updateForm").submit();
    })
</script>
</body>
</html>
