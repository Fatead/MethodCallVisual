package com.se.service.impl;


import com.se.service.MethodInvocationCycle;
import com.se.vo.TreeLink;
import com.se.vo.TreeNode;
import com.se.vo.tree.Tree;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class MethodInvocationCycleTest {

    @Resource
    private MethodInvocationCycle methodInvocarionCycle;

    @Test
    public void getAllCycles(){
        methodInvocarionCycle.getAllCycles("ysc");
    }

    @Test
    public void getCycleFromTree(){
        List<TreeNode> NodeList = new ArrayList<>();
        List<TreeLink> LinkList = new ArrayList<>();
        NodeList.add(new TreeNode("A"));
        NodeList.add(new TreeNode("B"));
        NodeList.add(new TreeNode("C"));
        NodeList.add(new TreeNode("D"));
        NodeList.add(new TreeNode("E"));
        NodeList.add(new TreeNode("F"));
        LinkList.add(new TreeLink("A","B"));
        LinkList.add(new TreeLink("B","A"));
        LinkList.add(new TreeLink("B","D"));
        LinkList.add(new TreeLink("A","C"));
        LinkList.add(new TreeLink("F","B"));
        LinkList.add(new TreeLink("E","A"));
        System.out.println(methodInvocarionCycle.getCycleFromTree(NodeList,LinkList));
    }

}
