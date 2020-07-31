package com.se.vo;

public class GraphLink {
    private String source;
    private String target;
    private String value;

    public GraphLink(){
    }

    public GraphLink(String source, String target, String value) {
        this.source = source;
        this.target = target;
        this.value = value;
    }

    public GraphLink(String source, String target){
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
}
