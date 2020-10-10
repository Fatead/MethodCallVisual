package com.se.controller;

import com.se.service.MethodInvocationChangeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/change")
public class InvokeChangeController {
    @Autowired
    private MethodInvocationChangeService methodInvocationChangeService;

    // 获取项目的可选日期范围
    @RequestMapping(value = "/getDataRange", method = RequestMethod.POST)
    public void getDataRange(HttpServletRequest request, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        // to do
    }
}
