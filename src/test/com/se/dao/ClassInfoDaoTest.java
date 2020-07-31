package com.se.dao;

import com.se.pojo.ClassInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class ClassInfoDaoTest {

    @Resource
    private ClassInfoDao classInfoDao;

//    @Test
//    public void getClassInfoByInterfaceNameWithoutPackage() {
//        String projectName = classInfoDao.getProjectNameList().get(0);
//        String interfaceName = String.format("%%.%s%%","MyLuenceFactory");
//        List<ClassInfo> classInfoList = classInfoDao.getClassInfoByInterfaceNameWithoutPackage(projectName, interfaceName);
//        String result = "";
//        if(classInfoList.size()>0)
//            result = classInfoList.get(0).getClassname();
//        System.out.println(result);
//    }

    @Test
    public void getAllProjectName(){
        List projectNameList = classInfoDao.getProjectNameList();
        System.out.println(projectNameList);

    }

    @Test
    public void getIdByClassName(){
        String id = classInfoDao.getIdByClassName("com.wind.myLuence.config.CfFileParser","MyLuence-master");
        System.out.println(id);

    }



}
