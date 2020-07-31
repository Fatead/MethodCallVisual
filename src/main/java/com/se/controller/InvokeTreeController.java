package com.se.controller;


import com.alibaba.fastjson.JSONObject;
import com.se.service.MethodInvocationInViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/tree")
public class InvokeTreeController {

    static private String methodName = "";
    static private String methodID = "";

    @Autowired
    private MethodInvocationInViewService methodInvocationInViewService;

    @RequestMapping(value = "/getTree", method = RequestMethod.GET)
    public void getMethodInvokeTree(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        Map<String, List> nodeAndLinkMap = methodInvocationInViewService.getMethodInvokeTreeByMethodId(methodID, methodName);
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("entityList", nodeAndLinkMap.get("entity"));
        resultMap.put("relationList", nodeAndLinkMap.get("relation"));
        result.put("data", resultMap);
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/getAllTree", method = RequestMethod.POST)
    public void getAllMethodInvokeTreeByProjectName(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String projectName = request.getParameter("projectName");
        Map<String, String> allMethodInvokeTreeRoots = methodInvocationInViewService.getAllMethodInvokeTreeRootsByProjectName(projectName);
        List<String> resultList = new ArrayList<>();
        for(String str:allMethodInvokeTreeRoots.keySet()){
            resultList.add(allMethodInvokeTreeRoots.get(str) + "-" + str);
        }
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("data",resultList);
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/setMethodNameAndID",method =  RequestMethod.POST)
    public void setMethodNameAndID(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String methodAndID = request.getParameter("methodNameAndID");
        String[] str = methodAndID.split("-");
        methodName = str[0];
        methodID = str[1];
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("data","success");
        result.put("methodAndID",methodAndID);
        response.getWriter().write(String.valueOf(result));
    }

    @GetMapping("/methodTree")
    public String getMethodInvokeTreePage(HttpServletRequest request, HttpServletResponse response){
        return "tree";
    }

}
