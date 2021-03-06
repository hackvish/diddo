// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.cisco.diddo.entity;

import com.cisco.diddo.dao.ScrumMasterDao;
import com.cisco.diddo.entity.ScrumMaster;
import com.cisco.diddo.entity.ScrumMasterDataOnDemand;
import com.cisco.diddo.entity.TeamDataOnDemand;
import com.cisco.diddo.entity.UserDataOnDemand;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect ScrumMasterDataOnDemand_Roo_DataOnDemand {
    
    declare @type: ScrumMasterDataOnDemand: @Component;
    
    private Random ScrumMasterDataOnDemand.rnd = new SecureRandom();
    
    private List<ScrumMaster> ScrumMasterDataOnDemand.data;
    
    @Autowired
    private UserDataOnDemand ScrumMasterDataOnDemand.userDataOnDemand;
    
    @Autowired
    private TeamDataOnDemand ScrumMasterDataOnDemand.teamDataOnDemand;
    
    @Autowired
    ScrumMasterDao ScrumMasterDataOnDemand.scrumMasterDao;
    
    public ScrumMaster ScrumMasterDataOnDemand.getNewTransientScrumMaster(int index) {
        ScrumMaster obj = new ScrumMaster();
        return obj;
    }
    
    public ScrumMaster ScrumMasterDataOnDemand.getSpecificScrumMaster(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        ScrumMaster obj = data.get(index);
        BigInteger id = obj.getId();
        return scrumMasterDao.findOne(id);
    }
    
    public ScrumMaster ScrumMasterDataOnDemand.getRandomScrumMaster() {
        init();
        ScrumMaster obj = data.get(rnd.nextInt(data.size()));
        BigInteger id = obj.getId();
        return scrumMasterDao.findOne(id);
    }
    
    public boolean ScrumMasterDataOnDemand.modifyScrumMaster(ScrumMaster obj) {
        return false;
    }
    
    public void ScrumMasterDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = scrumMasterDao.findAll(new org.springframework.data.domain.PageRequest(from / to, to)).getContent();
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'ScrumMaster' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<ScrumMaster>();
        for (int i = 0; i < 10; i++) {
            ScrumMaster obj = getNewTransientScrumMaster(i);
            try {
                scrumMasterDao.save(obj);
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            data.add(obj);
        }
    }
    
}
