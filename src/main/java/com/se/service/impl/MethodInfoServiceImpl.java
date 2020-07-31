package com.se.service.impl;

import com.se.dao.MethodInfoDao;
import com.se.pojo.MethodInfo;
import com.se.service.MethodInfoService;
import com.se.util.JsonUtil;
import com.se.util.StringUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class MethodInfoServiceImpl implements MethodInfoService {

    @Resource
    private MethodInfoDao methodInfoDao;

    @Override
    public List<MethodInfo> getMethodInfoListByNameAndClass(String methodName, String className, String projectName) {
        List<MethodInfo> methodInfoList = methodInfoDao.getPossibleCallerMethod(methodName,className,projectName);
        if(methodInfoList.size() < 1){
            return new ArrayList<>();
        }
        return methodInfoList;
    }

    @Override
    public MethodInfo getMethodInfoByNameParamClass(String projectName, String className, String methodName, String paramList) {
//        if(className.equals("com.wind.myLuence.source.DDALDatabaseSource")&&methodName.equals("configure"))
//            System.out.println("catch you!");

        List<MethodInfo> methodInfoList = this.getMethodInfoListByNameAndClass(methodName, className, projectName);
        for(MethodInfo methodInfo : methodInfoList){
            List<String> targetParams = JsonUtil.stringToList(paramList);

            String tempParamsStr = StringUtil.trimFirstLastChar(methodInfo.getMethodParameters());
            String[] tempParamsArray = tempParamsStr.split(",");
            List<String> tempTypeNameList = Arrays.asList(tempParamsArray);
            List<String> candidateParams = new ArrayList<>();

            for(int i = 0; i < tempTypeNameList.size(); i++){
                String[] typeAndName = tempTypeNameList.get(i).trim().split("\\s+");
                if(!tempTypeNameList.get(i).isEmpty())
                    candidateParams.add(typeAndName[0]);
            }

            boolean isParamEqual = StringUtil.isListEqual(targetParams, candidateParams);
            if(isParamEqual)
                return methodInfo;
        }

        return null;
    }



}
