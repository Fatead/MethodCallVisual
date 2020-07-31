package com.se.dao;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.se.util.FileUtil;
import com.se.util.StringUtil;
import org.junit.Assert;
import org.junit.Test;
import org.junit.Assert.*;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class UniTest {

    @Resource
    private ClassInfoDao classInfoDao;

    @Resource
    private MethodInfoDao methodInfoDao;

    @Resource
    private MethodInvocationInfoDao methodInvocationInfoDao;





    @Test
    public void updateID() {
//        List<ClassInfo> classInfoList = classInfoDao.selectAll();
//        for(int i = 0; i < classInfoList.size(); i++){
//            String id = StringUtil.UUID();
//            int result = classInfoDao.updateId(classInfoList.get(i).getId(),id);
//        }

//        List<ClassRelationInfo> classRelationInfoList = classRelationInfoDao.selectAll();
//        for(int i = 0; i < classRelationInfoList.size(); i++){
//            String id = StringUtil.UUID();
//            int result = classRelationInfoDao.updateId(classRelationInfoList.get(i).getId(),id);
//        }

//        List<Cluster> clusterList = clusterDao.selectAll();
//        for(int i = 0; i < clusterList.size(); i++){
//            String id = StringUtil.UUID();
//            int result = clusterDao.updateId(clusterList.get(i).getId(),id);
//        }

//        List<FieldInfo> fieldInfoList = fieldInfoDao.selectAll();
//        for(int i = 0; i < fieldInfoList.size(); i++){
//            String id = StringUtil.UUID();
//            int result = fieldInfoDao.updateId(fieldInfoList.get(i).getId(),id);
//        }

//        List<MethodInfo> methodInfoList = methodInfoDao.selectAll();
//        for(int i = 0; i < methodInfoList.size(); i++){
//            String id = StringUtil.UUID();
//            int result = methodInfoDao.updateId(methodInfoList.get(i).getId(),id);
//        }

//        List<MethodInvocationInfo> methodInvocationInfoList = methodInvocationInfoDao.selectAll();
//        for(int i = 0; i < methodInvocationInfoList.size(); i++){
//            String id = StringUtil.UUID();
//            int result = methodInvocationInfoDao.updateId(methodInvocationInfoList.get(i).getId(),id);
//        }

//        List<TokenInMethod> tokenInMethodList = tokenInMethodDao.selectAll();
//        for(int i = 0; i < tokenInMethodList.size(); i++){
//            String id = StringUtil.UUID();
//            int result = tokenInMethodDao.updateId(tokenInMethodList.get(i).getId(),id);
//        }





    }

//    @Test
//    public void FileUtilTest(){
//        String filePath = "/Users/coldilock/Documents/Code/JavaWeb/ProgramModel/src/main/resources/output/methodInvocation.txt";
//        String projectName = "MyLuence-master";
//
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
//            String callerName = caller.getString("name");
//            JSONArray callerParamTypes = caller.getJSONArray("params");
//
//            String callerClazzName = caller.getString("clazz");
//
//            JSONArray calleeArray = o.getJSONArray("called");
//            for(int i = 0; i < calleeArray.size(); i++){
//                JSONObject callee = (JSONObject)calleeArray.get(i);
//                String calleeName = callee.getString("name");
//                JSONArray calleeParamTypes = callee.getJSONArray("params");
//                String calleeClazzName = callee.getString("clazz");
//
//                Methodcallinfo methodcallinfo = new Methodcallinfo();
//                methodcallinfo.setId(StringUtil.UUID());
//                methodcallinfo.setProjectName(projectName);
//                methodcallinfo.setCallerMethodName(callerName);
//                methodcallinfo.setCallerClassName(callerClazzName);
//                methodcallinfo.setCallerParam(callerParamTypes.toString());
//                methodcallinfo.setCalleeMethodName(calleeName);
//                methodcallinfo.setCalleeClassName(calleeClazzName);
//                methodcallinfo.setCalleeParam(calleeParamTypes.toString());
//
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
    public void testListToString(){
//        List<String> x = new ArrayList<>();
//        x.add("aaa");
//        x.add("bbb");
//        x.add("ccc");
//        System.out.println(x.toString());

//        String tempParamsStr = StringUtil.trimFirstLastChar("[]");
//        String[] tempParamsArray = tempParamsStr.split(",");
//        List<String> tempTypeNameList = Arrays.asList(tempParamsArray);
//        List<String> candidateParams = new ArrayList<>();
//
//        for(int i = 0; i < tempTypeNameList.size(); i++){
//            String[] typeAndName = tempTypeNameList.get(i).trim().split("\\s+");
//            candidateParams.add(typeAndName[0]);
//        }

        List<String> list1 = new ArrayList<>();
        list1.add("String");
        list1.add("int");

        List<String> list2 = new ArrayList<>();
        list2.add("int");
        list2.add("String");
        list2.add("JSON");

        System.out.println(StringUtil.isListEqual(list1,list2));

        String str = "org.apdplat.qa.util.MySQLUtils.saveQuestionToDatabase";
        Assert.assertEquals(StringUtil.getNameWithoutPackage(str),"saveQuestionToDatabase");
    }

    @Test
    public void javaReflection() {
//        String packageName = "java.util";
//
//        String className = "Resource";
//
//        className = packageName.concat(".").concat(className);
//
//        Class clazz;
//
//        try{
//            clazz = Class.forName(className);
//            System.out.println(clazz.getName());
//        } catch (ClassNotFoundException e){
//
//            System.out.println("error");
//        }

    }



}
