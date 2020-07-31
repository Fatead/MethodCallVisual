package com.se.vo;

import lombok.Data;


public class Clone {

    int clonesetid;

    int beginrow;

    int endrow;

    public Clone(){

    }

    public Clone(int clonesetid, int beginrow, int endrow) {
        this.clonesetid = clonesetid;
        this.beginrow = beginrow;
        this.endrow = endrow;
    }

    public int getClonesetid() {
        return clonesetid;
    }

    public void setClonesetid(int clonesetid) {
        this.clonesetid = clonesetid;
    }

    public int getBeginrow() {
        return beginrow;
    }

    public void setBeginrow(int beginrow) {
        this.beginrow = beginrow;
    }

    public int getEndrow() {
        return endrow;
    }

    public void setEndrow(int endrow) {
        this.endrow = endrow;
    }
}
