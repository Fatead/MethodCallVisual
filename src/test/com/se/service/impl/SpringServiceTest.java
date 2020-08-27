package com.se.service.impl;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.se.service.SpringService;
import com.se.vo.SpringNode;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class SpringServiceTest {

    @Resource
    private SpringService springService;

    @Test
    public void getLayerClassTest(){
        Map<String, SpringNode> springNodeMap =  springService.getLayerClass("HardChair-Backend-master");
        System.out.println(springNodeMap.size());
        JSONObject jsonObject = new JSONObject();
        JSONArray controlArray = new JSONArray();
        for(SpringNode springNode:springNodeMap.values()){
            System.out.println("控制层：" + springNode.getClassName());
            JSONObject controlObject = new JSONObject();
            controlObject.put("name",springNode.getClassName());
            JSONArray serviceArray = new JSONArray();
            for(SpringNode springNode1:springNode.getChildren()){
                JSONArray daoArray = new JSONArray();
                JSONObject serviceObject = new JSONObject();
                serviceObject.put("name",springNode1.getClassName());
                for(SpringNode springNode2:springNode1.getChildren()){
                    JSONObject daoObject = new JSONObject();
                    daoObject.put("name",springNode2.getClassName());
                    daoArray.add(daoObject);
                }
                serviceObject.put("children",daoArray);
                serviceArray.add(serviceObject);
            }
            controlObject.put("children",serviceArray);
            controlArray.add(controlObject);
        }
        jsonObject.put("children",controlArray);
        System.out.println(jsonObject);
    }


}
