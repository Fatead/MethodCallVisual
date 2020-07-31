package com.se.dao;

import com.se.pojo.TypeOneTwoSnippetResult;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TypeOneTwoSnippetResultDao {
    List<TypeOneTwoSnippetResult> getTypeOneTwoSnippetResultByName(@Param("methodName") String methodName);
}
