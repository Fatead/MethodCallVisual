package com.se.service.impl;


import com.se.dao.MethodInvocationInViewDao;
import com.se.service.MethodInvocationCycle;
import com.se.service.MethodInvocationInViewService;
import com.se.vo.TreeLink;
import com.se.vo.TreeNode;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class MethodInvocationCycleTest {

    @Resource
    private MethodInvocationCycle methodInvocarionCycle;
    @Autowired
    private MethodInvocationInViewService methodInvocationInViewService;
    @Autowired
    private MethodInvocationInViewDao methodInvocationInViewDao;

    private boolean circleFlag = false;

    @Test
    public void getAllCycles(){
        methodInvocarionCycle.getAllCycles("ysc");
    }

//    @Test
//    public void getCycleFromTree(){
//        List<TreeNode> NodeList = new ArrayList<>();
//        List<TreeLink> LinkList = new ArrayList<>();
//        NodeList.add(new TreeNode("A"));
//        NodeList.add(new TreeNode("B"));
//        NodeList.add(new TreeNode("C"));
//        NodeList.add(new TreeNode("D"));
//        NodeList.add(new TreeNode("E"));
//        NodeList.add(new TreeNode("F"));
//        LinkList.add(new TreeLink("A","B"));
//        LinkList.add(new TreeLink("B","A"));
//        LinkList.add(new TreeLink("B","D"));
//        LinkList.add(new TreeLink("A","C"));
//        LinkList.add(new TreeLink("F","B"));
//        LinkList.add(new TreeLink("E","A"));
//        System.out.println(methodInvocarionCycle.getCycleFromTree(NodeList,LinkList));
//    }

//    @Test
//    public boolean getAllCyclesX(String projectName){
//        boolean isCycleInvoke = false;
//        Map<String,String> methodInvoke = methodInvocationInViewService.getAllInvokedMethodsByProjectName(projectName);
//        for(String methodID : methodInvoke.keySet()) {
//            Map<String, List> nodeAndLinkMap = methodInvocationInViewService.getMethodInvokeTreeByMethodId(methodID,methodInvoke.get(methodID));
//            // 获取方法调用树中叶子结点上的被调用方法
//            Set<String> leafNodeIDSet = methodInvocationInViewService.getLeafNodesOfCallTree(methodID, methodInvoke.get(methodID));
//            //todo:根据叶子结点上的被调用方法的ID,查询此方法调用的其他方法
//            for(String callerMethodID : leafNodeIDSet){
//                List<MethodInvocationInView> methodCalls = methodInvocationInViewDao.getMethodCallByCallerMethodId(callerMethodID);
//                for(MethodInvocationInView methodInvocationInView : methodCalls){
//                    if(methodID.equals(methodInvocationInView.getCalledMethodID())){
//                        isCycleInvoke = true;
//                        break;
//                    }
//                }
//            }
//
//        }
//        return isCycleInvoke;
//    }

    @Test
    public void test(){
        Map<String, List> result = getAllCycles("Cycle");
        for(Map.Entry<String, List> entry: result.entrySet()){
            System.out.println("cycle lll:"+entry.getKey() + "->" + entry.getValue());
        }
    }

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

//    private List<String> getCalledNode(String callId,List<TreeLink> graphLinkList){
//        List<String> calledList = new ArrayList<>();
//        for(TreeLink link:graphLinkList){
//            if(link.getSource().equals(callId)){
//                calledList.add(link.getTarget());
//            }
//        }
//        return calledList;
//    }
//
//    private void findCycle(String nodeId, String cyclePath,List<TreeLink> graphLinkList){
//        List<String> calledList = getCalledNode(nodeId,graphLinkList);
//        if(calledList.size()<1)return;
//        else if(cyclePath.indexOf(nodeId)>0){
//            System.out.println("找到环路：" + cyclePath.substring(cyclePath.indexOf(nodeId))+">"+nodeId);
//            circleFlag = true;
//            return;
//        }else {
//            cyclePath = cyclePath + ">" + nodeId;
//            for(String node:calledList){
//                findCycle(node,cyclePath,graphLinkList);
//            }
//        }
//    }
//
//    public boolean getCycleFromTree(List<TreeNode> graphNodeList,List<TreeLink> graphLinkList){
//        circleFlag = false;
//        for(TreeNode node:graphNodeList){
//            findCycle(node.getId(),"",graphLinkList);
//        }
//        return circleFlag;
//    }

}