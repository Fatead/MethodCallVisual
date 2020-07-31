package com.se.service.impl;

import com.se.dao.ClassInfoDao;
import com.se.pojo.ClassInfo;
import com.se.service.ClassInfoService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

@Service
public class ClassInfoServiceImpl implements ClassInfoService {

    @Resource
    private ClassInfoDao classInfoDao;

    /**
     * 根据不含包名的接口名获取完整接口名
     * todo:不够精确
     * @param interfaceName 不含包名的接口名
     * @return
     */
    @Override
    public String getInterfaceNameWithPkgByInterfaceName(String projectName, String interfaceName) {

        interfaceName = String.format("%%.%s%%", interfaceName);
        //根据不含包名的接口名获取完整接口名
        List<ClassInfo> tempInterfaceList = classInfoDao.
                getClassInfoByInterfaceNameWithoutPackage(projectName, interfaceName);
        String interfaceNameWithPackage = "";
        if(tempInterfaceList.size() > 0)
            interfaceNameWithPackage = tempInterfaceList.get(0).getClassName();
        return interfaceNameWithPackage;
    }

}
