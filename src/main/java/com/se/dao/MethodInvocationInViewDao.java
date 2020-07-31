package com.se.dao;

import com.se.pojo.MethodInvocationInView;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MethodInvocationInViewDao {
    List<MethodInvocationInView> getMethodInvocationInViewByProjectName(@Param("projectName") String projectName);

    List<MethodInvocationInView> getMethodCallTreeByRootName(@Param("callerMethodId") String callerMethodId);
}
