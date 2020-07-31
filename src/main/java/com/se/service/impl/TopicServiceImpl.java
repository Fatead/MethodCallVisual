package com.se.service.impl;

import com.se.dao.TopicDao;
import com.se.pojo.Topic;
import com.se.service.TopicService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service
public class TopicServiceImpl implements TopicService {

    @Resource
    private TopicDao topicDao;


    public List<Topic> getAllTopicFromDB(){
        return topicDao.getAllTopic();
    }



}
