package com.se.controller;


import com.alibaba.fastjson.JSONObject;
import com.se.pojo.Topic;
import com.se.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/topic")
public class TopicController {

    @Autowired
    private TopicService topicService;

    @RequestMapping(value = "/getTopic",method = RequestMethod.GET)
    public void getTopicInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        List<Topic> topicList = topicService.getAllTopicFromDB();
        JSONObject result = new JSONObject();
        result.put("status", 200);
        result.put("msg", "success");
        result.put("topicList", topicList);
        response.getWriter().write(String.valueOf(result));
    }

}
