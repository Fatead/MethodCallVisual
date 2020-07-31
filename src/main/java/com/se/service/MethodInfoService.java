package com.se.service;

import com.se.pojo.MethodInfo;

import java.util.List;

public interface MethodInfoService {
    /**
     * 根据项目名、方法名、类名获取methodInfo，因为可能存在重载的方法，返回结果是一个list
     * @param methodName
     * @param projectName
     * @return
     */
    List<MethodInfo> getMethodInfoListByNameAndClass(String methodName, String className, String projectName);

    /**
     * 根据项目名、方法名、类名获取methodInfo，因为可能存在重载的方法，先返回一个list，再对比参数是否相同
     * @param projectName
     * @param className
     * @param methodName
     * @param paramList
     * @return
     */
    MethodInfo getMethodInfoByNameParamClass(String projectName, String className, String methodName, String paramList);
}
