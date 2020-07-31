package com.se.pojo;

public class CloneSnippet {

    private String cloneSnippetId;
    private String cloneSetId;
    private String methodId;
    private String projectName;
    private int beginToken;
    private int endToken;
    private int tokenNums;

    public String getCloneSnippetId() {
        return cloneSnippetId;
    }

    public void setCloneSnippetId(String cloneSnippetId) {
        this.cloneSnippetId = cloneSnippetId;
    }

    public String getCloneSetId() {
        return cloneSetId;
    }

    public void setCloneSetId(String cloneSetId) {
        this.cloneSetId = cloneSetId;
    }

    public String getMethodId() {
        return methodId;
    }

    public void setMethodId(String methodId) {
        this.methodId = methodId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public int getBeginToken() {
        return beginToken;
    }

    public void setBeginToken(int beginToken) {
        this.beginToken = beginToken;
    }

    public int getEndToken() {
        return endToken;
    }

    public void setEndToken(int endToken) {
        this.endToken = endToken;
    }

    public int getTokenNums() {
        return tokenNums;
    }

    public void setTokenNums(int tokenNums) {
        this.tokenNums = tokenNums;
    }
}
