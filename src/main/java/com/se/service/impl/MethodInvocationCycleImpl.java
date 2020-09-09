package com.se.service.impl;

import com.se.service.MethodInvocationCycle;
import com.se.service.MethodInvocationInViewService;
import com.se.vo.TreeLink;
import com.se.vo.TreeNode;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class MethodInvocationCycleImpl implements MethodInvocationCycle {


    private boolean circleFlag = false;

    @Resource
    private MethodInvocationInViewService methodInvocationInViewService;

    @Override
    public Map<String, List> getAllCycles(String projectName){
        List<TreeNode> CycleGraphNodeList = new ArrayList<>();
        List<TreeLink> CycleGraphLinkList = new ArrayList<>();
        Map<String, List> CycleNodeAndLinkMap = new HashMap<>();

        // 入度出度都不为0
        Map<String,String> methodInvoke = methodInvocationInViewService.getAllInvokedMethodsByProjectName(projectName);

        for(String str:methodInvoke.keySet()){
            Map<String, List> nodeAndLinkMap = methodInvocationInViewService.getMethodInvokeAndCycleFlag(str,methodInvoke.get(str));
            List<TreeNode> graphNodeList = nodeAndLinkMap.get("entity");
            List<TreeLink> graphLinkList = nodeAndLinkMap.get("relation");
            boolean cycleFlag = (boolean)nodeAndLinkMap.get("cycleFlag").get(0);
            if(cycleFlag){
                CycleGraphLinkList.addAll(graphLinkList);
                CycleGraphNodeList.addAll(graphNodeList);
            }
        }
        CycleNodeAndLinkMap.put("entity", CycleGraphNodeList);
        CycleNodeAndLinkMap.put("relation", CycleGraphLinkList);


        return CycleNodeAndLinkMap;
    }

    //    @Override
//    public Map<String, List> getAllCycles(String projectName){
//        List<TreeNode> CycleGraphNodeList = new ArrayList<>();
//        List<TreeLink> CycleGraphLinkList = new ArrayList<>();
//        Map<String, List> CycleNodeAndLinkMap = new HashMap<>();
//        Map<String,String> methodInvoke = methodInvocationInViewService.getAllMethodInvokeTreeRootsByProjectName(projectName);
//        for(String str:methodInvoke.keySet()){
//            Map<String, List> nodeAndLinkMap = methodInvocationInViewService.getMethodInvokeTreeByMethodId(str,methodInvoke.get(str));
//            List<TreeNode> graphNodeList = nodeAndLinkMap.get("entity");
//            List<TreeLink> graphLinkList = nodeAndLinkMap.get("relation");
//            if(getCycleFromTree(graphNodeList,graphLinkList)){
//                CycleGraphLinkList.addAll(graphLinkList);
//                CycleGraphNodeList.addAll(graphNodeList);
//            }
//        }
//        CycleNodeAndLinkMap.put("entity", CycleGraphNodeList);
//        CycleNodeAndLinkMap.put("relation", CycleGraphLinkList);
//        return CycleNodeAndLinkMap;
//    }
//
//
//
    private List<String> getCalledNode(String callId,List<TreeLink> graphLinkList){
        List<String> calledList = new ArrayList<>();
        for(TreeLink link:graphLinkList){
            if(link.getSource().equals(callId)){
                calledList.add(link.getTarget());
            }
        }
        return calledList;
    }

    private void findCycle(String nodeId, String cyclePath,List<TreeLink> graphLinkList){
        List<String> calledList = getCalledNode(nodeId,graphLinkList);
        if(calledList.size()<1)return;
        else if(cyclePath.indexOf(nodeId)>0){
            System.out.println("找到环路：" + cyclePath.substring(cyclePath.indexOf(nodeId))+">"+nodeId);
            circleFlag = true;
            return;
        }else {
            cyclePath = cyclePath + ">" + nodeId;
            for(String node:calledList){
                findCycle(node,cyclePath,graphLinkList);
            }
        }
    }

    @Override
    public boolean getCycleFromTree(List<TreeNode> graphNodeList,List<TreeLink> graphLinkList){
        circleFlag = false;
        for(TreeNode node:graphNodeList){
            findCycle(node.getId(),"",graphLinkList);
        }
        return circleFlag;
    }

}