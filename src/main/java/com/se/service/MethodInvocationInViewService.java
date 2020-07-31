package com.se.service;

import java.util.List;
import java.util.Map;

public interface MethodInvocationInViewService {

    Map<String, String> getAllMethodInvokeTreeRootsByProjectName(String projectName);

    Map<String, List> getMethodInvokeTreeByMethodId(String methodId, String methodName);

}
