package com.se.service.impl;

import com.se.dao.MethodInfoDao;
import com.se.dao.MethodInvocationInViewDao;
import com.se.entity.NodeRelation;
import com.se.entity.NodeSize;
import com.se.entity.NodeType;
import com.se.pojo.MethodInfo;
import com.se.pojo.MethodInvocationInView;
import com.se.service.MethodInvocationCycle;
import com.se.service.MethodInvocationInViewService;
import com.se.vo.TreeLink;
import com.se.vo.TreeNode;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class MethodInvocationCycleImpl implements MethodInvocationCycle {

    private boolean circleFlag = false;

    @Resource
    private MethodInvocationInViewService methodInvocationInViewService;
    @Resource
    private MethodInfoDao methodInfoDao;
    @Resource
    private MethodInvocationInViewDao methodInvocationInViewDao;

    @Override
    public Map<String, List> getAllCycles(String projectName){
        // 已访问的不在环上的节点
        List<String> visitedNodes = new ArrayList<>();
        // 节点
        Set<String> nodes = new HashSet<>();
        // 边（调用方法->被调用方法list）
        Map<String, List<String>> edges = new HashMap<>();
        // 边（被调用方法->调用方法list）
        Map<String, List<String>> edges2 = new HashMap<>();
        // 入度
        Map<String, Integer> node2Indegree = new HashMap<>();
        // 出度
        Map<String, Integer> node2Outdegree = new HashMap<>();
        // 环上的节点
        Set<String> circleNodes = new HashSet<>();

        List<MethodInvocationInView> methodInvocationList = methodInvocationInViewDao.getMethodInvocationInViewByProjectName(projectName);
        for(MethodInvocationInView methodCall : methodInvocationList){
            // 过滤递归调用
            if(methodCall.getCallMethodID().equals(methodCall.getCalledMethodID()))
                continue;

            nodes.add(methodCall.getCallMethodID());
            nodes.add(methodCall.getCalledMethodID());

            edges.computeIfAbsent(methodCall.getCallMethodID(), k -> new ArrayList<>()).add(methodCall.getCalledMethodID());
            edges2.computeIfAbsent(methodCall.getCalledMethodID(), k -> new ArrayList<>()).add(methodCall.getCallMethodID());

            // 更新入度
            if(node2Indegree.containsKey(methodCall.getCalledMethodID())){
                node2Indegree.put(methodCall.getCalledMethodID(), node2Indegree.get(methodCall.getCalledMethodID()) + 1);
            } else {
                node2Indegree.put(methodCall.getCalledMethodID(), 1);
            }

            // 更新出度
            if(node2Outdegree.containsKey(methodCall.getCallMethodID())){
                node2Outdegree.put(methodCall.getCallMethodID(), node2Outdegree.get(methodCall.getCallMethodID()) + 1);
            } else {
                node2Outdegree.put(methodCall.getCallMethodID(), 1);
            }
        }

        /*
         * Part1: 从前往后删除入度为0的节点
         */

        Stack<String> stack = new Stack<>();

        // 入度为0的节点
        Set<String> zeroInDegreeNode = nodes.stream()
                .filter(e -> !node2Indegree.containsKey(e))
                .collect (Collectors.toSet());


        for(String node : zeroInDegreeNode)
            stack.push(node);

        while(!stack.isEmpty()){
            String currentNode = stack.peek();
            visitedNodes.add(currentNode);
            stack.pop();

            if(edges.get(currentNode) == null)
                continue;
            for(String neighborNode : edges.get(currentNode)){
                int indegree = node2Indegree.getOrDefault(neighborNode, 0) - 1;
                node2Indegree.put(neighborNode, indegree);
                if(indegree == 0 && !visitedNodes.contains(neighborNode)){
                    stack.push(neighborNode);
                }
            }
        }

        if(visitedNodes.size() < nodes.size()){
            // found loop
            nodes.removeAll(visitedNodes);
//            nodes.removeAll(zeroOutDegreeNode);
            circleNodes = nodes;
//            for(String id : circleNodes)
//                methodInfoDao.updateMethodCycleDependency(id);
        } else {
            Map<String, List> CycleNodeAndLinkMap = new HashMap<>();
            CycleNodeAndLinkMap.put("entity", new ArrayList());
            CycleNodeAndLinkMap.put("relation", new ArrayList());
        }

        /*
         * Part2: 从后往前删除出度为0的节点
         */
        // 环上方法调用的方法
        List<String> fakeCircleNodes = new ArrayList<>();

        Stack<String> stack2 = new Stack<>();

        // 出度为0的节点
        Set<String> zeroOutDegreeNode = nodes.stream()
                .filter(e -> !edges.containsKey(e))
                .collect (Collectors.toSet());

        for(String node : zeroOutDegreeNode)
            stack2.push(node);

        while(!stack2.isEmpty()){
            String currentNode = stack2.peek();
            fakeCircleNodes.add(currentNode);
            stack2.pop();

            if(edges2.get(currentNode) == null)
                continue;
            for(String neighborNode : edges2.get(currentNode)){
                int outdegree = node2Outdegree.getOrDefault(neighborNode, 0) - 1;
                node2Outdegree.put(neighborNode, outdegree);
                if(outdegree == 0 && !fakeCircleNodes.contains(neighborNode)){
                    stack2.push(neighborNode);
                }
            }
        }

        circleNodes.removeAll(fakeCircleNodes);

        for(String id : circleNodes)
            methodInfoDao.updateMethodCycleDependency(id);

        Set<TreeNode> graphNodeSet = new HashSet<>();
        Set<TreeLink> graphLinkSet = new HashSet<>();

        for(MethodInvocationInView methodCall : methodInvocationList){
            if(circleNodes.contains(methodCall.getCalledMethodID())){
                graphNodeSet.add(new TreeNode(methodCall.getCalledMethodID(), methodCall.getCalledMethodName(), NodeType.CLASS_NODE, NodeSize.METHOD_SIZE));
                graphLinkSet.add(new TreeLink(methodCall.getCallMethodID(), methodCall.getCalledMethodID(), NodeRelation.INVOKES));

            } else if(fakeCircleNodes.contains(methodCall.getCalledMethodID())){
                graphNodeSet.add(new TreeNode(methodCall.getCalledMethodID(), methodCall.getCalledMethodName(), NodeType.METHOD_NODE, NodeSize.METHOD_SIZE));
                graphLinkSet.add(new TreeLink(methodCall.getCallMethodID(), methodCall.getCalledMethodID(), NodeRelation.INVOKES));
            }
        }

        Map<String, List> CycleNodeAndLinkMap = new HashMap<>();
        CycleNodeAndLinkMap.put("entity", new ArrayList(graphNodeSet));
        CycleNodeAndLinkMap.put("relation", new ArrayList(graphLinkSet));

        return CycleNodeAndLinkMap;
    }

//    @Override
//    public Map<String, List> getAllCycles(String projectName){
//        List<MethodInfo> methodInCycle = methodInfoDao.getMethodInCycle(projectName);
//        List<Integer> methodIdInCycle = methodInCycle.stream().map(MethodInfo::getID).collect(Collectors.toList());
//
//        List<MethodInvocationInView> methodInvocationList = methodInvocationInViewDao.getMethodInvocationInViewByProjectName(projectName);
//
//        Set<TreeNode> graphNodeSet = new HashSet<>();
//        Set<TreeLink> graphLinkSet = new HashSet<>();
//
//        for(MethodInvocationInView methodCall : methodInvocationList){
//            if(methodIdInCycle.contains(Integer.valueOf(methodCall.getCallMethodID()))){
//                graphNodeSet.add(new TreeNode(methodCall.getCalledMethodID(), methodCall.getCalledMethodName(), NodeType.METHOD_NODE, NodeSize.METHOD_SIZE));
//                graphLinkSet.add(new TreeLink(methodCall.getCallMethodID(), methodCall.getCalledMethodID(), NodeRelation.INVOKES));
//
//            }
//        }
//
//        Map<String, List> CycleNodeAndLinkMap = new HashMap<>();
//        CycleNodeAndLinkMap.put("entity", new ArrayList(graphNodeSet));
//        CycleNodeAndLinkMap.put("relation", new ArrayList(graphLinkSet));
//
//        return CycleNodeAndLinkMap;
//    }

//    @Override
//    public Map<String, List> getAllCycles(String projectName){
//        Set<TreeNode> CycleGraphNodeList = new HashSet<>();
//        Set<TreeLink> CycleGraphLinkList = new HashSet<>();
//        Map<String, List> CycleNodeAndLinkMap = new HashMap<>();
//
//        // 入度出度都不为0
//        Map<String,String> methodInvoke = methodInvocationInViewService.getAllInvokedMethodsByProjectName(projectName);
//
//        Set<String> methodIdListInCycle = new HashSet<>();
//
//        for(String str : methodInvoke.keySet()){
//            Map<String, List> nodeAndLinkMap = methodInvocationInViewService.getMethodCallCycleByRootName(str,methodInvoke.get(str));
//            List<TreeNode> graphNodeList = nodeAndLinkMap.get("entity");
//            List<TreeLink> graphLinkList = nodeAndLinkMap.get("relation");
//            boolean cycleFlag = (boolean)nodeAndLinkMap.get("cycleFlag").get(0);
//            if(cycleFlag){
//                CycleGraphLinkList.addAll(graphLinkList);
//                CycleGraphNodeList.addAll(graphNodeList);
//                methodIdListInCycle.addAll( nodeAndLinkMap.get("cycleList"));
//            }
//        }
//
//        for(TreeNode node : CycleGraphNodeList){
//            if(methodIdListInCycle.contains(node.getId())){
//                node.setCategory(NodeType.CLASS_NODE);
//            }
//        }
//
//        CycleNodeAndLinkMap.put("entity", new ArrayList(CycleGraphNodeList));
//        CycleNodeAndLinkMap.put("relation", new ArrayList(CycleGraphLinkList));
//
////        for(String id : methodIdListInCycle){
////            methodInfoDao.updateMethodCycleDependency(id);
////        }
////
////        for(String id : methodIdListInCycle){
////            System.out.println("find cycle: " + id);
////        }
//
//
//        return CycleNodeAndLinkMap;
//    }

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