package com.se.controller;

import com.alibaba.fastjson.JSONObject;
import com.se.pojo.MethodInfo;
import com.se.service.CodeAssetService;
import com.se.util.ListUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/codeasset")
public class CodeAssetController {

    static private String cloneGroupForShowId = "";

    @Autowired
    private CodeAssetService codeAssetService;

    @RequestMapping(value = "/set", method = RequestMethod.GET)
    public void getAllCloneGroupIdList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        List<String> cloneGroupIdList = codeAssetService.getAllCloneGroupId();
        cloneGroupIdList = ListUtil.rankList(cloneGroupIdList);
        //获取第一个克隆组用于展示
        List<MethodInfo> methodInfoList = null;
        if(!cloneGroupIdList.isEmpty())
            methodInfoList = codeAssetService.getCloneIdByCloneGroupId(Integer.parseInt(cloneGroupIdList.get(0)));
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("cloneGroupIdList", cloneGroupIdList);
        resultMap.put("methodInfoExampleList", methodInfoList);
        result.put("data", resultMap);
        response.getWriter().write(String.valueOf(result));
    }


    @RequestMapping(value = "/getCloneGroup", method = RequestMethod.POST)
    public void getDiffCloneGroupIdList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String cloneCategory = request.getParameter("cloneGroupCate");
        response.setCharacterEncoding("UTF-8");
        //List<String> cloneGroupIdList = codeAssetService.getAllCloneGroupId();
        List<String> cloneGroupIdList = new ArrayList<>();
        if(cloneCategory.equals("sameProject")){
            cloneGroupIdList = codeAssetService.getSameProjectCloneGroupId();
        }else if(cloneCategory.equals("crossProject")){
            cloneGroupIdList = codeAssetService.getCrossProjectCloneGroupId();
        }else {
            cloneGroupIdList = codeAssetService.getAllCloneGroupId();
        }
        cloneGroupIdList = ListUtil.rankList(cloneGroupIdList);
        //获取第一个克隆组用于展示
        List<MethodInfo> methodInfoList = null;
        if(!cloneGroupIdList.isEmpty())
            methodInfoList = codeAssetService.getCloneIdByCloneGroupId(Integer.parseInt(cloneGroupIdList.get(0)));
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("cloneGroupIdList", cloneGroupIdList);
        resultMap.put("methodInfoExampleList", methodInfoList);
        result.put("data", resultMap);
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/data",method =  RequestMethod.POST)
    public void getCloneGroupById(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String cloneSetId = request.getParameter("cloneSetId");
        List<MethodInfo> methodInfoList = codeAssetService.getCloneIdByCloneGroupId(Integer.parseInt(cloneSetId));
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("data", methodInfoList);
        response.getWriter().write(String.valueOf(result));
    }
}
