package com.se.pojo;


import lombok.Data;

@Data
public class ClassInfo {
  private int ID;
  private String projectName;
  private String className;
  private Boolean isInterface;
  private String fileName;

  public String getProjectName() {
    return projectName;
  }

  public void setProjectName(String projectName) {
    this.projectName = projectName;
  }

  public String getClassName() {
    return className;
  }

  public void setClassName(String className) {
    this.className = className;
  }


  public String getFileName() {
    return fileName;
  }

  public void setFileName(String fileName) {
    this.fileName = fileName;
  }

  public Boolean getInterface() {
    return isInterface;
  }

  public void setInterface(Boolean anInterface) {
    isInterface = anInterface;
  }

  public int getID() {
    return ID;
  }

  public void setID(int ID) {
    this.ID = ID;
  }


}

