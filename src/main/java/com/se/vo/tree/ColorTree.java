package com.se.vo.tree;

import java.util.Arrays;
import java.util.List;

public class ColorTree {
    private String name;
    private List<ColorTree> children;
    private itemStyle itemStyle;

    public ColorTree() {
    }

    public ColorTree(String name, List<ColorTree> children, com.se.vo.tree.itemStyle itemStyle) {
        this.name = name;
        this.children = children;
        this.itemStyle = itemStyle;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<ColorTree> getChildren() {
        return children;
    }

    public void setChildren(List<ColorTree> children) {
        this.children = children;
    }

    public com.se.vo.tree.itemStyle getItemStyle() {
        return itemStyle;
    }

    public void setItemStyle(com.se.vo.tree.itemStyle itemStyle) {
        this.itemStyle = itemStyle;
    }

    @Override
    public String toString() {
        return "ColorTree{" +
                "name='" + name + '\'' +
                ", children=" + children +
                ", itemStyle=" + itemStyle +
                '}';
    }
}
