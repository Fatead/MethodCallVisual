package com.se.service.impl;

import com.se.dao.ClassInfoDao;
import com.se.dao.MethodInvocationInfoDao;
import com.se.pojo.MethodInvocationInfo;
import com.se.service.SpringService;
import com.se.vo.SpringNode;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.*;

@Service
public class SpringServiceImpl implements SpringService {

    @Resource
    private ClassInfoDao classInfoDao;

    @Resource
    private MethodInvocationInfoDao methodInvocationInfoDao;

    String[] layers = {
            "control",
            "service",
            "dao"
    };
    private List<String> controllerLayer;
    private List<String> serviceLayer;
    private List<String> daoLayer;

    @Override
    public List<String> getClassInfoInLayer(String projectName,String layer){
       return classInfoDao.getClassListByLayer(projectName,layer);
    }


    public Map<String,SpringNode> buildMap(List<String> strList){
        Map<String,SpringNode> map = new HashMap<>();
        for(String str:strList){
            SpringNode springNode = new SpringNode(str);
            map.put(str,springNode);
        }
        return map;
    }

    /**
     * @param projectName
     * 返回一个Controller层的list作为结果
     */
    public Map<String,SpringNode> getLayerClass(String projectName){
        controllerLayer = classInfoDao.getClassListByLayer(projectName,layers[0]);
        serviceLayer = classInfoDao.getClassListByLayer(projectName,layers[1]);
        daoLayer = classInfoDao.getClassListByLayer(projectName,layers[2]);
        Map<String,SpringNode> controllerMap = buildMap(controllerLayer);
        Map<String,SpringNode> serviceMap = buildMap(serviceLayer);
        Map<String,SpringNode> daoMap = buildMap(daoLayer);
        List<MethodInvocationInfo> methodInvocationInfoList = methodInvocationInfoDao.getMethodInvocationByProjectName(projectName);
        Set<String> controllerSet = new HashSet<>(controllerLayer);
        Set<String> serviceSet = new HashSet<>(serviceLayer);
        Set<String> daoSet = new HashSet<>(daoLayer);
        for(MethodInvocationInfo methodInvocationInfo:methodInvocationInfoList){
            if(serviceSet.contains(methodInvocationInfo.getCallClassName())&&daoSet.contains(methodInvocationInfo.getCalledClassName())){
                serviceMap.get(methodInvocationInfo.getCallClassName()).addChildNode(daoMap.get(methodInvocationInfo.getCalledClassName()));
            }
        }

        for(MethodInvocationInfo methodInvocationInfo:methodInvocationInfoList){
            if(controllerSet.contains(methodInvocationInfo.getCallClassName())&&serviceSet.contains(methodInvocationInfo.getCalledClassName())){
                controllerMap.get(methodInvocationInfo.getCallClassName()).addChildNode(serviceMap.get(methodInvocationInfo.getCalledClassName()));
            }
        }
        return controllerMap;
    }

    public List<String> getProjectNameList(){
        List<String> projectNameList = classInfoDao.getProjectNameList();
        List<String> filterList = new ArrayList<>();
        for(String projectName:projectNameList){
            int layerNum = classInfoDao.getProjectLayerNumbers(projectName);
            if(layerNum>1){
                filterList.add(projectName);
            }
        }
        return filterList;
    }

}
