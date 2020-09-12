package com.se.service.impl;

import com.se.dao.MethodInfoDao;
import com.se.entity.NodeType;
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
    @Resource
    private MethodInfoDao methodInfoDao;

    @Override
    public Map<String, List> getAllCycles(String projectName){
        Set<TreeNode> CycleGraphNodeList = new HashSet<>();
        Set<TreeLink> CycleGraphLinkList = new HashSet<>();
        Map<String, List> CycleNodeAndLinkMap = new HashMap<>();

        // 入度出度都不为0
        Map<String,String> methodInvoke = methodInvocationInViewService.getAllInvokedMethodsByProjectName(projectName);

        Set<String> methodIdListInCycle = new HashSet<>();

        for(String str : methodInvoke.keySet()){
            Map<String, List> nodeAndLinkMap = methodInvocationInViewService.getMethodCallCycleByRootName(str,methodInvoke.get(str));
            List<TreeNode> graphNodeList = nodeAndLinkMap.get("entity");
            List<TreeLink> graphLinkList = nodeAndLinkMap.get("relation");
            boolean cycleFlag = (boolean)nodeAndLinkMap.get("cycleFlag").get(0);
            if(cycleFlag){
//                for(TreeNode t : graphNodeList){
//                    if(t.getId().equals("279"))
//                        System.out.println("catch you");
//                }
                CycleGraphLinkList.addAll(graphLinkList);
                CycleGraphNodeList.addAll(graphNodeList);
                methodIdListInCycle.addAll( nodeAndLinkMap.get("cycleList"));
            }
        }

        for(TreeNode node : CycleGraphNodeList){
            if(methodIdListInCycle.contains(node.getId())){
                node.setCategory(NodeType.CLASS_NODE);
            }
        }

        CycleNodeAndLinkMap.put("entity", new ArrayList(CycleGraphNodeList));
        CycleNodeAndLinkMap.put("relation", new ArrayList(CycleGraphLinkList));

        for(String id : methodIdListInCycle){
            methodInfoDao.updateMethodCycleDependency(id);
        }

        for(String id : methodIdListInCycle){
            System.out.println("find cycle: " + id);
        }


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