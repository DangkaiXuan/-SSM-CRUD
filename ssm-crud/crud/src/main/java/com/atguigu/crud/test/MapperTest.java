package com.atguigu.crud.test;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Emplovee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmploveeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试dao层的工作
 * @author dkx
 *推荐使用spring单元测试模块
 * 1.导入springTest模块
 * 2.@ContextConfiguration指定Spring配置文件的位置
 */
//spring提供的单元测试@RunWith
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmploveeMapper emploveeMapper;
    @Autowired
    SqlSession sqlSession;
    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD() {
    //1.创建SpringIOC容器
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//    // 从容器中获取mapper
//        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper+"1111");

        //1.插入几个部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"运营部"));

        //2.生成员工数据，测试员工插入
//        emploveeMapper.insertSelective(new Emplovee(null,"Jerry","M","Jerry@atguigu.com",1));
        //3.插入多个员工，批量使用可执行批量操作
        EmploveeMapper mapper = sqlSession.getMapper(EmploveeMapper.class);

        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Emplovee(null,uid,"M",uid+"@atguigu.com",1));
        }
        System.out.println("批量完成");
    }
}
