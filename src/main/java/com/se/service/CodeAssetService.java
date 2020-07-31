package com.se.service;

import com.se.pojo.MethodInfo;

import java.util.List;

public interface CodeAssetService {
    /**
     * 查找所有克隆组
     * @return
     */
    List<String> getAllCloneGroupId();

    /**
     * 根据克隆id获取某一克隆组中所有的克隆方法
     * @return
     */
    List<MethodInfo> getCloneIdByCloneGroupId(int cloneGroupId);

    List<String> getCrossProjectCloneGroupId();

    List<String> getSameProjectCloneGroupId();

}
