package com.se.controller;

import com.alibaba.fastjson.JSONObject;
import com.se.service.GraphService;
import com.se.service.MethodInvocationCycle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/graph")
public class GraphController {

    @Autowired
    private GraphService graphService;

    @Autowired
    private MethodInvocationCycle methodInvocationCycle;

    static private String projectName = "";
    private static boolean ClassFlag = false;

    @GetMapping("/index")
    public String getProgramGraphPage(HttpServletRequest request, HttpServletResponse response){
        return "graph";
    }

    @RequestMapping(method=RequestMethod.GET,value="/indexInClass")
    public String getProgramGraphPageInClass(HttpServletRequest request, HttpServletResponse response){
        return "graphInClass";
    }

    @GetMapping("/hello")
    public String getHelloPage(HttpServletRequest request, HttpServletResponse response){
        return "MethodCallIndex";
    }

    @RequestMapping(value = "/data", method = RequestMethod.GET)
    public void getProgramGraphData(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        Map<String, List>  nodeAndLinkMap = graphService.getGraphNodeAndLinkMapWithMethodCall(projectName);
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("entityList", nodeAndLinkMap.get("entity"));
        resultMap.put("relationList", nodeAndLinkMap.get("relation"));
        result.put("data", resultMap);
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/data2", method = RequestMethod.GET)
    public void getProgramGraphData2(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        Map<String, List>  nodeAndLinkMap = graphService.getGraphNodeAndLinkMap(projectName);
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("entityList", nodeAndLinkMap.get("entity"));
        resultMap.put("relationList", nodeAndLinkMap.get("relation"));
        result.put("data", resultMap);
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/project",method =  RequestMethod.GET)
    public void getAllProjectInDB(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        List<String> projectNameList = graphService.getAllProjectName();
        Collections.sort(projectNameList);
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("data",projectNameList);
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/cloneSet",method =  RequestMethod.GET)
    public void getAllCloneSet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        List<String> cloneSetList = graphService.getAllCloneSetByProjectName(projectName);
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("data",cloneSetList);
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/set",method =  RequestMethod.POST)
    public void setProjectName(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        projectName = request.getParameter("projectName");
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("data","success");
        result.put("projectName",projectName);
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/dataInView", method = RequestMethod.GET)
    public void getProgramDataInView(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        Map<String, List>  nodeAndLinkMap = graphService.getGraphNodeAndLinkInView(projectName);
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("entityList", nodeAndLinkMap.get("entity"));
        resultMap.put("relationList", nodeAndLinkMap.get("relation"));
        result.put("data", resultMap);
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/dataInViewInClassGra", method = RequestMethod.GET)
    public void getProgramDataInViewInClassGra(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        Map<String, List>  nodeAndLinkMap = graphService.getGraphNodeAndLinkInViewInClassGra(projectName);
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("entityList", nodeAndLinkMap.get("entity"));
        resultMap.put("relationList", nodeAndLinkMap.get("relation"));
        result.put("data", resultMap);
        response.getWriter().write(String.valueOf(result));
    }

    @GetMapping("/cycle")
    public String getMethodInvokeCyclePage(HttpServletRequest request, HttpServletResponse response){
        return "graphInCycle";
    }

    @RequestMapping(value = "/getMethodInCloneSet", method = RequestMethod.POST)
    public void getMethodInCloneSet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String cloneSetId = request.getParameter("cloneSetId");
        List<String> MethodIdList = graphService.getMethodInCloneSet(cloneSetId);
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("data",MethodIdList);
        response.getWriter().write(String.valueOf(result));
    }

    @GetMapping("/getCycleTree")
    public void getCycleTreeInGraph(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        Map<String, List>  nodeAndLinkMap = methodInvocationCycle.getAllCycles(projectName);
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("entityList", nodeAndLinkMap.get("entity"));
        resultMap.put("relationList", nodeAndLinkMap.get("relation"));
        result.put("data", resultMap);
        response.getWriter().write(String.valueOf(result));
    }
}