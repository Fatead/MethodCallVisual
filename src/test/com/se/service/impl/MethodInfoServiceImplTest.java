package com.se.service.impl;

import com.se.dao.MethodInvocationInfoDao;
import com.se.pojo.MethodInfo;
import com.se.service.MethodInfoService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class MethodInfoServiceImplTest {

    @Resource
    private MethodInfoService methodInfoService;

    @Resource
    private MethodInvocationInfoDao methodInvocationInfoDao;

    @Test
    public void getPossibleCallMethodInfo() {
        List<MethodInfo> MethodInfoList = methodInfoService.getMethodInfoListByNameAndClass("startActivity","com.yqritc.recyclerviewflexibledivider.sample.SimpleActivity","yqritc");
    }
}