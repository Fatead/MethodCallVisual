package com.se.service.impl;

import com.se.dao.MethodInvocationInViewDao;
import com.se.entity.NodeRelation;
import com.se.entity.NodeSize;
import com.se.entity.NodeType;
import com.se.pojo.MethodInvocationInView;
import com.se.service.MethodInvocationInViewService;
import com.se.vo.GraphNode;
import com.se.vo.TreeLink;
import com.se.vo.TreeNode;
import com.se.vo.tree.Node;
import com.se.vo.tree.Tree;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class MethodInvocationInViewServiceImpl implements MethodInvocationInViewService {


    @Resource
    private MethodInvocationInViewDao methodInvocationInViewDao;

    private static boolean cycleFlag;

    private static Set<String> cycleMethodSet;

    private static List<String> callChain;

    private static String branchNodeMethodId;


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

    /**
     * 获取方法调用树以及是否包含环状调用
     * @param rootMethodId
     * @param rootMethodName
     * @return
     */
    @Override
    public Map<String, List> getMethodCallCycleByRootName(String rootMethodId, String rootMethodName) {
        cycleFlag = false;
        cycleMethodSet = new HashSet<>();
        callChain = new ArrayList<>();
        branchNodeMethodId = rootMethodId;

        List<MethodInvocationInView> methodCalls = this.getMethodCallCycle(rootMethodId);

        Set<TreeNode> graphNodeSet = new HashSet<>();
        Set<TreeLink> graphLinkSet = new HashSet<>();

        graphNodeSet.add(new TreeNode(rootMethodId, rootMethodName, NodeType.METHOD_NODE, NodeSize.METHOD_SIZE)); // 加入根节点

        for(MethodInvocationInView methodCall : methodCalls){
            graphNodeSet.add(new TreeNode(methodCall.getCalledMethodID(), methodCall.getCalledMethodName(), NodeType.METHOD_NODE, NodeSize.METHOD_SIZE));
            graphLinkSet.add(new TreeLink(methodCall.getCallMethodID(), methodCall.getCalledMethodID(), NodeRelation.INVOKES));
        }

        Map<String, List> nodeAndLinkMap = new HashMap<>();

        List<Boolean> cycleFlags = new ArrayList<>();
        cycleFlags.add(cycleFlag);
        nodeAndLinkMap.put("cycleFlag", cycleFlags);
        List<String> cycleMethodList =new ArrayList<>(cycleMethodSet);
        nodeAndLinkMap.put("cycleList", cycleMethodList);
        nodeAndLinkMap.put("entity", new ArrayList(graphNodeSet));
        nodeAndLinkMap.put("relation", new ArrayList(graphLinkSet));
        return nodeAndLinkMap;
    }

//    @Override
//    public List<MethodInvocationInView> getMethodCallCycle(String rootMethodId, List<String> callChain, String branchNodeMethodId){
//        List<MethodInvocationInView> list = new ArrayList<>();
//
//        List<MethodInvocationInView> methodCalls =  methodInvocationInViewDao.getMethodCallByCallerMethodId(rootMethodId);
//
//        if(methodCalls.size() > 1){
//            branchNodeMethodId = rootMethodId;
//            callChain.add(rootMethodId);
//        } else if(methodCalls.size() == 0)
//            callChain = callChain.subList(0, callChain.indexOf(branchNodeMethodId) + 1);
//        else {
//            callChain.add(rootMethodId);
//        }
//
//        for(MethodInvocationInView methodCall : methodCalls){
//            if(methodCall.getCallMethodID().equals(methodCall.getCalledMethodID()))
//                continue; //过滤递归调用
//            list.add(methodCall);
//            if(callChain.contains(methodCall.getCalledMethodID())){
//                // 存在环状调用
//                cycleFlag = true;
//                List<String> methodIdInCycle = callChain.subList(callChain.indexOf(methodCall.getCalledMethodID()), callChain.size());
//                cycleMethodSet.addAll(methodIdInCycle);
//                callChain = callChain.subList(0, callChain.indexOf(branchNodeMethodId) + 1);
//            } else {
//                list.addAll(this.getMethodCallCycle(methodCall.getCalledMethodID(), callChain, branchNodeMethodId));
//            }
//        }
//
//        return list;
//    }

    @Override
    public List<MethodInvocationInView> getMethodCallCycle(String rootMethodId){
        List<MethodInvocationInView> list = new ArrayList<>();

        List<MethodInvocationInView> methodCalls =  methodInvocationInViewDao.getMethodCallByCallerMethodId(rootMethodId);

        if(methodCalls.size() > 1){
            branchNodeMethodId = rootMethodId;
            callChain.add(rootMethodId);
        } else if(methodCalls.size() == 0)
            callChain = callChain.subList(0, callChain.indexOf(branchNodeMethodId) + 1);
        else {
            callChain.add(rootMethodId);
        }

        for(MethodInvocationInView methodCall : methodCalls){
            if(methodCall.getCallMethodID().equals(methodCall.getCalledMethodID()))
                continue; //过滤递归调用
            list.add(methodCall);
            if(callChain.contains(methodCall.getCalledMethodID())){
                // 存在环状调用
                cycleFlag = true;
                List<String> methodIdInCycle = callChain.subList(callChain.indexOf(methodCall.getCalledMethodID()), callChain.size());
                cycleMethodSet.addAll(methodIdInCycle);
                callChain = callChain.subList(0, callChain.indexOf(branchNodeMethodId) + 1);
            } else {
                list.addAll(this.getMethodCallCycle(methodCall.getCalledMethodID()));
            }
        }

        return list;
    }


    /**
     * 获取方法调用树
     * @param methodId
     * @param methodName
     * @return
     */
    @Override
    public Map<String, List> getMethodInvokeTreeByMethodId(String methodId, String methodName) {
//        List<MethodInvocationInView> result = methodInvocationInViewDao.getMethodCallTreeByRootName(methodId);
        List<String> callChain = new ArrayList<>();
        List<MethodInvocationInView> result = this.getMethodCallChainByRootName(methodId, callChain, methodId);
//        Tree tree = new Tree();
//        //节点是方法调用，而不是方法
//        Node treeNode = tree.buildTreeAndGetRoots(result, methodId, methodName);
//        return tree.breadthFirst(treeNode);
        return  this.getMethodCallChainNodeAndLinkMap(result, methodId, methodName);
    }

    @Override
    public Map<String, List> getMethodCallChainNodeAndLinkMap(List<MethodInvocationInView> methodCalls, String rootMethodId, String rootMethodName){
        Set<TreeNode> graphNodeSet = new HashSet<>();
        Set<TreeLink> graphLinkSet = new HashSet<>();

        graphNodeSet.add(new TreeNode(rootMethodId, rootMethodName, NodeType.METHOD_NODE, NodeSize.METHOD_SIZE)); // 加入根节点

        for(MethodInvocationInView methodCall : methodCalls){
            graphNodeSet.add(new TreeNode(methodCall.getCalledMethodID(), methodCall.getCalledMethodName(), NodeType.METHOD_NODE, NodeSize.METHOD_SIZE));
            graphLinkSet.add(new TreeLink(methodCall.getCallMethodID(), methodCall.getCalledMethodID(), NodeRelation.INVOKES));
        }

        Map<String, List> nodeAndLinkMap = new HashMap<>();
        nodeAndLinkMap.put("entity", new ArrayList(graphNodeSet));
        nodeAndLinkMap.put("relation", new ArrayList(graphLinkSet));
        return nodeAndLinkMap;
    }

    @Override
    public List<MethodInvocationInView> getMethodCallChainByRootName(String rootMethodId, List<String> callChain, String branchNodeMethodId){
        callChain.add(rootMethodId);

        List<MethodInvocationInView> list = new ArrayList<>();

        List<MethodInvocationInView> methodCalls =  methodInvocationInViewDao.getMethodCallByCallerMethodId(rootMethodId);

        if(methodCalls.size() > 1)
            branchNodeMethodId = rootMethodId;
        else if(methodCalls.size() == 0)
            callChain = callChain.subList(0, callChain.indexOf(branchNodeMethodId) + 1);

        for(MethodInvocationInView methodCall : methodCalls){
            list.add(methodCall);
            if(callChain.contains(methodCall.getCalledMethodID())){
                // 存在环状调用
                callChain = callChain.subList(0, callChain.indexOf(branchNodeMethodId) + 1);
            } else {
                list.addAll(this.getMethodCallChainByRootName(methodCall.getCalledMethodID(), callChain, branchNodeMethodId));
            }
        }

        return list;
    }


}