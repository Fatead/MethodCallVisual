package com.se.dao;

import com.se.pojo.ClassInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ClassInfoDao {

    /**
     * 获取所有项目的名称
     * @return
     */
    List<String> getProjectNameList();

    /**
     * 根据项目名称获取所有非匿名类和接口
     * @param projectName
     * @return
     */
    List<ClassInfo> getAllNonAnonymousClassByProjectName(String projectName);

    /**
     * 根据不含包名的接口名称获取类/接口
     * @param projectName 项目名
     * @param interfaceName 接口名
     * @return 在大部分情况下，只会返回一个ClassInfo，除非有同名的接口
     */
    List<ClassInfo> getClassInfoByInterfaceNameWithoutPackage(@Param("projectName") String projectName, @Param("interfaceName") String interfaceName);

    int updateId(@Param("ID")String id, @Param("newID")String newId);

    List<ClassInfo> selectAll();

    /**
     * 根据完全类名获取id
     * @param className
     * @param projectName
     * @return
     */
    String getIdByClassName(@Param("className") String className, @Param("projectName") String projectName);

    List<String> getClassListByLayer(@Param("projectName") String projectName, @Param("layer") String layer);

    int getProjectLayerNumbers(@Param("projectName") String projectName);

}
