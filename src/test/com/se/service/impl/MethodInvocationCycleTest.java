package com.se.service.impl;


import com.se.dao.MethodInfoDao;
import com.se.dao.MethodInvocationInViewDao;
import com.se.entity.NodeRelation;
import com.se.entity.NodeType;
import com.se.pojo.MethodInvocationInView;
import com.se.service.MethodInvocationCycle;
import com.se.service.MethodInvocationInViewService;
import com.se.util.StringUtil;
import com.se.vo.TreeLink;
import com.se.vo.TreeNode;
import com.se.vo.tree.Node;
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
    @Autowired
    private MethodInfoDao methodInfoDao;

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
//        Map<String, List> result = methodInvocarionCycle.getAllCycles("Tencent");
//        for(Map.Entry<String, List> entry: result.entrySet()){
//            System.out.println("cycle method:"+entry.getKey() + "->" + entry.getValue());
//        }


//        String id = "3058";
//        String name = "initBufferedWriter";


        //addNewBufferedWriter


        String id = "276";
        String name = "isSameAnnotationDirectory";

        Map<String, List> result = methodInvocationInViewService.getMethodCallCycleByRootName(id, name);
        for(Map.Entry<String, List> entry: result.entrySet()){
            System.out.println("cycle method:"+entry.getKey() + "->" + entry.getValue());
        }
    }

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
                CycleGraphLinkList.addAll(graphLinkList);
                CycleGraphNodeList.addAll(graphNodeList);
                methodIdListInCycle.addAll(nodeAndLinkMap.get("cycleList"));
            }
        }

//        for(TreeNode node : CycleGraphNodeList){
//            if(methodIdListInCycle.contains(node.getId())){
//                node.setCategory(NodeType.CLASS_NODE);
//            }
//        }
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

    @Test
    public void newTest(){
        String rootId = "1";
        List<String> callChain = new ArrayList<>();
        String branchNodeMethodId = rootId;

        List<MethodInvocationInView> result = getMethodCallTreeByRootNameX(rootId, callChain, branchNodeMethodId);

        for(int i  = 0; i < result.size(); i++){
            System.out.println(result.get(i).getCallMethodID() + " -> " + result.get(i).getCalledMethodID());
        }
    }

    public List<MethodInvocationInView> getMethodCallTreeByRootNameX(String rootMethodId, List<String> callChain, String branchNodeMethodId){
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
                list.addAll(getMethodCallTreeByRootNameX(methodCall.getCalledMethodID(), callChain, branchNodeMethodId));
            }
        }

        return list;
    }

    public Map<String, List> depthFirst(Node root) {
        if (root == null)
            return null;

        /*
         * methodIDIncallChain存储从根节点到当前节点的路径，即方法调用链条，用于判断是否存在环状调用
         * 并且methodIDIncallChain存储的是节点上的calledMethod的ID
         * 因此methodID2Node保存了calledMethodID到节点ID对的映射
         */
        List<String> callChain = new ArrayList<>();
        Map<String, String> methodId2NodeId = new HashMap<>();

        // 是否存在环状调用
        boolean cycleFlag = false;
        // 记录方法调用链条中最新的一个分支节点
        Node lastBranchNode = root;

        List<TreeNode> graphNodeList = new ArrayList<>();   // 用于展示的Node List
        List<TreeLink> graphLinkList = new ArrayList<>();   // 用于展示的relation List

        // 对方法调用树进行深度优先遍历
        Stack<Node> stack = new Stack<>();
        stack.add(root);

        String parentNodeId = null;
        String currentNodeId;

        Set<String> cycleMethodSet = new HashSet<>();

        while(!stack.isEmpty()) {

            Node currentNode = stack.pop();
            currentNodeId = StringUtil.UUID();

            /*
             * 判断是否出现循环调用：
             * 根据当前节点所代表的calledmethodID中是否已经出现在方法调用链条methodsIncallChain中
             *
             * 若是，则代表存在环状调用。将存在循环递归的方法的连接加入到graphLinkList中
             * 然后回溯到最近一个分支节点（有多个孩子），即删除methodIdIncallChain中最近一个分支节点的所有后代节点
             */
            if (!callChain.isEmpty() && callChain.contains(currentNode.associatedObject.getCalledMethodID())) {

                // 出现环状调用
                String caller = methodId2NodeId.get(currentNode.associatedObject.getCallMethodID());
                String called = methodId2NodeId.get(currentNode.associatedObject.getCalledMethodID());

                // 让方法调用链成环
                graphLinkList.add(new TreeLink(caller, called, NodeRelation.INVOKES));

                // 保存要call chain删除的方法id，用于删除methodId2NodeId
                List<String> deleteMethodIdInCallChain = callChain.subList(callChain.indexOf(lastBranchNode.associatedObject.getCalledMethodID()) + 1, callChain.size());
                // 保存 成环的方法调用链 上的每一个方法id
                List<String> methodIdInCycle = callChain.subList(callChain.indexOf(currentNode.associatedObject.getCalledMethodID()), callChain.size());

                // 回溯
                callChain = callChain.subList(0, callChain.indexOf(lastBranchNode.associatedObject.getCalledMethodID()) + 1);
                // 回溯后，对应的parentNodeId也要修改
                parentNodeId = methodId2NodeId.get(lastBranchNode.associatedObject.getCalledMethodID());
                // 回溯后，还要把已经从call chain中移除的method从methodId2NodeId中删除
                for(String deletedMethodId : deleteMethodIdInCallChain){
                    methodId2NodeId.remove(deletedMethodId);
                }

                cycleFlag = true;
                cycleMethodSet.addAll(methodIdInCycle);

            } else {

                // 保存了calledMethodID到节点ID对的映射
                methodId2NodeId.put(currentNode.associatedObject.getCalledMethodID(), currentNodeId);

                // 加入到graphNodeList中，在前端显示此方法节点
                graphNodeList.add(new TreeNode(currentNodeId, currentNode.associatedObject.getCalledMethodName(), NodeType.METHOD_NODE));
                if (currentNode != root)
                    graphLinkList.add(new TreeLink(parentNodeId, currentNodeId, NodeRelation.INVOKES)); // 加入到graphLinkList中，在前端显示此方法和调用者方法之间的调用关系

                // 树的节点代表一个方法调用，因此将calledMethod作为实际方法调用树上的节点，然后将其加入到方法调用链条中
                callChain.add(currentNode.associatedObject.getCalledMethodID());

                // 对树进行深度遍历时，当一个节点有多个孩子节点时，对其中一个孩子节点所在的完整方法调用链条判断是否包含循环调用后，需要进行回溯，所以要记录有多个孩子的节点
                if (currentNode.children.size() > 1) {
                    lastBranchNode = currentNode;
                    parentNodeId = currentNodeId;
                } else if(currentNode.children.size() == 0) {
                    // 到达叶子节点，回溯
                    callChain = callChain.subList(0, callChain.indexOf(lastBranchNode.associatedObject.getCalledMethodID()) + 1);
                    // 回溯后，对应的parentNodeId也要修改
                    parentNodeId = methodId2NodeId.get(lastBranchNode.associatedObject.getCalledMethodID());
                    // 回溯后，还要把已经从call chain中移除的method从methodId2NodeId中删除
                    List<String> deleteMethodIdInCallChain = callChain.subList(callChain.indexOf(lastBranchNode.associatedObject.getCalledMethodID()) + 1, callChain.size());
                    for(String deletedMethodId : deleteMethodIdInCallChain){
                        methodId2NodeId.remove(deletedMethodId);
                    }
                } else {
                    parentNodeId = currentNodeId;
                }

                for (Node childNode : currentNode.children) {
                    stack.push(childNode);
                }


            }
        }


//        System.out.println(graphNodeList.size());
//        for(TreeNode node : graphNodeList){
//            System.out.println(node.getId()+" : "+node.getName());
//        }
//
//        System.out.println(graphLinkList.size());
//        for(TreeLink link : graphLinkList){
//            System.out.println(link.getSource()+" -> "+link.getTarget());
//        }


        Map<String, List> nodeAndLinkMap = new HashMap<>();

        List<Boolean> cycleFlags = new ArrayList<>();
        cycleFlags.add(cycleFlag);
        nodeAndLinkMap.put("cycleFlag", cycleFlags);
        List<String> cycleMethodList =new ArrayList<>(cycleMethodSet);
        nodeAndLinkMap.put("cycleList", cycleMethodList);
        nodeAndLinkMap.put("entity",graphNodeList);
        nodeAndLinkMap.put("relation",graphLinkList);
        return nodeAndLinkMap;
    }
}