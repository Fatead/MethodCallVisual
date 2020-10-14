package com.se.vo.tree;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class LayerTree {

    private String name;

    private List<LayerTree> children = new ArrayList<>();

    public LayerTree() {
    }

    public LayerTree(String name, List<LayerTree> children) {
        this.name = name;
        this.children = children;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<LayerTree> getChildren() {
        return children;
    }

    public void setChildren(List<LayerTree> children) {
        this.children = children;
    }

    @Override
    public String toString() {
        return "LayerTree{" +
                "name='" + name + '\'' +
                ", children=" + children +
                '}';
    }
}
