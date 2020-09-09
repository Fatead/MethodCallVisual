package com.se.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface MethodInvocationInViewService {

    Map<String, String> getAllMethodInvokeTreeRootsByProjectName(String projectName);

    Map<String, List> getMethodInvokeTreeByMethodId(String methodId, String methodName);


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
     * 判断是否存在环状调用并返回
     * @param methodId
     * @param methodName
     * @return
     */
    Map<String, List> getMethodInvokeAndCycleFlag(String methodId, String methodName);



}
