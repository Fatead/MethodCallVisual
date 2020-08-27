package com.se.controller;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.se.service.SpringService;
import com.se.vo.SpringNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/spring")
public class SpringController {

    @Autowired
    private SpringService springService;

    @RequestMapping(value = "/getData",method = RequestMethod.POST)
    public void getSpringData(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String projectName = request.getParameter("projectName");
        Map<String, SpringNode> springNodeMap = springService.getLayerClass(projectName);
        JSONObject jsonObject = new JSONObject();
        JSONArray controlArray = new JSONArray();
        for(SpringNode springNode:springNodeMap.values()){
            JSONObject controlObject = new JSONObject();
            controlObject.put("name",springNode.getClassName());
            JSONArray serviceArray = new JSONArray();
            for(SpringNode springNode1:springNode.getChildren()){
                JSONArray daoArray = new JSONArray();
                JSONObject serviceObject = new JSONObject();
                serviceObject.put("name",springNode1.getClassName());
                for(SpringNode springNode2:springNode1.getChildren()){
                    JSONObject daoObject = new JSONObject();
                    daoObject.put("name",springNode2.getClassName());
                    daoArray.add(daoObject);
                }
                serviceObject.put("children",daoArray);
                serviceArray.add(serviceObject);
            }
            controlObject.put("children",serviceArray);
            controlArray.add(controlObject);
        }
        jsonObject.put("children",controlArray);
        JSONObject result = new JSONObject();
        result.put("data",jsonObject);
        result.put("status", 200);
        result.put("msg", "success");
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/getProjectList",method = RequestMethod.GET)
    public void getSpringProjectNameList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        List<String> projectNameList = springService.getProjectNameList();
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("data", projectNameList);
        response.getWriter().write(String.valueOf(result));
    }

}
