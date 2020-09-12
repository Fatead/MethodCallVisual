package com.se.vo.tree;

import com.se.entity.NodeRelation;
import com.se.entity.NodeType;
import com.se.pojo.MethodInvocationInView;
import com.se.util.StringUtil;
import com.se.vo.TreeLink;
import com.se.vo.TreeNode;

import java.util.*;


public class Tree {

    //每个节点是一个方法调用
    public Node buildTreeAndGetRoots(List<MethodInvocationInView> actualObjects, String rootMethodId, String rootMethodName) {
        MethodInvocationInView rootMethod = new MethodInvocationInView();
        rootMethod.setID("-1");
        rootMethod.setCallMethodID("-2");
        rootMethod.setCalledMethodID(rootMethodId);
        rootMethod.setCalledMethodName(rootMethodName);
        Node rootNode = new Node(rootMethod);
        rootNode.setNodeID(StringUtil.UUID());
        Map<String, Node> lookup = new HashMap<>();
//        lookup.put(rootMethodId, rootNode); //加入根节点
        lookup.put(rootMethod.getID(), rootNode); //加入根节点
        actualObjects.forEach(x -> lookup.put(x.getID(), new Node(x)));

        lookup.values().forEach(item ->{
            lookup.values().forEach(temp ->{
                temp.setNodeID(StringUtil.UUID());
                if(item.associatedObject.getCallMethodID().equals(temp.associatedObject.getCalledMethodID())){
                    item.parent = temp;
                    temp.children.add(item);
                }
            });
        });
        return rootNode;
    }


    public Map<String, List> breadthFirst(Node root) {
        List<TreeNode> graphNodeList = new ArrayList<>();
        List<TreeLink> graphLinkList = new ArrayList<>();

        Queue<Node> queue = new LinkedList<Node>();

        if (root == null)
            return null;

        queue.add(root);
        graphNodeList.add(new TreeNode(root.getNodeID(), root.associatedObject.getCalledMethodName(), NodeType.METHOD_NODE));

        String parentNodeId;
        while(!queue.isEmpty()){
            parentNodeId = queue.peek().getNodeID();
            Node parentNode = queue.remove();
            for(Node childNode : parentNode.children){
                TreeNode temp = new TreeNode(childNode.getNodeID(), childNode.associatedObject.getCalledMethodName(), NodeType.METHOD_NODE);
                String childNodeId = childNode.getNodeID();
                if(graphNodeList.contains(temp)){
                    childNodeId = StringUtil.UUID();
                    //graphNodeList.add(new TreeNode(StringUtil.UUID(), childNode.associatedObject.getCalledMethodName(), NodeType.METHOD_NODE));
                    graphNodeList.add(new TreeNode(childNodeId, childNode.associatedObject.getCalledMethodName(), NodeType.METHOD_NODE));
                } else {
                    graphNodeList.add(temp);
                }
                graphLinkList.add(new TreeLink(parentNodeId, childNodeId, NodeRelation.INVOKES));
            }
            if(parentNode.children.size() > 0)
                queue.addAll(parentNode.children);
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
        nodeAndLinkMap.put("entity",graphNodeList);
        nodeAndLinkMap.put("relation",graphLinkList);
        return nodeAndLinkMap;
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