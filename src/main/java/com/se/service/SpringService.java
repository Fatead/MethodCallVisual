package com.se.service;
import com.se.vo.SpringNode;
import java.util.List;
import java.util.Map;

public interface SpringService {

    public List<String> getClassInfoInLayer(String projectName,String layer);

    public Map<String, SpringNode> getLayerClass(String projectName);

    public List<String> getProjectNameList();

}
