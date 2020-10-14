package com.se.dao;

import com.se.pojo.MethodInvocationInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MethodInvocationInfoDao {

    int updateId(@Param("id")String id, @Param("newId")String newId);
    List<MethodInvocationInfo> selectAll();
    List<String> getAllProjectName();
    List<MethodInvocationInfo> getMethodInvocationByProjectName(@Param("projectName") String projectName);
    List<MethodInvocationInfo> getCalledMethodByCallNameAndProjectName(@Param("callMethodName") String callMethodName,@Param("projectName") String projectName);
}
