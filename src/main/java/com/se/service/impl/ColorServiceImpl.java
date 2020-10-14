package com.se.service.impl;

import com.se.dao.LayerTreeDao;
import com.se.dao.MethodInfoDao;
import com.se.pojo.Method;
import com.se.pojo.MethodInvocationInView;
import com.se.service.ColorService;
import com.se.service.LayerMethodCallService;
import com.se.util.DateUtil;
import com.se.vo.tree.ColorTree;
import com.se.vo.tree.LayerTree;
import com.se.vo.tree.itemStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ColorServiceImpl implements ColorService {

    private List<MethodInvocationInView> list;

    private List<Method> methods;

    @Autowired
    private LayerTreeDao layerTreeDao;

    @Autowired
    private LayerMethodCallService layerMethodCallService;

    @Autowired
    private MethodInfoDao methodInfoDao;

    private String project_name="";

    private Date begin_date;

    private Date end_date;

    @Override
    public void getAll(String projectName) {
        this.project_name=projectName;
        this.methods=methodInfoDao.getAllMethod(projectName);
        for (Method method:methods){
            System.out.println(method.toString());
        }
        this.list=layerTreeDao.getAllMethodInvocationInViewByCreateTime(projectName);

    }

    @Override
    public List<String> getDate() {
        List<Date> dateList=DateUtil.getBetweenDates(methods.get(methods.size()-1).getCreateTime(),methods.get(0).getCreateTime());
        List<String> stringList=new ArrayList<>();
        for (Date date:dateList){
            String ss=new SimpleDateFormat("yyyy-MM-dd").format(date);
            stringList.add(ss);
        }

        return stringList;
    }

    @Override
    public ColorTree getTree(String beginDate, String endDate) {
        Date begin=DateUtil.strToDate(beginDate);
        this.begin_date=begin;
        Date end=DateUtil.strToDate(endDate);
        this.end_date=end;
        ColorTree root=new ColorTree();
        List<String>children=this.getAllRootMethod(project_name);
        //初始化树的第一层为项目名称以及他的孩子
        root.setName(project_name);
        itemStyle style1=new itemStyle();
        style1.setBorderColor("rgba(15, 16, 15, 1)");
        root.setItemStyle(style1);
        root.setChildren(this.getColorTreeList(children));
        for (int i=0;i<root.getChildren().size();i++){
            ColorTree head=root.getChildren().get(i);
            DFS(head);
        }
        return root;
    }

    //获取根方法
    @Override
    public List<String> getAllRootMethod(String projectName) {
        List<String> methodNameList=new ArrayList<>();
        Map<String,String> methodIdAndName=layerMethodCallService.getAllMethodInvokeTreeRootsByProjectName(projectName);
        for (Map.Entry<String,String> entry:methodIdAndName.entrySet()){
            String callClassName=this.getClassNameByMethodNameAndProjectName(projectName,entry.getValue());
            methodNameList.add(callClassName+"."+entry.getValue()+"."+entry.getKey());
        }
        return methodNameList;
    }


    //得到调用的方法
    @Override
    public List<String> getInvocationMethod(String classAndMethodNameAndId) {
        List<String> methodNameList=new ArrayList<>();
        String[] name=classAndMethodNameAndId.split("\\.");
        if (name.length!=0){
            String methodName=name[name.length-2];
            String methodId=name[name.length-1];
            List<MethodInvocationInView> calledMethodByCallNameAndProjectName = this.getCalledMethodByCallName(project_name,methodName,methodId);
            for (MethodInvocationInView methodInvocationInView:calledMethodByCallNameAndProjectName){
                methodNameList.add(methodInvocationInView.getCalledClassName()+"."+methodInvocationInView.getCalledMethodName()+"."+methodInvocationInView.getCalledMethodID());
            }
        }
        return methodNameList;
    }

    //根据项目名和方法名获得类名
    public String getClassNameByMethodNameAndProjectName(String projectName,String methodName){
        for (int i=0;i<list.size();i++){
            if (list.get(i).getProjectName().equals(projectName)&&
                    list.get(i).getCallMethodName().equals(methodName)){
                return list.get(i).getCallClassName();
            }
        }
        return null;
    }

    public void DFS(ColorTree root){
        if (root!=null){
            List<String> childNameList=this.getInvocationMethod(root.getName());
            List<ColorTree> childrenList;
            childrenList=this.getColorTreeList(childNameList);
            root.setChildren(childrenList);
            for (int i=0;i<root.getChildren().size();i++){
                DFS(root.getChildren().get(i));
            }
        }
    }

    //获取被调用的方法
    public List<MethodInvocationInView> getCalledMethodByCallName(String projectName,String methodName,String methodId){
        List<MethodInvocationInView> list1=new ArrayList<>();
        for (int i=0;i<list.size();i++){
            if (list.get(i).getProjectName().equals(projectName)&&
                    list.get(i).getCallMethodName().equals(methodName)&&
                    list.get(i).getCallMethodID().equals(methodId)){
                list1.add(list.get(i));
            }
        }
        return list1;
    }

    //将方法变为节点
    @Override
    public List<ColorTree> getColorTreeList(List<String> nameList) {
        List<ColorTree> list=new ArrayList<>();
        for (String name:nameList){
            ColorTree colorTree=new ColorTree();
            colorTree.setName(name);
            colorTree.setChildren(null);
            itemStyle style=new itemStyle();
            style.setBorderColor(getColor(name));
            colorTree.setItemStyle(style);
            list.add(colorTree);
        }
        return list;
    }

    private String getColor(String name){
        String[] nameArray=name.split("\\.");
        String id=nameArray[nameArray.length-1];
        //String methodName=nameArray[nameArray.length-2];
        for (Method method:this.methods){
            if (method.getID()==Integer.parseInt(id)) {
                if (method.getIsDelete()>0){
                    //红色
                    return "rgba(245, 40, 8, 1)";
                }else if(DateUtil.belongCalendar(method.getUpdateTime(),begin_date,end_date)){
                    //紫色
                    return "rgba(222, 11, 241, 1)";
                }else if (DateUtil.belongCalendar(method.getCreateTime(),begin_date,end_date)){
                    //蓝色
                    return "rgba(15, 11, 241, 1)";
                }else {
                    //黑色
                    return "rgba(15, 16, 15, 1)";
                }

            }
        }
        return "rgba(15, 16, 15, 1)";
    }

    public void getLayerShow(ColorTree root,int layer){
        if (root!=null){
            for (ColorTree colorTree: root.getChildren()){
                colorTree.setName(colorTree.getName()+"("+layer+")");
                getLayerShow(colorTree,layer+1);
            }
            layer=layer-1;
        }
    }
    public void getFinal(ColorTree root){
        if (root!=null){
            for (ColorTree colorTree: root.getChildren()){
                if (colorTree.getItemStyle().getBorderColor().equals("rgba(245, 40, 8, 1)")){
                    colorTree.setChildren(null);
                }else {
                    getFinal(colorTree);
                }

            }
        }
    }

}
