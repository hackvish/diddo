// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.cisco.diddo.entity;

import com.cisco.diddo.dao.UserDao;
import com.cisco.diddo.entity.TeamDataOnDemand;
import com.cisco.diddo.entity.User;
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

privileged aspect UserDataOnDemand_Roo_DataOnDemand {
    
    declare @type: UserDataOnDemand: @Component;
    
    private Random UserDataOnDemand.rnd = new SecureRandom();
    
    private List<User> UserDataOnDemand.data;
    
    @Autowired
    private TeamDataOnDemand UserDataOnDemand.teamDataOnDemand;
    
    @Autowired
    UserDao UserDataOnDemand.userDao;
    
    public User UserDataOnDemand.getNewTransientUser(int index) {
        User obj = new User();
        setEmail(obj, index);
        setPassword(obj, index);
        setScrumMaster(obj, index);
        setUsername(obj, index);
        return obj;
    }
    
    public void UserDataOnDemand.setEmail(User obj, int index) {
        String email = "foo" + index + "@bar.com";
        obj.setEmail(email);
    }
    
    public void UserDataOnDemand.setPassword(User obj, int index) {
        String password = "password_" + index;
        if (password.length() > 20) {
            password = password.substring(0, 20);
        }
        obj.setPassword(password);
    }
    
    public void UserDataOnDemand.setScrumMaster(User obj, int index) {
        Boolean scrumMaster = Boolean.TRUE;
        obj.setScrumMaster(scrumMaster);
    }
    
    public void UserDataOnDemand.setUsername(User obj, int index) {
        String username = "username_" + index;
        obj.setUsername(username);
    }
    
    public User UserDataOnDemand.getSpecificUser(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        User obj = data.get(index);
        BigInteger id = obj.getId();
        return userDao.findOne(id);
    }
    
    public User UserDataOnDemand.getRandomUser() {
        init();
        User obj = data.get(rnd.nextInt(data.size()));
        BigInteger id = obj.getId();
        return userDao.findOne(id);
    }
    
    public boolean UserDataOnDemand.modifyUser(User obj) {
        return false;
    }
    
    public void UserDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = userDao.findAll(new org.springframework.data.domain.PageRequest(from / to, to)).getContent();
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'User' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<User>();
        for (int i = 0; i < 10; i++) {
            User obj = getNewTransientUser(i);
            try {
                userDao.save(obj);
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
