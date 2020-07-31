package com.se.vo.tree;

import com.se.pojo.MethodInvocationInView;

import java.util.ArrayList;
import java.util.List;

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
}
