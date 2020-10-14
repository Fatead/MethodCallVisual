package com.se.dao;

import com.se.pojo.MethodInvocationInView;
import com.se.pojo.MethodInvocationInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LayerTreeDao {

    /**
     * 获取所有的MethodInvocationInView
     * @param projectName
     * @return
     */
    List<MethodInvocationInView> getAllMethodInvocationInView(@Param("projectName")String projectName);


    List<MethodInvocationInView> getMethodByProjectName(@Param("projectName")String projectName);

    /**
     * 获取所有的项目名
     * @return
     */
    List<String> getAllProjectName();

    /**
     * 根据方法名和项目名获取类名
     * @param callMethodName
     * @return
     */
    String getClassNameByMethodName(@Param("projectName") String projectName,@Param("callMethodName") String callMethodName);

    /**
     * 根据项目名和方法名获取被调用方法的名称
     * @param projectName
     * @param callMethodName
     * @return
     */
    List<MethodInvocationInView> getCalledMethodByCallName(@Param("projectName") String projectName, @Param("callMethodName") String callMethodName);


    /**
     * 获取所有的MethodInvocationInView,并按照create_time降序排序
     * @param projectName
     * @return
     */
    List<MethodInvocationInView> getAllMethodInvocationInViewByCreateTime(@Param("projectName")String projectName);
}
