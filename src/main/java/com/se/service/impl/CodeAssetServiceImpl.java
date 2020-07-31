package com.se.service.impl;
import com.se.dao.MethodInfoDao;
import com.se.pojo.MethodInfo;
import com.se.service.CodeAssetService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class CodeAssetServiceImpl implements CodeAssetService {

    @Resource
    private MethodInfoDao methodInfoDao;

    public List<String> getAllCloneGroupId(){
        List<String> cloneGroupIdList = methodInfoDao.getAllCloneGroupId();
        return cloneGroupIdList;
    }

    public List<String> getSameProjectCloneGroupId(){
        List<String> SameProjectCloneGroupIdList = methodInfoDao.getSameProjectCloneGroupId();
        return SameProjectCloneGroupIdList;
    }

    public List<String> getCrossProjectCloneGroupId(){
        List<String> CrossProjectCloneGroupIdList = methodInfoDao.getCrossProjectCloneGroupId();
        return CrossProjectCloneGroupIdList;
    }

    public List<MethodInfo> getCloneIdByCloneGroupId(int cloneGroupId){
        List<MethodInfo> methodInfoList = methodInfoDao.getCloneIdByCloneGroupId(cloneGroupId);
        return methodInfoList;
    }

}
