package com.se.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/")
public class ChoiceController {

    @GetMapping("/")
    public String getChoosePage(HttpServletRequest request, HttpServletResponse response){
        return "ChoosePage";
    }

    @GetMapping("methodcall")
    public String getMethodCallIndexPage(HttpServletRequest request, HttpServletResponse response){
        return "MethodCallIndex";
    }

    @GetMapping("codeasset")
    public String getCodeAssetPage(HttpServletRequest request, HttpServletResponse response){
        return "CodeAsset";
    }

    @GetMapping("springvisual")
    public String getSpringPage(HttpServletRequest request, HttpServletResponse response){
        return "SpringVisualize";
    }

    @GetMapping("topic")
    public String getTopicPage(HttpServletRequest request, HttpServletResponse response){
        return "topicView";
    }

    @GetMapping("methodcallchange")
    public String getMethodCallChangePage(HttpServletRequest request, HttpServletResponse response){
        return "MethodCallChangePage";
    }

}
