package com.se.service;

import com.se.vo.GraphLink;
import com.se.vo.GraphNode;

import java.util.List;
import java.util.Map;

public interface GraphService {

    List<GraphNode> getGraphNodeList();

    List<GraphLink> getGraphLinkList();

    /**
     * 根据项目名生成节点和关系
     * @param projectName
     * @return
     */
    Map<String, List> getGraphNodeAndLinkMap(String projectName);

    Map<String, List> getGraphNodeAndLinkMapWithMethodCall(String projectName);

    Map<String, List> getGraphNodeAndLinkInView(String projectName);

    Map<String, List> getGraphNodeAndLinkInViewInClassGra(String projectName);

    List<String> getAllProjectName();

    List<String> getAllCloneSetByProjectName(String projectName);

    List<String> getMethodInCloneSet(String cloneSetID);

}
