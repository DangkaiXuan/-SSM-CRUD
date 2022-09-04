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
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender=="M"?"男":"女"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑</button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除</button>
                            </th>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
        <%--显示分页信息--%>
        <div class="row">
        <%--分页文字信息--%>
            <div class="col-md-6">
                当前${pageInfo.pageNum}页,总${pageInfo.pages}页,总${pageInfo.total}条记录
            </div>
        <%--分页条信息--%>
             <div class="col-md-6">
                 <nav aria-label="Page navigation">
                     <ul class="pagination">
                         <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                         <!--如果有上一页在显示上一页-->
                         <c:if test="${pageInfo.hasPreviousPage}">
                             <li>
                                 <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                     <span aria-hidden="true">&laquo;</span>
                                 </a>
                             </li>
                         </c:if>

                            <%-- //如果是当前页码，则给高亮的状态    --%>
                         <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                             <c:if test="${page_Num == pageInfo.pageNum}">
                                 <li class="active"><a href="#">${page_Num}</a></li>
                             </c:if>
                             <c:if test="${page_Num != pageInfo.pageNum}">
                                 <li class=""><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                             </c:if>
                         </c:forEach>
                         <!--如果有下一页在显示下一页-->
                         <c:if test="${pageInfo.hasNextPage}">
                             <li>
                                 <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                     <span aria-hidden="true">&raquo;</span>
                                 </a>
                             </li>
                         </c:if>
                         <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
                     </ul>
                 </nav>
             </div>
        </div>
    </div>
</body>
</html>
