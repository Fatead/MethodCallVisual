package com.se.service.impl;

import com.se.dao.MethodInvocationInViewDao;
import com.se.entity.NodeType;
import com.se.pojo.MethodInvocationInView;
import com.se.service.MethodInvocationInViewService;
import com.se.vo.GraphNode;
import com.se.vo.tree.Node;
import com.se.vo.tree.Tree;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class MethodInvocationInViewServiceImpl implements MethodInvocationInViewService {


    @Resource
    private MethodInvocationInViewDao methodInvocationInViewDao;


    @Override
    public Map<String, String> getAllMethodInvokeTreeRootsByProjectName(String projectName) {
        //计算入度为0的节点
        Set<GraphNode> graphNodeSet = new HashSet<>();
        List<MethodInvocationInView> methodInvocationInViewList =  methodInvocationInViewDao.getMethodInvocationInViewByProjectName(projectName);
        Set<GraphNode> calledMethodSet = new HashSet<>();
        Set<GraphNode> callMethodSet = new HashSet<>();
        for(MethodInvocationInView methodInvocationInView:methodInvocationInViewList){
            graphNodeSet.add(new GraphNode(methodInvocationInView.getCallMethodID(),methodInvocationInView.getCallMethodName(), NodeType.METHOD_NODE));
            graphNodeSet.add(new GraphNode(methodInvocationInView.getCalledMethodID(),methodInvocationInView.getCalledMethodName(),NodeType.METHOD_NODE));
            //计算入度
            calledMethodSet.add(new GraphNode(methodInvocationInView.getCalledMethodID(),methodInvocationInView.getCalledMethodName(), NodeType.METHOD_NODE));
            callMethodSet.add(new GraphNode(methodInvocationInView.getCallMethodID(),methodInvocationInView.getCallMethodName(), NodeType.METHOD_NODE));
        }
        graphNodeSet.removeAll(calledMethodSet);    //入度为0的节点
        Map<String, String> rootMethodIdAndName = new HashMap<>();
        for(GraphNode rootNode : graphNodeSet){
            //排除孤立结点
            if(callMethodSet.contains(rootNode))
                rootMethodIdAndName.put(rootNode.getId(), rootNode.getName());
        }
        return rootMethodIdAndName;
    }

    @Override
    public Map<String, List> getMethodInvokeTreeByMethodId(String methodId, String methodName) {
        List<MethodInvocationInView> result = methodInvocationInViewDao.getMethodCallTreeByRootName(methodId);
        Tree tree = new Tree();
        //节点是方法调用，而不是方法
        Node treeNode = tree.buildTreeAndGetRoots(result, methodId, methodName);
        return tree.breadthFirst(treeNode);
    }

    @Override
    public Map<String, String> getAllInvokedMethodsByProjectName(String projectName) {
        //获取入度不为0且出度不为0的节点
        List<MethodInvocationInView> methodInvocationInViewList =  methodInvocationInViewDao.getMethodInvocationInViewByProjectName(projectName);

        Set<GraphNode> calledMethodSet = new HashSet<>();
        Set<GraphNode> callMethodSet = new HashSet<>();
        for(MethodInvocationInView methodInvocationInView:methodInvocationInViewList) {
            calledMethodSet.add(new GraphNode(methodInvocationInView.getCalledMethodID(),methodInvocationInView.getCalledMethodName(), NodeType.METHOD_NODE));
            callMethodSet.add(new GraphNode(methodInvocationInView.getCallMethodID(),methodInvocationInView.getCallMethodName(), NodeType.METHOD_NODE));
        }

        Map<String, String> calledMethodMap = new HashMap<>();
        for(GraphNode calledMethodNode : calledMethodSet){
            if(callMethodSet.contains(calledMethodNode))
                calledMethodMap.putIfAbsent(calledMethodNode.getId(), calledMethodNode.getName());
        }

        return calledMethodMap;
    }

    @Override
    public Set<String> getLeafNodesOfCallTree(String methodId, String methodName) {
        List<MethodInvocationInView> result = methodInvocationInViewDao.getMethodCallTreeByRootName(methodId);
        Tree tree = new Tree();
        //节点是方法调用，而不是方法
        Node treeNode = tree.buildTreeAndGetRoots(result, methodId, methodName);

        // 获取方法调用树中叶子结点上的被调用方法
        Set<Node> leafNodes = treeNode.getAllLeafNodes();
        Set<String> leafMethodCallNodes = new HashSet<>();
        for(Node methodCallNode : leafNodes){
            if(methodCallNode.associatedObject != null)
                leafMethodCallNodes.add(methodCallNode.associatedObject.getCalledMethodID());
        }

        return leafMethodCallNodes;
    }


    public Map<String, List> getMethodInvokeAndCycleFlag(String methodId, String methodName) {
        List<MethodInvocationInView> result = methodInvocationInViewDao.getMethodCallTreeByRootName(methodId);
        Tree tree = new Tree();
        //节点是方法调用，而不是方法
        Node treeNode = tree.buildTreeAndGetRoots(result, methodId, methodName);
        return tree.depthFirsh(treeNode);
    }

}