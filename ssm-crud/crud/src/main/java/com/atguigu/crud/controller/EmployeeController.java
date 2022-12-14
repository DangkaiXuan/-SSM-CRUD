package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Emplovee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmploveeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 处理员工CRUD请求
 */
@Controller
//@RequestMapping("/emps")
public class EmployeeController {

    /**
     * 如果直接发送ajax=PUT形式的请求
     * 封装的数据
     * Employee{empId=1013, empName='null', gender='null', email='null', dId=null, department=null}
     *
     * 问题：
     * 请求体中有数据
     * employee对象封装不上
     *
     * 原因：
     * Tomcat：
     *      1、将请求体中的数据。封装成一个map
     *      2、request.getParameter("empName")就会从这个map中取值。
     *      3、springmvc封装POJO对象的时候：
     *              会把POJO中每个属性的值，request.getParameter("email")
     *
     * AJAX发送PUT请求引发的血案：
     *      PUT请求，请求体中的数据，requset.getparameter("empName")拿不到
     *      Tomcat一看时PUT请求就不会封装请求体中的数据，只有POST形式的请求才封装
     *
     * 我们要能支持发送PUT之类的请求还要封装请求体中的数据
     * 配置上HttpPutFormContentFilter：
     * 它的作用：将请求体中的数据解析包装成一个map。
     * request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
     *
     * 员工更新
     * @param
     * @return
     */

    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    //springMVC把员工提交来的信息封装
    public Msg saveEmp(Emplovee emplovee, HttpServletRequest request) {
        System.out.println("请求体中的值"+request.getParameter("gender"));
        System.out.println("将要更新的数据： "+ emplovee);
        emploveeService.updateEmp(emplovee);
        return Msg.success();
    }

    /**
     * 根据id查询员工
     */
    @Autowired
    EmploveeService emploveeService;

    /**
     * 单个批量二合一
     * 批量删除 1-2-3
     * 单个删除： 1
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value ="/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids")String ids){
        if(ids.contains("-")) {
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for(String string : str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            emploveeService.deleteBatch(del_ids);
        }else {
            int id = Integer.parseInt(ids);
            emploveeService.deleteEmp(id);
        }
        return Msg.success();
    }
    //单个 删除
//    @ResponseBody
//    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
//    public Msg deleteEmpById(@PathVariable("id")Integer id){
//        emploveeService.deleteEmp(id);
//        return Msg.success();
//    }

    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){  //@PathVariable("id")指定{id}是从路径中取出的id
        Emplovee employee = emploveeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName") String empName) {
        //先判断用户名是否是合法的表达式：
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg","用户名可以是6~16位英文和数字的组合2~5位中文或者");
        }
        //数据库用户名重复校验
        boolean b = emploveeService.checkUser(empName);
        if(b) {
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名不可用");
        }

    }
    /**
     * 员工保存
     * 1.支持JSR303校验  后端约束
     * 2.导入
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody//返回json对象 @Valid封装的数据进行校验 BindingResult封装校验的结果
    public Msg saveEmp(@Valid Emplovee emplovee, BindingResult result) {
        if (result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError : errors) {
                System.out.println("错误的字段名： "+fieldError.getField());
                System.out.println("错误信息： "+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            //校验成功保存信息 返回成功
            emploveeService.saveEmp(emplovee);
            return Msg.success();
        }

    }

    /**
     * 导入jackson包
     * ResponseBody将返回的对象转换为JSON字符串
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Emplovee> emps =emploveeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细的分页信息，包括我们查询出来的数据.传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 查询员工数据（分页查询）
     * @return
     */
    //pn是去第几页 pagenum  发请求@RequestParam传入pagenum默认值是1
    //@RequestMapping("/emps")
    public  String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model) {
        //引入PageHelper分页插件 配置mybatis,
        //在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Emplovee> emps =emploveeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细的分页信息，包括我们查询出来的数据.传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);

        return "list";
    }
}
