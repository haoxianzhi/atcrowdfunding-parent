    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <ul id="treeDemo" class="ztree"></ul>
        </div>
        </div>
        </div>
        </div>
        </div>

        <%@include file="/WEB-INF/jsp/common/js.jsp"%>
        <script type="text/javascript">
        $(function () { //当前页面被浏览器加载完成时，触发一个事件处理。相当与body标签的onload事件。
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

        initTree();
        });

        //---------------------------------------------------
        function initTree(){
        var setting = {
        data: {
        simpleData: {
        enable: true,
        pIdKey: 'pid'
        }
        },
        view: {
        addDiyDom: function(treeId, treeNode){//treeId:容器id,treeNode初始化的当前节点
        var icoObj = $("#" + treeNode.tId + "_ico");
        if ( treeNode.icon) {  //在js代码中  非null字符串为true ；
        icoObj.removeClass()
        $("#" + treeNode.tId + "_span").addClass(treeNode.icon);
        }
        },
        addHoverDom: function(treeId, treeNode){
        var aObj = $("#" + treeNode.tId + "_a");
        aObj.attr("href", "javascript:;"); //禁用连接
        aObj.attr("onclick", "return false;"); //取消单击事件，返回fasle,不做任何事情
        if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0){
        return;
        }
        var s = '<span id="btnGroup'+treeNode.tId+'">';
        if ( treeNode.level == 0 ) { // 根节点
        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
        } else if ( treeNode.level == 1 ) { //分支节点
        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
        if (treeNode.children.length == 0) {
        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
        }
        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
        } else if ( treeNode.level == 2 ) {  //叶子节点
        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
        }

        s += '</span>';
        aObj.after(s);
        },
        removeHoverDom: function(treeId, treeNode){
        $("#btnGroup"+treeNode.tId).remove();
        }
        }
        };

        var zNodes ={};  //通过发起异步请求获取zTree查询需要json数据
        $.get("${PATH}/menu/initTree",{},function(result){  //  result ==>> List<TMenu> ==>> JSON存放19条数据，无需自己组合父子关系。
        console.log(result); // 19条数据
        var zNodes = result ;

        zNodes.push({"id":0,"name":"系统菜单","icon":"glyphicon glyphicon-th-list"});

        $.fn.zTree.init($("#treeDemo"), setting, zNodes);

        //展开全部节点
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        treeObj.expandAll(true);
        });

        }



</script>
</body>
</html>
