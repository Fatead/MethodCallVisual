package com.se.pojo;

public class TypeOneTwoSnippetResult {
    int cloneSetId;
    String filePath;
    int methodBeginRow;
    int methodEndRow;
    int snippetBeginRow;
    int snippetEndRow;

/*    public TypeOneTwoSnippetResult(){

    }

    public TypeOneTwoSnippetResult(int cloneSetId, String filePath, int methodBeginRow, int methodEndRow, int snippetBeginRow, int snippetEndRow) {
        this.cloneSetId = cloneSetId;
        this.filePath = filePath;
        this.methodBeginRow = methodBeginRow;
        this.methodEndRow = methodEndRow;
        this.snippetBeginRow = snippetBeginRow;
        this.snippetEndRow = snippetEndRow;
    }*/

    public int getCloneSetId() {
        return cloneSetId;
    }

    public void setCloneSetId(int cloneSetId) {
        this.cloneSetId = cloneSetId;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public int getMethodBeginRow() {
        return methodBeginRow;
    }

    public void setMethodBeginRow(int methodBeginRow) {
        this.methodBeginRow = methodBeginRow;
    }

    public int getMethodEndRow() {
        return methodEndRow;
    }

    public void setMethodEndRow(int methodEndRow) {
        this.methodEndRow = methodEndRow;
    }

    public int getSnippetBeginRow() {
        return snippetBeginRow;
    }

    public void setSnippetBeginRow(int snippetBeginRow) {
        this.snippetBeginRow = snippetBeginRow;
    }

    public int getSnippetEndRow() {
        return snippetEndRow;
    }

    public void setSnippetEndRow(int snippetEndRow) {
        this.snippetEndRow = snippetEndRow;
    }
}
