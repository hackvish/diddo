// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.cisco.diddo.entity;

import com.cisco.diddo.entity.Team;
import java.math.BigInteger;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Persistent;

privileged aspect Team_Roo_Mongo_Entity {
    
    declare @type: Team: @Persistent;
    
    @Id
    private BigInteger Team.id;
    
    public BigInteger Team.getId() {
        return this.id;
    }
    
    public void Team.setId(BigInteger id) {
        this.id = id;
    }
    
}
