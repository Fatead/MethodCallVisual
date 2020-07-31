package com.se.dao;

import com.se.pojo.Topic;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TopicDao {

    List<Topic> getAllTopic();
}
