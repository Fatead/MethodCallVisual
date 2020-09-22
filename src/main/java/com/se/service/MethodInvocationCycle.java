package com.se.service;

import com.se.vo.TreeLink;
import com.se.vo.TreeNode;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface MethodInvocationCycle {

    boolean getCycleFromTree(List<TreeNode> graphNodeList, List<TreeLink> graphLinkList);

//    Set<String> getMethodInfoInCycle(String projectName);

    Map<String, List> getAllCycles(String projectName);
}
