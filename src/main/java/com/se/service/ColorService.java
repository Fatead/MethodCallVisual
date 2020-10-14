package com.se.service;

import com.se.pojo.MethodInvocationInView;
import com.se.vo.tree.ColorTree;
import com.se.vo.tree.LayerTree;

import java.util.Date;
import java.util.List;

public interface ColorService {
    /**
     * 获取所有的MethodInvocatationView
     * @param projectName
     * @return
     */
    void getAll(String projectName);

    /**
     * 获取可选取的时间段，以天为单位
     * @return
     */
    List<String> getDate();

    /**
     * 获得标记的树
     * @param beginDate
     * @param endDate
     * @return
     */
    ColorTree getTree(String beginDate,String endDate);

    List<String> getAllRootMethod(String projectName);

    List<String> getInvocationMethod(String classAndMethodNameAndId);

    List<ColorTree> getColorTreeList(List<String> nameList);

    void getLayerShow(ColorTree root,int layer);

    void getFinal(ColorTree root);
}
