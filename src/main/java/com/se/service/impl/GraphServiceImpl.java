package com.se.service.impl;

import com.se.dao.*;
import com.se.pojo.ClassInfo;
import com.se.pojo.MethodInfo;
import com.se.pojo.MethodInvocationInView;
import com.se.service.GraphService;
import com.se.entity.NodeRelation;
import com.se.entity.NodeSize;
import com.se.entity.NodeType;
import com.se.util.StringUtil;
import com.se.vo.GraphLink;
import com.se.vo.GraphNode;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class GraphServiceImpl implements GraphService {

    @Resource
    private ClassInfoDao classInfoDao;
    @Resource
    private MethodInfoDao methodInfoDao;
    @Resource
    private CloneSnippetDao cloneSnippetDao;
    @Resource
    private MethodInvocationInfoDao methodInvocationInfoDao;
    @Resource
    private MethodInvocationInViewDao methodInvocationInViewDao;
    @Override
    public List<GraphNode> getGraphNodeList() {
        return null;
    }
    @Override
    public List<GraphLink> getGraphLinkList() {
        return null;
    }

    /**
     * 数据库中不含id的实现版本, 现在没有用
     * @param projectName
     * @return
     */
    @Override
    public Map<String, List> getGraphNodeAndLinkMap(String projectName) {
        List<ClassInfo> classInfoList = classInfoDao.getAllNonAnonymousClassByProjectName(projectName); //所有类（不包含匿名类）

        Map<String, String> classNameIdMap = new HashMap<>(); //类名与id的映射
        Map<String, String> methodNameIdMap = new HashMap<>(); //方法名与id的映射
        Map<String,String> ID2UUIDMap = new HashMap<>();

        Map<String, List> nodeAndLinkMap = new HashMap<>();
        List<GraphNode> graphNodeList = new ArrayList<>();
        List<GraphNode> InvocationNodeList = new ArrayList<>();
        List<GraphLink> graphLinkList = new ArrayList<>();

        for(int i = 0; i < classInfoList.size(); i++){
            ClassInfo currentClass = classInfoList.get(i);
            //1. 创建类/接口节点
            String classNodeId = StringUtil.UUID();
            if(!ID2UUIDMap.containsKey(String.valueOf(currentClass.getID())))
                ID2UUIDMap.put(String.valueOf(currentClass.getID()),classNodeId);

            String className = currentClass.getClassName();
            String nodeName = StringUtil.getNameWithoutPackage(className);

            GraphNode classNode = new GraphNode(classNodeId, nodeName, NodeSize.CLASS_SIZE);
            classNode.setCategory(currentClass.getInterface().equals(true) ? NodeType.INTERFACE_NODE : NodeType.CLASS_NODE);
            graphNodeList.add(classNode);
            classNameIdMap.put(className, classNodeId);


            //3. 类与方法的关系
            List<MethodInfo> methodInfoList = methodInfoDao.getMethodInfoListByClassName(className,projectName);
            for(int j = 0; j < methodInfoList.size(); j++){

                //3.1 创建方法节点
                String methodNodeId = StringUtil.UUID();
                if(!ID2UUIDMap.containsKey(String.valueOf(methodInfoList.get(j).getID())))
                    ID2UUIDMap.put(String.valueOf(methodInfoList.get(j).getID()),methodNodeId);
                GraphNode methodNode = new GraphNode(methodNodeId, methodInfoList.get(j).getMethodName(), NodeType.METHOD_NODE, NodeSize.METHOD_SIZE);
                graphNodeList.add(methodNode);

                //3.2 创建类和方法的包含关系
                GraphLink graphLink = new GraphLink(classNodeId, methodNodeId, NodeRelation.CONTAINS);
                graphLinkList.add(graphLink);

            }
            //创建方法调用关系
            //nodeAndLinkMap = methodInvocationService.getMethodInvocationGraphLinkListByProjectName(projectName,ID2UUIDMap);
        }
        nodeAndLinkMap.put("entity", graphNodeList);
        nodeAndLinkMap.put("relation", graphLinkList);
        return nodeAndLinkMap;
    }

    /**
     * 数据库中包含id的实现版本
     * @param projectName
     * @return
     */
    @Override
    public Map<String, List> getGraphNodeAndLinkMapWithMethodCall(String projectName) {
        List<ClassInfo> classInfoList = classInfoDao.getAllNonAnonymousClassByProjectName(projectName); //所有类（不包含匿名类）
        Map<String, List> nodeAndLinkMap = new HashMap<>();
        List<GraphNode> graphNodeList = new ArrayList<>();
        List<GraphLink> graphLinkList = new ArrayList<>();

        for(int i = 0; i < classInfoList.size(); i++){
            ClassInfo currentClass = classInfoList.get(i);

            //1. 创建类/接口节点
            String className = currentClass.getClassName();
            String nodeName = StringUtil.getNameWithoutPackage(className);

            GraphNode classNode = new GraphNode(String.valueOf(currentClass.getID()), nodeName, NodeSize.CLASS_SIZE);
            classNode.setCategory(currentClass.getInterface().equals(true) ? NodeType.INTERFACE_NODE : NodeType.CLASS_NODE);
            graphNodeList.add(classNode);


            //3. 类与方法的关系
            List<MethodInfo> methodInfoList = methodInfoDao.getMethodInfoListByClassName(className,projectName);
            for(int j = 0; j < methodInfoList.size(); j++){

                //3.1 创建方法节点
                GraphNode methodNode = new GraphNode(String.valueOf(methodInfoList.get(j).getID()), methodInfoList.get(j).getMethodName(), NodeType.METHOD_NODE, NodeSize.METHOD_SIZE);
                graphNodeList.add(methodNode);

                //3.2 创建类和方法的包含关系
                GraphLink graphLink = new GraphLink(String.valueOf(currentClass.getID()), String.valueOf(methodInfoList.get(j).getID()), NodeRelation.CONTAINS);
                graphLinkList.add(graphLink);
            }
        }

        //todo: 5 方法与方法的调用关系（基础版本，将重载的方法视为同一个方法）
        //graphLinkList.addAll(methodCallService.getMethodCallGraphLinkListByProjectName(projectName));
        nodeAndLinkMap.put("entity", graphNodeList);
        nodeAndLinkMap.put("relation", graphLinkList);
        return nodeAndLinkMap;
    }

    @Override
    public Map<String, List> getGraphNodeAndLinkInView(String projectName){
        Set<String> methodNodeSet = new HashSet<>();
        List<GraphNode> graphNodeList = new ArrayList<>();
        List<GraphLink> graphLinkList = new ArrayList<>();
        Map<String, List> nodeAndLinkMap = new HashMap<>();
        List<MethodInvocationInView> methodInvocationInViewList =  methodInvocationInViewDao.getMethodInvocationInViewByProjectName(projectName);
        //加入方法调用关系
        for(MethodInvocationInView methodInvocationInView:methodInvocationInViewList){
            if(!methodNodeSet.contains(methodInvocationInView.getCallMethodID())){
                graphNodeList.add(new GraphNode(methodInvocationInView.getCallMethodID(),methodInvocationInView.getCallMethodName(),methodInvocationInView.getCallClassName(),NodeType.METHOD_NODE,NodeSize.METHOD_SIZE));
                methodNodeSet.add(methodInvocationInView.getCallMethodID());
            }
            if(!methodNodeSet.contains(methodInvocationInView.getCalledMethodID())){
                graphNodeList.add(new GraphNode(methodInvocationInView.getCalledMethodID(),methodInvocationInView.getCalledMethodName(),methodInvocationInView.getCalledClassName(),NodeType.METHOD_NODE,NodeSize.METHOD_SIZE));
                methodNodeSet.add(methodInvocationInView.getCalledMethodID());
            }
            graphLinkList.add(new GraphLink(methodInvocationInView.getCallMethodID(),methodInvocationInView.getCalledMethodID(),NodeRelation.INVOKES));
        }
        nodeAndLinkMap.put("entity", graphNodeList);
        nodeAndLinkMap.put("relation", graphLinkList);
        return nodeAndLinkMap;
    }

    @Override
    public Map<String, List> getGraphNodeAndLinkInViewInClassGra(String projectName){
        Set<String> classNodeSet = new HashSet<>();
        List<GraphNode> graphNodeList = new ArrayList<>();
        List<GraphLink> graphLinkList = new ArrayList<>();
        Map<String, List> nodeAndLinkMap = new HashMap<>();
        List<MethodInvocationInView> methodInvocationInViewList =  methodInvocationInViewDao.getMethodInvocationInViewByProjectName(projectName);
        for(MethodInvocationInView methodInvocationInView:methodInvocationInViewList){
            if(methodInvocationInView.getCallClassID().equals(methodInvocationInView.getCalledClassID()))continue;
            if(!classNodeSet.contains(methodInvocationInView.getCallClassID())){
                graphNodeList.add(new GraphNode(methodInvocationInView.getCallClassID(),StringUtil.getNameWithoutPackage(methodInvocationInView.getCallClassName()),NodeType.CLASS_NODE));
                classNodeSet.add(methodInvocationInView.getCallClassID());
            }
            if(!classNodeSet.contains(methodInvocationInView.getCalledClassID())){
                graphNodeList.add(new GraphNode(methodInvocationInView.getCalledClassID(),StringUtil.getNameWithoutPackage(methodInvocationInView.getCalledClassName()),NodeType.CLASS_NODE));
                classNodeSet.add(methodInvocationInView.getCalledClassID());
            }
            graphLinkList.add(new GraphLink(methodInvocationInView.getCallClassID(),methodInvocationInView.getCalledClassID(),NodeRelation.INVOKES));
        }
        nodeAndLinkMap.put("entity", graphNodeList);
        nodeAndLinkMap.put("relation", graphLinkList);
        return nodeAndLinkMap;
    }

    @Override
    public List<String> getAllProjectName(){
        return methodInvocationInfoDao.getAllProjectName();
    }

    @Override
    public List<String> getAllCloneSetByProjectName(String projectName){
        return cloneSnippetDao.getAllCloneSetByProjectName(projectName);
    }

    @Override
    public List<String> getMethodInCloneSet(String cloneSetId){
        return cloneSnippetDao.getAllMethodInCloneSet(cloneSetId);
    }
}
