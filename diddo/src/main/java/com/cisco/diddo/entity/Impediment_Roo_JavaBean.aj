// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.cisco.diddo.entity;

import com.cisco.diddo.entity.Impediment;
import com.cisco.diddo.entity.Sprint;
import com.cisco.diddo.entity.User;
import java.util.Calendar;

privileged aspect Impediment_Roo_JavaBean {
    
    public String Impediment.getDescription() {
        return this.description;
    }
    
    public void Impediment.setDescription(String description) {
        this.description = description;
    }
    
    public Sprint Impediment.getSprint() {
        return this.sprint;
    }
    
    public void Impediment.setSprint(Sprint sprint) {
        this.sprint = sprint;
    }
    
    public User Impediment.getSubmitter() {
        return this.submitter;
    }
    
    public void Impediment.setSubmitter(User submitter) {
        this.submitter = submitter;
    }
    
    public Calendar Impediment.getSubmittedDate() {
        return this.submittedDate;
    }
    
    public void Impediment.setSubmittedDate(Calendar submittedDate) {
        this.submittedDate = submittedDate;
    }
    
    public boolean Impediment.isClosed() {
        return this.closed;
    }
    
    public void Impediment.setClosed(boolean closed) {
        this.closed = closed;
    }
    
}
