package com.se.service;

import com.se.pojo.MethodInvocationInView;
import com.se.vo.tree.LayerTree;

import java.util.List;
import java.util.Map;

public interface LayerMethodCallService {

    /**
     * 获取所有的MethodInvocationInView，用于后面的查询
     * @param projectName
     * @return
     */
    void getAllMethodInvocationInView(String projectName);

    /**
     * 获取入度为0的方法
     * @param projectName
     * @return
     */
    Map<String, String> getAllMethodInvokeTreeRootsByProjectName(String projectName);

    /**
     * 获取所有的项目名
     * @return
     */
    List<String> getAllProjectName();

    /**
     * 获得所有的根方法
     * @param projectName
     * @return
     */
    List<String> getAllRootMethod(String projectName);


    /**
     * 获取该方法所调用的所有方法
     * @param classAndMethodName
     * @return
     */
    List<String> getInvocationMethod(String classAndMethodName);

    /**
     * 获取树型的json字符串
     * @param projectName
     * @return
     */
    LayerTree getTreeJson(String projectName);

    /**
     * 将方法裂变转化为LayerTree类型的集合,LayerNode是节点也可看成是树
     * @param nameList
     * @return
     */
    List<LayerTree> getLayTreeList(List<String> nameList);

    /**
     * 获取所有方法的调用次数
     * @return
     */
    List<Integer> getAllInvocationTimes();

    /**
     * 根据次数获取相应的方法列表，将用于前端的显示
     * @param times
     * @return
     */
    List<String> getMethodListForFront(Integer times);

    /**
     * 根据次数和方法名称获取调用树
     * @param times
     * @param methodName
     * @return
     */
    LayerTree getTreeByTimesAndMethod(Integer times,String methodName);

    /**
     * 获取API树
     * @param methodName
     * @return
     */
    LayerTree getApiTree(String methodName);

    /**
     * 获取所有API
     * @param projectName
     * @return
     */
    List<String> getAPIMethod(String projectName);

    void getLayerShow(LayerTree root,int layer);

    void splitLayer(LayerTree root);

}
