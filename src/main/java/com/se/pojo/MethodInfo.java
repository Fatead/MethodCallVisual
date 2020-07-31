package com.se.pojo;

import lombok.Data;

import java.util.Arrays;
import java.util.List;

@Data
public class MethodInfo {

  private String projectName;
  private String methodName;
  private String className;
  private String returnType;
  private String methodParameters;
  private String qualifiedName;
  private String methodContent;
  private int ID;
  private int isAsset;
  private String topicWords;

  public String getProjectName() {
    return projectName;
  }

  public void setProjectName(String projectName) {
    this.projectName = projectName;
  }

  public String getReturnType() {
    return returnType;
  }

  public void setReturnType(String returnType) {
    this.returnType = returnType;
  }


  public String getMethodParameters() {
    return methodParameters;
  }

  public void setMethodParameters(String methodParameters) {
    this.methodParameters = methodParameters;
  }


  public String getClassName() {
    return className;
  }

  public void setClassName(String className) {
    this.className = className;
  }

  public String getQualifiedName() {
    return qualifiedName;
  }

  public void setQualifiedName(String qualifiedName) {
    this.qualifiedName = qualifiedName;
  }

  public String getMethodName() {
    return methodName;
  }

  public void setMethodName(String methodName) {
    this.methodName = methodName;
  }

  public int getID() {
    return ID;
  }

  public void setID(int ID) {
    this.ID = ID;
  }

  public int getIsAsset(){return isAsset;}

  public void setIsAsset(int isAsset){ this.isAsset = isAsset; }

  public String getMethodContent() {
    return methodContent;
  }

  public void setMethodContent(String methodContent) {
    this.methodContent = methodContent;
  }

  public String getTopicWords() {
    return topicWords;
  }

  public void setTopicWords(String topicWords) {
    this.topicWords = topicWords;
  }

  public List<String> getTopicWordsList(){
    return Arrays.asList(topicWords.split(" "));
  }

}
