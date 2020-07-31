package com.se.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import java.util.List;

public class JsonUtil {

    public static String listToJSONString(List list){
        return JSON.toJSONString(list);
    }

    public static List<String> stringToList(String str){
        return JSONArray.parseArray(str, String.class);
    }

}
