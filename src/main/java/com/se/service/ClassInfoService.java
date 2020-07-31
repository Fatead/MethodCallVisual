package com.se.service;

public interface ClassInfoService {

    /**
     * 根据接口名获取包含包名的接口名
     * @param projectName 项目名
     * @param interfaceName 接口名
     * @return
     */
    String getInterfaceNameWithPkgByInterfaceName(String projectName, String interfaceName);
}
