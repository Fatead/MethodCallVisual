package com.se.controller;

import com.alibaba.fastjson.JSONObject;
import com.se.service.ColorService;
import com.se.service.LayerMethodCallService;
import com.se.vo.tree.ColorTree;
import com.se.vo.tree.LayerTree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/color")
public class ColorController {

    @Autowired
    private LayerMethodCallService layerMethodCallService;

    @Autowired
    private ColorService colorService;

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



    @RequestMapping(value = "/getAll",method = RequestMethod.POST)
    public void getNode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String projectName=request.getParameter("projectName");
        colorService.getAll(projectName);
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/getBeginDate",method = RequestMethod.POST)
    public void getBeginDate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Thread.sleep(500);
        }catch (Exception e){
            e.printStackTrace();
        }
        response.setCharacterEncoding("UTF-8");
        JSONObject result = new JSONObject();
        result.put("data",colorService.getDate());
        result.put("status", 200);
        result.put("msg", "success");
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/getEndDate",method = RequestMethod.POST)
    public void getEndDate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Thread.sleep(500);
        }catch (Exception e){
            e.printStackTrace();
        }
        response.setCharacterEncoding("UTF-8");
        JSONObject result = new JSONObject();
        result.put("data",colorService.getDate());
        result.put("status", 200);
        result.put("msg", "success");
        response.getWriter().write(String.valueOf(result));
    }

    @RequestMapping(value = "/tree",method = RequestMethod.POST)
    public void getTree(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String begin=request.getParameter("begindate");
        String end=request.getParameter("enddate");
        ColorTree head=colorService.getTree(begin,end);

        colorService.getLayerShow(head,1);
        colorService.getFinal(head);
        JSONObject result = new JSONObject();
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("name","test");
        jsonObject.put("children",null);
        result.put("data",head);
        result.put("status", 200);
        result.put("msg", "success");
        response.getWriter().write(String.valueOf(result));
    }

}
