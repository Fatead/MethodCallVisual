package com.se.vo;

import java.util.ArrayList;
import java.util.List;

public class SpringNode {

    private String className;
    private String layer;
    private List<SpringNode> children;


    public SpringNode(String className){
        this.className = className;
        children = new ArrayList<>();
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getLayer() {
        return layer;
    }

    public void setLayer(String layer) {
        this.layer = layer;
    }

    public List<SpringNode> getChildren() {
        return children;
    }

    public void setChildren(List<SpringNode> children) {
        this.children = children;
    }

    public void addChildNode(SpringNode springNode){
        children.add(springNode);
    }
}
