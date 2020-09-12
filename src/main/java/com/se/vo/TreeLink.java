package com.se.vo;

import java.util.Objects;

public class TreeLink {
    private String source;
    private String target;
    private String value;

    public TreeLink(){
    }

    public TreeLink(String source, String target, String value) {
        this.source = source;
        this.target = target;
        this.value = value;
    }

    public TreeLink(String source, String target){
        this.source = source;
        this.target =  target;
    }


    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof TreeLink)) return false;
        TreeLink treeLink = (TreeLink) o;
        return (Objects.equals(source, treeLink.source) && Objects.equals(target, treeLink.target));
    }

    @Override
    public int hashCode() {
        return Objects.hash(source,target);
    }

}
