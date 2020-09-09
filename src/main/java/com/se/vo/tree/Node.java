package com.se.vo.tree;

import com.se.pojo.MethodInvocationInView;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Node {
    public List<Node> children = new ArrayList<Node>();
    public Node parent;
    public String nodeID;
    public String linkID;
    public MethodInvocationInView associatedObject;

    public String getNodeID() {
        return nodeID;
    }

    public void setNodeID(String nodeID) {
        this.nodeID = nodeID;
    }

    public String getLinkID() {
        return linkID;
    }

    public void setLinkID(String linkID) {
        this.linkID = linkID;
    }

    public Node(MethodInvocationInView associatedObject) {
        this.associatedObject = associatedObject;
    }

    public Set<Node> getAllLeafNodes() {
        Set<Node> leafNodes = new HashSet<>();
        if (this.children.isEmpty()) {
            leafNodes.add(this);
        } else {
            for (Node child : this.children) {
                leafNodes.addAll(child.getAllLeafNodes());
            }
        }
        return leafNodes;
    }
}