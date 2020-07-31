package com.se.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class ListUtil {

    public static List<String> rankList(List<String> list){
        List<Integer> integerList = new ArrayList<>();
        for(String str:list){
            integerList.add(Integer.valueOf(str));
        }
        int[] array = new int[integerList.size() + 1];
        int i = 0;
        for(Integer integer:integerList){
            array[i++] = integer;
        }
        Arrays.sort(array);
        List<String> list1 = new ArrayList<>();
        for(Integer integer:array){
            list1.add(String.valueOf(integer));
        }
        return list1;
    }
}
