package com.se.service;

import com.se.pojo.MethodInvocationInView;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface MethodInvocationInViewService {

    Map<String, String> getAllMethodInvokeTreeRootsByProjectName(String projectName);



    /**
     * 获取入度不为0且出度不为0的节点
     * @param projectName
     * @return
     */
    Map<String, String> getAllInvokedMethodsByProjectName(String projectName);

    /**
     * 获取方法调用树中叶子结点上的被调用方法
     * @param methodId
     * @param methodName
     * @return
     */
    Set<String> getLeafNodesOfCallTree(String methodId, String methodName);

    /**
     * 获取环状调用
     * @param rootMethodId
     * @param rootMethodName
     * @return
     */
    Map<String, List> getMethodCallCycleByRootName(String rootMethodId, String rootMethodName);

//    List<MethodInvocationInView> getMethodCallCycle(String rootMethodId, List<String> callChain, String branchNodeMethodId);

    List<MethodInvocationInView> getMethodCallCycle(String rootMethodId, String branchNodeMethodId);

    /**
     * 获取方法调用树
     * @param methodId
     * @param methodName
     * @return
     */
    Map<String, List> getMethodInvokeTreeByMethodId(String methodId, String methodName);

    Map<String, List> getMethodCallChainNodeAndLinkMap(List<MethodInvocationInView> methodCalls, String rootMethodId, String rootMethodName);

    List<MethodInvocationInView> getMethodCallChainByRootName(String rootMethodId, List<String> callChain, String branchNodeMethodId);


}
