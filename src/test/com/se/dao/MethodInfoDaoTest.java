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
public class MethodInfoDaoTest {

    @Resource
    private MethodInfoDao methodInfoDao;

    @Resource
    private MethodInvocationInfoDao methodInvocationInfoDao;


    @Test
    public void getMethodInfoListByClassName(){
        List<MethodInfo> methodInfoList = methodInfoDao.getMethodInfoListByClassName("agency.tango.materialintroscreen.widgets.InkPageIndicator","TangoAgency");
        for(MethodInfo methodInfo:methodInfoList){
            if(methodInfo.getTopicWords()!=null){
                System.out.println(methodInfo.getTopicWords());
            }
        }
    }

    @Test
    public void getPossibleMethodInfo(){
        List<MethodInvocationInfo> methodInvocationInfoList = methodInvocationInfoDao.selectAll();
        MethodInvocationInfo m = methodInvocationInfoList.get(0);
    }

    @Test
    public void getAllCloneGroupId(){
        List<String> cloneGroupIdList = methodInfoDao.getSameProjectCloneGroupId();
        System.out.println(cloneGroupIdList.size());
    }
}