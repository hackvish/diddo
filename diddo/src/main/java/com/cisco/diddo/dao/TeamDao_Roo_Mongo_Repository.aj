// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.cisco.diddo.dao;

import com.cisco.diddo.dao.TeamDao;
import com.cisco.diddo.entity.Team;
import java.math.BigInteger;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

privileged aspect TeamDao_Roo_Mongo_Repository {
    
    declare parents: TeamDao extends PagingAndSortingRepository<Team, BigInteger>;
    
    declare @type: TeamDao: @Repository;
    
}