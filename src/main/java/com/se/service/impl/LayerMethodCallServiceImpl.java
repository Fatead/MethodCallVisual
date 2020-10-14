package com.se.service.impl;

import com.se.dao.LayerTreeDao;
import com.se.entity.NodeType;
import com.se.pojo.MethodInvocationInView;
import com.se.service.LayerMethodCallService;
import com.se.vo.GraphNode;
import com.se.vo.tree.LayerTree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class LayerMethodCallServiceImpl implements LayerMethodCallService {

    @Autowired
    private LayerTreeDao layerTreeDao;

    @Autowired
    private LayerMethodCallService layerMethodCallService;

    private String projectName="";

    public List<MethodInvocationInView> currAllMethodInvocationInViewList;

    public LayerTree curr_root=null;

    public Map<Integer,List<String>> times_methodName;

    //调用方法和次数map
    public Map<LayerTree,Integer> times_and_method_list=new HashMap<>();

    @Override
    public void getAllMethodInvocationInView(String projectName) {
        this.currAllMethodInvocationInViewList=layerTreeDao.getAllMethodInvocationInView(projectName);
    }

    @Override
    public Map<String, String> getAllMethodInvokeTreeRootsByProjectName(String projectName) {
        this.projectName=projectName;

        //计算入度为0的节点
        Set<GraphNode> graphNodeSet = new HashSet<>();
        List<MethodInvocationInView> methodInvocationInViewList =  layerTreeDao.getMethodByProjectName(projectName);
        Set<GraphNode> calledMethodSet = new HashSet<>();
        Set<GraphNode> callMethodSet = new HashSet<>();
        for(MethodInvocationInView methodInvocationInView:methodInvocationInViewList){
            graphNodeSet.add(new GraphNode(methodInvocationInView.getCallMethodID(),methodInvocationInView.getCallMethodName(), NodeType.METHOD_NODE));
            graphNodeSet.add(new GraphNode(methodInvocationInView.getCalledMethodID(),methodInvocationInView.getCalledMethodName(),NodeType.METHOD_NODE));
            //计算入度
            calledMethodSet.add(new GraphNode(methodInvocationInView.getCalledMethodID(),methodInvocationInView.getCalledMethodName(), NodeType.METHOD_NODE));
            callMethodSet.add(new GraphNode(methodInvocationInView.getCallMethodID(),methodInvocationInView.getCallMethodName(), NodeType.METHOD_NODE));
        }
        graphNodeSet.removeAll(calledMethodSet);    //入度为0的节点
        Map<String, String> rootMethodIdAndName = new HashMap<>();
        for(GraphNode rootNode : graphNodeSet){
            //排除孤立结点
            if(callMethodSet.contains(rootNode))
                rootMethodIdAndName.put(rootNode.getId(), rootNode.getName());
        }
        return rootMethodIdAndName;
    }

    @Override
    public List<String> getAllProjectName() {
        return layerTreeDao.getAllProjectName();
    }

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

    @Override
    public List<String> getInvocationMethod(String classAndMethodNameAndId) {
        List<String> methodNameList=new ArrayList<>();
        String[] name=classAndMethodNameAndId.split("\\.");
        if (name.length!=0){
            String methodName=name[name.length-2];
            String methodId=name[name.length-1];
            List<MethodInvocationInView> calledMethodByCallNameAndProjectName = this.getCalledMethodByCallName(projectName,methodName,methodId);
            for (MethodInvocationInView methodInvocationInView:calledMethodByCallNameAndProjectName){
                methodNameList.add(methodInvocationInView.getCalledClassName()+"."+methodInvocationInView.getCalledMethodName()+"."+methodInvocationInView.getCalledMethodID());
            }
        }
        return methodNameList;
    }

    @Override
    public LayerTree getTreeJson(String projectName) {
        LayerTree root=new LayerTree();
        List<String>children=this.getAllRootMethod(projectName);
        //初始化树的第一层为项目名称以及他的孩子
        root.setName(projectName);
        root.setChildren(this.getLayTreeList(children));
        for (int i=0;i<root.getChildren().size();i++){
            LayerTree head=root.getChildren().get(i);
            try {
                DFS(head);
            }catch (StackOverflowError error){
                return null;
            }

        }
        this.curr_root=root;
        return root;
    }

    @Override
    public List<LayerTree> getLayTreeList(List<String> nameList) {
        List<LayerTree> list=new ArrayList<>();
        for (String name:nameList){
            LayerTree layerTree=new LayerTree();
            layerTree.setName(name);
            layerTree.setChildren(null);
            list.add(layerTree);
        }
        return list;
    }

    public void DFS(LayerTree root){
        if (root!=null){
            System.out.println("hahahahahhaha"+root.getName());
            List<String> childNameList=this.getInvocationMethod(root.getName());
            List<LayerTree> childrenList;
            childrenList=this.getLayTreeList(childNameList);
            root.setChildren(childrenList);
            for (int i=0;i<root.getChildren().size();i++){
                DFS(root.getChildren().get(i));
            }
        }
    }

    public String getClassNameByMethodNameAndProjectName(String projectName,String methodName){

        for (int i=0;i<currAllMethodInvocationInViewList.size();i++){
            if (currAllMethodInvocationInViewList.get(i).getProjectName().equals(projectName)&&
            currAllMethodInvocationInViewList.get(i).getCallMethodName().equals(methodName)){
                return currAllMethodInvocationInViewList.get(i).getCallClassName();
            }
        }
        return null;
    }

    public List<MethodInvocationInView> getCalledMethodByCallName(String projectName,String methodName,String methodId){
        List<MethodInvocationInView> list=new ArrayList<>();
        for (int i=0;i<currAllMethodInvocationInViewList.size();i++){
            if (currAllMethodInvocationInViewList.get(i).getProjectName().equals(projectName)&&
                    currAllMethodInvocationInViewList.get(i).getCallMethodName().equals(methodName)&&
                        currAllMethodInvocationInViewList.get(i).getCallMethodID().equals(methodId)){
                list.add(currAllMethodInvocationInViewList.get(i));
            }
        }
        return list;
    }

    //获取所有方法的调用次数
    @Override
    public List<Integer> getAllInvocationTimes(){
        while(this.curr_root==null){
            try {
                Thread.sleep(500);
            }catch (Exception e){
                e.printStackTrace();
            }

        }
        //System.out.println("这是当前的curr_root : "+curr_root.toString());
        times_methodName=this.levelTraverse(curr_root);
        List<Integer> times_list=new ArrayList<>();
        for (Map.Entry<Integer,List<String>>entry:times_methodName.entrySet()){
            times_list.add(entry.getKey());
        }
        return times_list;
    }

    @Override
    public List<String> getMethodListForFront(Integer times) {
        for (Map.Entry<Integer,List<String>>entry:times_methodName.entrySet()){
            if (entry.getKey()==times){
                return entry.getValue();
            }
        }
        return null;
    }

    @Override
    public LayerTree getTreeByTimesAndMethod(Integer times, String methodName) {

        for (Map.Entry<LayerTree,Integer>entry:times_and_method_list.entrySet()){
            if (entry.getKey().getName().equals(methodName)&&(entry.getValue()==times)){
                return entry.getKey();
            }
        }
        return null;
    }

    @Override
    public LayerTree getApiTree(String methodName) {
        for (LayerTree layerTree:curr_root.getChildren()){
            if (layerTree.getName().equals(methodName)){
                return layerTree;
            }
        }
        return null;
    }

    @Override
    public List<String> getAPIMethod(String projectName) {
        List<String> list=this.getAllRootMethod(projectName);
        return list;
    }

    //层次遍历树，调用次数对应的方法
    public Map<Integer,List<String>> levelTraverse(LayerTree root){

        //result存放次数和对应的方法
        Map<Integer,List<String>> result=new HashMap<>();
        LayerTree temp=root;
        Stack<LayerTree> stack=new Stack<>();
        for (int i=0;i<temp.getChildren().size();i++){
            stack.push(temp.getChildren().get(i));
        }
        while(!stack.empty()){
            temp=stack.pop();
            Integer number=temp.getChildren().size();
            Integer compare_number=-1;
            //储存方法名和次数

            this.times_and_method_list.put(temp,number);

            if (result!=null){
                for (Map.Entry<Integer,List<String>>entry:result.entrySet()){
                    if (entry.getKey()==number){
                        compare_number= number;
                        break;
                    }
                }
                if (compare_number>-1){
                    result.get(number).add(temp.getName());
                }else {
                    List<String> value=new ArrayList<>();
                    value.add(temp.getName());
                    result.put(number,value);
                }
            }else {
                List<String> value=new ArrayList<>();
                value.add(temp.getName());
                result.put(number,value);
            }
            for (int j=0;j<temp.getChildren().size();j++){
                stack.push(temp.getChildren().get(j));
            }
        }
        return result;
    }

    public void getLayerShow(LayerTree root1,int layer){
        if (root1!=null){
            for (LayerTree layerTree: root1.getChildren()){
                layerTree.setName(layerTree.getName()+"("+layer+")");
                getLayerShow(layerTree,layer+1);
            }
            layer=layer-1;
        }
    }

    @Override
    public void splitLayer(LayerTree root) {
        if (root!=null){
            for (LayerTree layerTree: root.getChildren()){
                String[] a=layerTree.getName().split("\\(");
                layerTree.setName(a[a.length-2]);
                splitLayer(layerTree);
            }
        }
    }
}
