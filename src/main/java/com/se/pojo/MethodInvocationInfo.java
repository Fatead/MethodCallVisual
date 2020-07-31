package com.se.pojo;

import lombok.Data;

@Data
public class MethodInvocationInfo {

  private int ID;
  private String projectName;
  private String callMethodName;
  private String calledMethodName;
  private String callClassName;
  private String calledClassName;
  private String callMethodParameters;
  private String callMethodReturnType;

  public String getProjectName() {
    return projectName;
  }

  public void setProjectName(String projectName) {
    this.projectName = projectName;
  }

  public String getCallMethodName() {
    return callMethodName;
  }

  public void setCallMethodName(String callMethodName) {
    this.callMethodName = callMethodName;
  }

  public String getCalledMethodName() {
    return calledMethodName;
  }

  public void setCalledMethodName(String calledMethodName) {
    this.calledMethodName = calledMethodName;
  }

  public String getCallMethodParameters() {
    return callMethodParameters;
  }

  public void setCallMethodParameters(String callMethodParameters) {
    this.callMethodParameters = callMethodParameters;
  }

  public String getCallMethodReturnType() {
    return callMethodReturnType;
  }

  public void setCallMethodReturnType(String callMethodReturnType) {
    this.callMethodReturnType = callMethodReturnType;
  }

  public String getCallClassName() {
    return callClassName;
  }

  public void setCallClassName(String callClassName) {
    this.callClassName = callClassName;
  }

  public String getCalledClassName() {
    return calledClassName;
  }

  public void setCalledClassName(String calledClassName) {
    this.calledClassName = calledClassName;
  }

  public int getID() {
    return ID;
  }

  public void setID(int ID) {
    this.ID = ID;
  }
}

