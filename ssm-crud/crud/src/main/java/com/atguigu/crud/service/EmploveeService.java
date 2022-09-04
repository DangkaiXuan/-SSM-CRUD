package com.atguigu.crud.service;

import com.atguigu.crud.bean.Emplovee;
import com.atguigu.crud.bean.EmploveeExample;
import com.atguigu.crud.dao.EmploveeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class EmploveeService {
    @Autowired
    EmploveeMapper emploveeMapper;

    /**
     * 查询所以员工
     * @return
     */
    public List<Emplovee> getAll() {
        return emploveeMapper.selectByExampleWithDept(null);
    }

    /**
     * 员工保存
     * @param emplovee
     */
    public void saveEmp(Emplovee emplovee) {
        emploveeMapper.insertSelective(emplovee);//自动插入
    }

    /**
     * 校验用户名是否可用
     * @param empName
     * @return  true：代表当前姓名客户可用 false：不可用
     */
    public boolean checkUser(String empName) {
        //按照条件统计符合条件的记录数
        EmploveeExample example = new EmploveeExample();
        //创建查询条件
        EmploveeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);//员工的名字必须是给定的值
        //如果有则返回一个记录数
        long count = emploveeMapper.countByExample(example);
        return count == 0;
    }

    /**
     * 按照员工id查询员工
     * @param id
     * @return
     */
    public Emplovee getEmp(Integer id) {
        Emplovee emplovee = emploveeMapper.selectByPrimaryKey(id);
        return emplovee;
    }

    /**
     * 员工更新
     * @param emplovee
     */
    public void updateEmp(Emplovee emplovee) {
         emploveeMapper.updateByPrimaryKeySelective(emplovee);//根据主键有选择的更新
    }

    /**
     * 员工删除
     * @param id
     */
    public void deleteEmp(Integer id) {
        emploveeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmploveeExample example = new EmploveeExample();
        EmploveeExample.Criteria  criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        emploveeMapper.deleteByExample(example);

    }
}
