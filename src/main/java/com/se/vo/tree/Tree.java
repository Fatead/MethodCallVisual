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


    public Map<String, List> breadth(Node root) {
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
                    graphNodeList.add(new TreeNode(StringUtil.UUID(), childNode.associatedObject.getCalledMethodName(), NodeType.METHOD_NODE));
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

}
