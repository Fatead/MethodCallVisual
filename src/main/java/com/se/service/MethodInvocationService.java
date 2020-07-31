package com.se.service;

import java.util.Map;
import java.util.List;

public interface MethodInvocationService {
    Map<String, List> getMethodInvocationGraphLinkListByProjectName(String projectName, Map<String,String> ID2UUIDMap);
}
