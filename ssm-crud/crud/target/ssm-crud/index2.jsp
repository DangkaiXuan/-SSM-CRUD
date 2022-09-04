<%--
  Created by IntelliJ IDEA.
  User: 党凯旋
  Date: 2022/9/1
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%--加上這兩段<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    IDEA才能識別 el表達式    "APP_PATH"
 --%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%--    <link ref="">   <script></script>    --%>
    <script src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--    搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%-- 按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <%--鼠标悬停变色--%>
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>

            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6">
            当前页,总页,总条记录
        </div>
        <%--分页条信息--%>
        <div class="col-md-6">

        </div>
    </div>
</div>
<script type="text/javascript">
    //1.页面加载完以后，直接发送一个ajax请求，要到分页数据

</script>
</body>
</html>
