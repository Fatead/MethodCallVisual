package com.se.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;


import java.util.List;

@Repository
public interface CloneSnippetDao {

    List<String> getAllCloneSetByProjectName(@Param("projectName") String projectName);

    List<String> getAllMethodInCloneSet(@Param("cloneSetID") String cloneSetID);
}
