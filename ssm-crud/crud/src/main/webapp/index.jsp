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
<%--员工修改模态框--%>
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <%--form表单--%>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" name="" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关 闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更 新</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%--员工添加的模态框--%>
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工添加</h4>
            </div>
            <%--form表单--%>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="emp_Name">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" name="" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关 闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保 存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

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
            <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <%--鼠标悬停变色--%>
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord,currentPage;//总记录数
    //1.页面加载完以后，直接发送一个ajax请求，要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });
    //跳转页码
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,//上面指定的页码
            type:"GET",
            success:function (result) {
                // console.log(result)
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条数据
                build_page_nav(result);

            }
        });
    }
    function build_emps_table(result) {
        //在每次创建表格到时候，先清空掉table
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            //创建员工
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item. empName);
            var genderTd = $("<td></td>").append(item.gender=='M'?'男':'女');
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                            .append($('<span></span>').addClass("glyphicon glyphicon-pencil"))
                            .append("编辑");
          //为编辑按钮添加一个自定义属性，来表示当前员工id
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($('<span></span>').addClass("glyphicon glyphicon-trash"))
                .append(" ")
                .append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("del-id",item.empId);
           //append方法执行完成以后还是返回原来的元素
           $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(editBtn)
                    .append(delBtn)
                    .appendTo("#emps_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前页"+result.extend.pageInfo.pageNum
            +",总"+result.extend.pageInfo.pages+"页,"
            +"总"+result.extend.pageInfo.total+"条记录");
        totalRecord = result.extend.pageInfo.total;//总记录数
        currentPage = result.extend.pageInfo.pageNum;//当前页码
    }
    //解析显示分页条
    function  build_page_nav(result) {
        //构建之前 先清空导航条
        $("#page_nav_area").empty();
        //page_nav_area
        var ul = $("<ul></ul>").addClass("pagination");
        //构建元素， 导航条
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        //如果没有前一页则显示 不能被点击
       if(result.extend.pageInfo.hasPreviousPage == false) {
           firstPageLi.addClass("disabled");
           prePageLi.addClass("disabled");
       }
       //为元素添加点击翻页的事件
       //首页
        firstPageLi.click(function () {
            to_page(1);
        });

       //点击上一页的=当前页-1
        prePageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum -1);
        });

       prePageLi.c
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
       //如果没有下一页则 不能被点击
        if(result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }

        //下一页 = 当前页+1
        nextPageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum + 1);
        });
        //尾页
        lastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        })

        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi)
       //遍历导航条里面的值
        //1,2,3,4遍历ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            //如果遍历的页码是当前页码则高亮显示
            if(result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            //点击那一页跳转那一页
            numLi.click(function () {
                to_page(item);
            })
            ul.append(numLi);
        })
        //添加下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);
        //把ul添加到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    //完整的表单重置
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");//清空提示信息
        $(ele).find(".help-block").text("");//样式清空  span标签中的属性help-block
    }
    //给模态框一个回调函数 当事件触发则开始点击
    $("#emp_add_model_btn").click(function () {
        //清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#empAddModel form");
        // $("#empAddModel form")[0].reset();
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModel select");
        //调用添加的模板
        $('#empAddModel').modal({
            backdrop:"static"
        })
    });

    //查出所有的部门信息并显示在下拉列表中
    function getDepts(ele) {
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",//向服务器请求的ajax
            type: "GET",
            success:function (result) {
                // console.log(result)extend:
                //depts: Array(2)0: {deptId: 1, deptName: '开发部'} 1: {deptId: 2, deptName: '运营部'}
                //显示部门信息在下拉列表 把部门信息添加到这
                // $("#empAddModel select")
                //遍历部门信息
                $.each(result.extend.depts,function () {
                    var optionEle = $("<option></option>")
                     .append(this.deptName)
                     .attr("value",this.deptId);
                    //将optionEle添加到员工添加的模态框下拉列表中
                    optionEle.appendTo(ele);
                })
            }
        })
    }

    //校验方法
    function validate_add_form() {
        //1.拿到校验的数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        //用户名正则，4到16位（字母，数字，下划线，减号）
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            // alert("用户名可以是2~5位中文或者6~16位英文和数字的组合")
            show_validate_msg("#empName_add_input","error","用户名可以是2~5位中文或者6~16位英文和数字的组合");
            return false;
        }else {
            show_validate_msg("#empName_add_input","success","");
        };

        //2.校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱地址不对");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_add_input","error","邮箱地址不对");
            return false;
        }else {
            show_validate_msg("#email_add_input","success","");
        }
        return true;
    }

    //封装显示校验信息的提示
    function show_validate_msg(ele,status,msg) {
        //添加之前清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("")
        if ("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            //如果失败则在span内显示错误信息
            $(ele).next("span").text(msg);
        }
    }
    //校验用户名是否可用
    $("#empName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if (result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else {
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        })
    })
    //保存员工 下面是前端ajax校验
    $("#emp_save_btn").click(function () {
        //1.模态框中填写的表单数据提交给服务器进行保存
        //2.发送ajax请求员工提交给服务器的数据进行校验
        if(!validate_add_form()) {
            return false;
        }
        //1.判断之前ajax用户校验是否成，成功在执行下面代码
        if($(this).attr("ajax-va")=="error") {//此代码决定是否让保存按钮继续提交
            return false;
        }

        //alert($("#empAddModel form").serialize());此代码
        // 提取ajax 的数据 empName=1052471839%40qq.com&email=1052471839%40qq.com&gender=M&dId=1
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data: $("#empAddModel form").serialize(),
            success:function(result) {
                //alert(result.msg);
                //员工保存成功
                //1.关闭模态框
                if(result.code == 100) {
                    $("#empAddModel").modal('hide');
                    //2.跳到最后一页,显示刚才保存的数据
                    //发送ajax请求显示最后一页数据即可
                    to_page(totalRecord);
                }else {
                   //从后端校验拿到错误信息展示出来
                    //有那个字段的错误信息就显示那个字段的 result.extend.errorFields.email 错误信息的提示条
                    if(undefined!=result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined!=result.extend.errorFields.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }

            }

        })
    })
    //1.我们是按钮创建之前就绑定了click，所有绑定不上
    //1）、可以在创建按钮的时候绑定，2）绑定点击,live()
    $(document).on("click",".edit_btn",function () {
        // alert("edit");

        //1、查出部门信息，并显示部门列表
        getDepts("#empUpdateModel select")
        //2、查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        //3.把员工的id传递给模态框更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModel").modal({
            backdrop: "static"
        });
    });
    //查出员工信息的请求
        function getEmp(id) {
           $.ajax({
               url:"${APP_PATH}/emp/"+id,
               type:"GET",
               success:function (result) {
                    // console.log(result);
                   //获取编辑的所有值
                    var empData = result.extend.emp;
                    $("#empName_update_static").text(empData.empName);//在指定位置显示名字
                   $("#email_update_input").val(empData.email);
                    $("#empUpdateModel input[name=gender]").val([empData.gender]);//获取性别的位置，指定单选框内的值男\女
                    $("#empUpdateModel select").val([empData.dId]);//显示下拉列表的值
               }
           });
        }
        //点击更新，更新员工信息
        $("#emp_update_btn").click(function () {
            //验证邮箱是否合法
            //2.校验邮箱信息
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)) {
                show_validate_msg("#email_update_input","error","邮箱地址不对");
                return false;
            }else {
                show_validate_msg("#email_update_input","success","");
            }
            //2.发送ajax请求保存更新员工信息
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                type:"PUT",
                data:$("#empUpdateModel form").serialize(),//员工修改表单修改序列化后的结果
                success:function (result) {
                    // alert(result.msg);
                    //1.关闭对话框
                    $("#empUpdateModel").modal("hide");
                    //2.回到本页面
                    to_page(currentPage);
                }
            });
        });
        //单个删除
    $(document).on("click",".delete_btn",function () {
        //1.弹出是否删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        //获取要被删除的员工id
        var empId = $(this).attr("del-id");
        // alert($(this).parents("tr").find("td:eq(1)").text());
        if(confirm("确认删除【"+empName+"】吗？")) {
            //确认删除，发送ajax请求删除即可
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到本页面
                    to_page(currentPage);
                }
            });
        }
    });
    //完成全选/全不选功能
    $("#check_all").click(function () {
        //attr获取checked是undefined
        //我们这些dom原生的属性： attr获取自定义属性的值：
        //prop修改和读取dom原生属性的值
     // $(this).prop("checked");//选中状态
        $(".check_item").prop("checked",$(this).prop("checked"));//所有选中框状态同步
    });
    //check_item
    $(document).on("click",".check_item",function () {
        //判断当前选选择中元素是否5个
       var flag =  $(".check_item:checked").length==$(".check_item").length;//判断单选按钮是否全选满，是则为ture否则为false
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function () {
        // $(".check_item:checked")
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function () {
            //this
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            //员工id字符串组装
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除删除的id多余的 -
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        //去掉empNames多余的 ,
        empNames=empNames.substring(0,empNames.length-1);
        if (confirm("确认删除【"+empNames+"】吗?")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到本页面
                    to_page(currentPage);
                }
            })
        }
    })
</script>
</body>
</html>
