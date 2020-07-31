package com.se.pojo;

public class MethodInvocationInView {

    private String ProjectName;
    private String CallClassName;
    private String CalledClassName;
    private String CalledMethodName;
    private String CallMethodName;
    private String CallMethodParameters;
    private String CallMethodReturnType;
    private String callMethodID;
    private String calledMethodID;
    private String callClassID;
    private String calledClassID;
    private String ID;

    public String getProjectName() {
        return ProjectName;
    }

    public void setProjectName(String projectName) {
        ProjectName = projectName;
    }

    public String getCallClassName() {
        return CallClassName;
    }

    public void setCallClassName(String callClassName) {
        CallClassName = callClassName;
    }

    public String getCalledClassName() {
        return CalledClassName;
    }

    public void setCalledClassName(String calledClassName) {
        CalledClassName = calledClassName;
    }

    public String getCalledMethodName() {
        return CalledMethodName;
    }

    public void setCalledMethodName(String calledMethodName) {
        CalledMethodName = calledMethodName;
    }

    public String getCallMethodName() {
        return CallMethodName;
    }

    public void setCallMethodName(String callMethodName) {
        CallMethodName = callMethodName;
    }

    public String getCallMethodParameters() {
        return CallMethodParameters;
    }

    public void setCallMethodParameters(String callMethodParameters) {
        CallMethodParameters = callMethodParameters;
    }

    public String getCallMethodReturnType() {
        return CallMethodReturnType;
    }

    public void setCallMethodReturnType(String callMethodReturnType) {
        CallMethodReturnType = callMethodReturnType;
    }

    public String getCallMethodID() {
        return callMethodID;
    }

    public void setCallMethodID(String callMethodID) {
        this.callMethodID = callMethodID;
    }

    public String getCalledMethodID() {
        return calledMethodID;
    }

    public void setCalledMethodID(String calledMethodID) {
        this.calledMethodID = calledMethodID;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getCallClassID() {
        return callClassID;
    }

    public void setCallClassID(String callClassID) {
        this.callClassID = callClassID;
    }

    public String getCalledClassID() {
        return calledClassID;
    }

    public void setCalledClassID(String calledClassID) {
        this.calledClassID = calledClassID;
    }
}
