package com.se.controller;

import com.alibaba.fastjson.JSONObject;
import com.se.service.LayerMethodCallService;
import com.se.vo.tree.ColorTree;
import com.se.vo.tree.LayerTree;
import com.se.vo.tree.itemStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/layertree")
public class LayerMethodCallController {

    /**
     * terrakok    theDazzler     test1   tough1985    toxicbakery
     * traex   yqrict  yui   yyued
     */

    @Autowired
    private LayerMethodCallService layerMethodCallService;

    private String projectName1="";

    @RequestMapping(value = "/getProjectList",method = RequestMethod.GET)
    public void getSpringProjectNameList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        List<String> projectNameList = layerMethodCallService.getAllProjectName();
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("data", projectNameList);
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/getTimesList",method = RequestMethod.GET)
    public void getAllMethodTimesList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        try {
            Thread.sleep(500);
        }catch (Exception e){
            e.printStackTrace();
        }
        List<Integer> timesList = layerMethodCallService.getAllInvocationTimes();


        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("data", timesList);
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/layer1",method = RequestMethod.POST)
    public void getTree(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String projectName=request.getParameter("projectName");
        this.projectName1=projectName;
        layerMethodCallService.getAllMethodInvocationInView(projectName);
        LayerTree head=layerMethodCallService.getTreeJson(projectName);
        layerMethodCallService.getLayerShow(head,1);
        JSONObject result = new JSONObject();
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("name","test");
        jsonObject.put("children",null);
        result.put("data",head);

        result.put("status", 200);
        result.put("msg", "success");
        response.getWriter().write(String.valueOf(result));
        layerMethodCallService.splitLayer(head);
    }

    @RequestMapping(value = "/layer2",method = RequestMethod.POST)
    public void getTree2(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String methodName=request.getParameter("method_name");
        String times=request.getParameter("times");
        LayerTree head=layerMethodCallService.getTreeByTimesAndMethod(Integer.parseInt(times),methodName);
        layerMethodCallService.getLayerShow(head,1);
        JSONObject result = new JSONObject();
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("name","test");
        jsonObject.put("children",null);
        result.put("data",head);
        result.put("status", 200);
        result.put("msg", "success");
        response.getWriter().write(String.valueOf(result));
        layerMethodCallService.splitLayer(head);
    }

    @RequestMapping(value = "/layer3",method = RequestMethod.POST)
    public void getTree3(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String methodName=request.getParameter("api_method");
        LayerTree head=layerMethodCallService.getApiTree(methodName);
        layerMethodCallService.getLayerShow(head,1);
        JSONObject result = new JSONObject();
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("name","test");
        jsonObject.put("children",null);
        result.put("data",head);
        result.put("status", 200);
        result.put("msg", "success");
        response.getWriter().write(String.valueOf(result));
        layerMethodCallService.splitLayer(head);
    }

    @RequestMapping(value = "/getTimesMethodList",method = RequestMethod.POST)
    public void getTimesMethodList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        try {
            Thread.sleep(500);
        }catch (Exception e){
            e.printStackTrace();
        }
        String times=request.getParameter("timesmethod");
        List<String> list=layerMethodCallService.getMethodListForFront(Integer.parseInt(times));
        System.out.println("hahahha"+list.size());
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("data",list);
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/getAPIMethod",method = RequestMethod.GET)
    public void getAPIMethod(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        try {
            Thread.sleep(500);
        }catch (Exception e){
            e.printStackTrace();
        }
        String projectName=request.getParameter("projectName");
        List<String> apiList = layerMethodCallService.getAPIMethod(projectName);
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("data", apiList);
        response.getWriter().write(String.valueOf(result));
    }
}
