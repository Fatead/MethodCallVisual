package com.se.vo;


import java.util.Objects;

//view object
public class TreeNode {

    private String id;

    private String name;

    private int category;

    private int symbolSize;

    private int value;

    public TreeNode() {
    }

    public TreeNode(String id, String name, int category, int symbolSize, int value) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.symbolSize = symbolSize;
        this.value = value;
    }

    public TreeNode(String id, String name, int category, int symbolSize) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.symbolSize = symbolSize;
    }

    public TreeNode(String id){
        this.id = id;
    }

    public TreeNode(String id, String name, int symbolSize) {
        this.id = id;
        this.name = name;
        this.symbolSize = symbolSize;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    public int getSymbolSize() {
        return symbolSize;
    }

    public void setSymbolSize(int symbolSize) {
        this.symbolSize = symbolSize;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof TreeNode)) return false;
        TreeNode treeNode = (TreeNode) o;
        return Objects.equals(id, treeNode.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

}
