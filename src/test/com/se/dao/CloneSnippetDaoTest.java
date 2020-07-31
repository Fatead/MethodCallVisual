package com.se.dao;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class CloneSnippetDaoTest {

    @Resource
    private CloneSnippetDao cloneSnippetDao;

    @Test
    public void getAllCloneSetByProjectName(){
        List<String> cloneIdList = cloneSnippetDao.getAllCloneSetByProjectName("ysc");
        for(String str:cloneIdList){
            System.out.println(str);
        }
    }

    @Test
    public void getMethodIdInCloneSet(){
        List<String> methodId = cloneSnippetDao.getAllMethodInCloneSet("162");
        for(String str:methodId){
            System.out.println(str);
        }
    }

}
