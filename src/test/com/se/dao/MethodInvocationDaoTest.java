package com.se.dao;

import com.se.pojo.MethodInfo;
import com.se.pojo.MethodInvocationInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class MethodInvocationDaoTest {

    @Resource
    private MethodInfoDao methodInfoDao;

    @Resource
    private MethodInvocationInfoDao methodInvocationInfoDao;


    @Test
    public void getMethodInfoListByClassName(){
        List<MethodInfo> methodInfoList = methodInfoDao.getMethodInfoListByClassName("com.wind.myLuence.Context","ysc");
        methodInfoList.forEach(System.out::println);
    }

    @Test
    public void getMethodInvocationInfoByProjectName(){
        String projectName = "ysc";
        List<MethodInvocationInfo> methodInvocationInfoList = methodInvocationInfoDao.getMethodInvocationByProjectName(projectName);
        methodInvocationInfoList.forEach(System.out::println);
    }

    @Test
    public void getPossibleMethodInfo(){
        List<MethodInvocationInfo> methodInvocationInfoList = methodInvocationInfoDao.selectAll();
        MethodInvocationInfo m = methodInvocationInfoList.get(0);
    }
}
