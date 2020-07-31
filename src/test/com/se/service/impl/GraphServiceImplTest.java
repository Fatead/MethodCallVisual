package com.se.service.impl;

import com.se.dao.ClassInfoDao;
import com.se.dao.MethodInfoDao;
import com.se.pojo.ClassInfo;
import com.se.pojo.MethodInfo;
import com.se.service.ClassInfoService;
import com.se.entity.NodeRelation;
import com.se.entity.NodeSize;
import com.se.entity.NodeType;
import com.se.service.GraphService;
import com.se.service.MethodInvocationService;
import com.se.util.StringUtil;
import com.se.vo.GraphLink;
import com.se.vo.GraphNode;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class GraphServiceImplTest {

    @Autowired
    private ClassInfoDao classInfoDao;
    @Autowired
    private MethodInfoDao methodInfoDao;
    @Autowired
    private GraphService graphService;

    @Test
    public void getGraphNodeAndLinkMap() {
        ClassInfoService classInfoService = new ClassInfoServiceImpl();
        String projectName = "ysc";
        List<ClassInfo> classInfoList = classInfoDao.getAllNonAnonymousClassByProjectName(projectName); //所有类（不包含匿名类）
        Map<String, String> classNameIdMap = new HashMap<>(); //类名与id的映射
        Map<String, List> nodeAndLinkMap = new HashMap<>();
        List<GraphNode> graphNodeList = new ArrayList<>();
        List<GraphLink> graphLinkList = new ArrayList<>();

        for(int i = 0; i < classInfoList.size(); i++){
            ClassInfo currentClass = classInfoList.get(i);

            //1. 创建类/接口节点
            String classNodeId = StringUtil.UUID();
            String className = currentClass.getClassName();
            //String nodeName = StringUtil.getNameWithoutPackage(className);
            classNameIdMap.put(className, classNodeId);
            GraphNode classNode = new GraphNode(classNodeId, className, NodeSize.CLASS_SIZE);
            classNode.setCategory(currentClass.getInterface().equals(true) ? NodeType.INTERFACE_NODE : NodeType.CLASS_NODE);
            graphNodeList.add(classNode);

            //3. 类与方法的关系
            List<MethodInfo> methodInfoList = methodInfoDao.getMethodInfoListByClassName(className,projectName);
            for(int j = 0; j < methodInfoList.size(); j++){
                //3.1 创建方法节点
                String methodNodeId = StringUtil.UUID();
                GraphNode methodNode = new GraphNode(methodNodeId, methodInfoList.get(j).getMethodName(), NodeType.METHOD_NODE, NodeSize.METHOD_SIZE);
                graphNodeList.add(methodNode);

                //3.2 创建类和方法的包含关系
                GraphLink graphLink = new GraphLink(classNodeId, methodNodeId, NodeRelation.CONTAINS);
                graphLinkList.add(graphLink);
            }
        }

        for(int i = 0; i < classInfoList.size(); i++){
            ClassInfo currentClass = classInfoList.get(i);
        }
        //graphLinkList.addAll(methodInvocationService.getMethodInvocationGraphLinkListByProjectName(projectName));
        nodeAndLinkMap.put("entity", graphNodeList);
        nodeAndLinkMap.put("relation", graphLinkList);
    }

    @Test
    public void getGraphNodeAndLinkInView(){
        Map<String, List> nodeAndLinkMap = graphService.getGraphNodeAndLinkInView("ysc");
        List<GraphNode> graphNodeList = nodeAndLinkMap.get("entity");
        for(GraphNode graphNode:graphNodeList){
            System.out.println(graphNode.getQualifiedClassName());
        }
    }

    @Test
    public void getCloneSetByProjectName(){
        List<String> cloneSetList = graphService.getAllCloneSetByProjectName("ysc");
        for(String str:cloneSetList){
            System.out.println(str);
        }
    }


}