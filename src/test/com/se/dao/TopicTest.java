package com.se.dao;

import com.se.pojo.Topic;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml"})
public class TopicTest {

    @Resource
    private TopicDao topicDao;

    @Test
    public void getAllTopicTest(){
        List<Topic> topicList = topicDao.getAllTopic();
        System.out.println(topicList.size());
    }
}
