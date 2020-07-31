package com.se.service.impl;

import com.se.dao.MethodInvocationInfoDao;
import com.se.entity.NodeRelation;
import com.se.entity.NodeType;
import com.se.pojo.MethodInfo;
import com.se.pojo.MethodInvocationInfo;
import com.se.service.MethodInfoService;
import com.se.service.MethodInvocationService;
import com.se.util.StringUtil;
import com.se.vo.GraphLink;
import com.se.vo.GraphNode;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class MethodInvocationServiceImpl implements MethodInvocationService {

    @Resource
    private MethodInvocationInfoDao methodInvocationInfoDao;

    @Resource
    private MethodInfoService methodInfoService;

    @Override
    public Map<String, List> getMethodInvocationGraphLinkListByProjectName(String projectName, Map<String,String> ID2UUIDMap) {
        List<MethodInvocationInfo> methodInvocationInfoList = methodInvocationInfoDao.getMethodInvocationByProjectName(projectName);
        List<GraphLink> graphLinkList = new ArrayList<>();
        List<GraphNode> InvocationNodeList = new ArrayList<>();
        Set<String> UUIDSet = new HashSet<>();
        Iterator it = methodInvocationInfoList.iterator();
        Map<String, List> nodeAndLinkMap = new HashMap<>();

        while(it.hasNext()){
            MethodInvocationInfo methodInvocationInfo = (MethodInvocationInfo) it.next();
            String callerMethodName = StringUtil.getNameWithoutPackage(methodInvocationInfo.getCallMethodName());
            String callerClass = methodInvocationInfo.getCallClassName();

            String calleeMethodName = StringUtil.getNameWithoutPackage(methodInvocationInfo.getCalledMethodName());
            String calleeClass = methodInvocationInfo.getCalledClassName();

            //todo: 为方法调用添加调用者的返回值
            //根据项目名、类名、方法名、参数名找到唯一的调用者方法
            List<MethodInfo> callerMethodInfo = methodInfoService.getMethodInfoListByNameAndClass(callerMethodName,callerClass,projectName);

            //根据项目名、类名、方法名、参数名找到唯一的被调用者方法
            List<MethodInfo> calleeMethodInfo = methodInfoService.getMethodInfoListByNameAndClass(calleeMethodName,calleeClass,projectName);

            if(callerMethodInfo != null && calleeMethodInfo != null && calleeMethodInfo.size()>0 &&callerMethodInfo.size()>0){
                String callerMethodId = ID2UUIDMap.get(String.valueOf(callerMethodInfo.get(0).getID()));
                String calleeMethodId = ID2UUIDMap.get(String.valueOf(calleeMethodInfo.get(0).getID()));
                if(!UUIDSet.contains(callerMethodId)){
                    InvocationNodeList.add(new GraphNode(callerMethodId,callerMethodName, NodeType.METHOD_NODE));
                    UUIDSet.add(callerMethodId);
                }
                if(!UUIDSet.contains(calleeMethodId)){
                    InvocationNodeList.add(new GraphNode(calleeMethodId,calleeMethodName, NodeType.METHOD_NODE));
                    UUIDSet.add(calleeMethodId);
                }
                GraphLink methodCallLink = new GraphLink();
                methodCallLink.setSource(callerMethodId);
                methodCallLink.setTarget(calleeMethodId);
                methodCallLink.setValue(NodeRelation.INVOKES);
                graphLinkList.add(methodCallLink);
            }
        }
        nodeAndLinkMap.put("entity",InvocationNodeList);
        nodeAndLinkMap.put("relation",graphLinkList);
        return nodeAndLinkMap;
    }
}
