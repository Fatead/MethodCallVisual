package com.se.dao;

import com.se.pojo.Method;
import com.se.pojo.MethodInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MethodInfoDao {
    /**
     * 获取某个类的所有方法
     * @param className
     * @return
     */
    List<MethodInfo> getMethodInfoListByClassName(@Param("className") String className,@Param("projectName") String projectName);

    int updateId(@Param("ID")String id, @Param("newID")String newId);

    List<MethodInfo> selectAll();

    /**
     * 根据四个参数来确定可能的methodInfo
     * @param methodName
     * @param parameters
     * @param returnType
     * @param invokeInfo "%被调用的变量.方法名(%"
     * @return
     */
    List<MethodInfo> getPossibleMethodInfo(@Param("projectName") String projectName, @Param("methodName") String methodName, @Param("parameters") String parameters, @Param("returnType") String returnType, @Param("invokeInfo") String invokeInfo);

    List<MethodInfo> getPossibleCallerMethod(@Param("methodName") String methodName, @Param("className") String className, @Param("projectName") String projectName);

    /**
     * 查找所有克隆组
     * @return
     */
    List<String> getAllCloneGroupId();


    /**
     * 查找项目内克隆的克隆组
     * @return
     */
    List<String> getSameProjectCloneGroupId();


    /**
     * 查找跨项目克隆的克隆组
     * @return
     */
    List<String> getCrossProjectCloneGroupId();

    /**
     * 根据克隆id获取某一克隆组中所有的克隆方法
     * @param cloneGroupId
     * @return
     */
    List<MethodInfo> getCloneIdByCloneGroupId(@Param("cloneGroupId") int cloneGroupId);

    int updateMethodCycleDependency(@Param("ID")String id);

    List<MethodInfo> getMethodInCycle(@Param("projectName") String projectName);

    List<Method> getAllMethod(@Param("projectName")String projectName);

}
