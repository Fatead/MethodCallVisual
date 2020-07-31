package com.se.service.impl;

import com.se.dao.ClassInfoDao;
import com.se.dao.MethodInvocationInfoDao;
import com.se.entity.NodeRelation;
import com.se.pojo.MethodInfo;
import com.se.pojo.MethodInvocationInfo;
import com.se.service.MethodInfoService;
import com.se.vo.GraphLink;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class MethodCallServiceImplTest {


    @Resource
    private MethodInvocationInfoDao methodInvocationInfoDao;

    @Resource
    private ClassInfoDao classInfoDao;

    @Resource
    private MethodInfoService methodInfoService;

    @Test
    public void StringUtil(){
        //com.wind.myLuence.PropertyParser
        String x = "aaa.bbb.ccc";
        String y = x.substring(0, x.lastIndexOf("."));
        System.out.println(y);
    }

//    @Test
//    public void InsertMethodCall(){
//        String filePath = "src/main/resources/methodCallFile/methodInvocation.txt";
//        String result = FileUtil.read(filePath);
//
//        JSONArray jarray = JSON.parseArray(result);
//
//        List<Methodcallinfo> methodcallinfoList = new ArrayList<>();
//
//        Iterator it = jarray.iterator();
//        while(it.hasNext()){
//            JSONObject o = (JSONObject) it.next();
//
//            JSONObject caller = (JSONObject) o.get("caller");
//            String callerName = caller.getString("methodname");
//
//            JSONArray calleeArray = o.getJSONArray("callee");
//            for(int i = 0; i < calleeArray.size(); i++){
//                JSONObject callee = (JSONObject)calleeArray.get(i);
//                String calleeName = callee.getString("methodname");
//
//                Methodcallinfo methodcallinfo = new Methodcallinfo();
//                methodcallinfo.setId(StringUtil.UUID());
//                methodcallinfo.setCallerMethodName(callerName);
//                methodcallinfo.setCalleeMethodName(calleeName);
//
//                methodcallinfoList.add(methodcallinfo);
//                methodcallinfoDao.addMethodcallinfo(methodcallinfo);
//            }
//        }
//
//        System.out.println(methodcallinfoList.size());
//
//
//    }

    @Test
    public void getMethdCall(){
        String projectName = "yqritc";

        List<MethodInvocationInfo> methodInvocationInfoList = methodInvocationInfoDao.getMethodInvocationByProjectName(projectName);

        List<GraphLink> graphLinkList = new ArrayList<>();

        Iterator it = methodInvocationInfoList.iterator();

        while(it.hasNext()){
            MethodInvocationInfo methodInvocationInfo = (MethodInvocationInfo) it.next();
            String callerMethodName = methodInvocationInfo.getCallMethodName();
            String callerClass = methodInvocationInfo.getCallClassName();
            String callerParam = methodInvocationInfo.getCallMethodParameters();

            String calleeMethodName = methodInvocationInfo.getCalledMethodName();
            String calleeClass = methodInvocationInfo.getCalledClassName();
            String calleeParam = "";

            //todo: 为方法调用添加调用者的返回值
            //根据项目名、类名、方法名、参数名找到唯一的调用者方法（考虑了重载的方法）
            MethodInfo callerMethodInfo = methodInfoService.getMethodInfoByNameParamClass(projectName, callerClass, callerMethodName, callerParam);

            //根据项目名、类名、方法名、参数名找到唯一的被调用者方法（考虑了重载的方法）
            MethodInfo calleeMethodInfo = methodInfoService.getMethodInfoByNameParamClass(projectName, calleeClass, calleeMethodName, calleeParam);

            if(callerMethodInfo != null && calleeMethodInfo != null){
                String callerMethodId = callerMethodInfo.getMethodName();
                String calleeMethodId = calleeMethodInfo.getMethodName();
                GraphLink methodCallLink = new GraphLink();
                methodCallLink.setSource(callerMethodId);
                methodCallLink.setTarget(calleeMethodId);
                methodCallLink.setValue(NodeRelation.INVOKES);
                graphLinkList.add(methodCallLink);
            }
        }
        System.out.println(graphLinkList);
    }
}
