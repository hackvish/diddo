// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.cisco.diddo.entity;

import com.cisco.diddo.dao.TeamDao;
import com.cisco.diddo.entity.TeamDataOnDemand;
import com.cisco.diddo.entity.TeamIntegrationTest;
import java.math.BigInteger;
import java.util.List;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

privileged aspect TeamIntegrationTest_Roo_IntegrationTest {
    
    declare @type: TeamIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: TeamIntegrationTest: @ContextConfiguration(locations = "classpath:/META-INF/spring/applicationContext*.xml");
    
    @Autowired
    private TeamDataOnDemand TeamIntegrationTest.dod;
    
    @Autowired
    TeamDao TeamIntegrationTest.teamDao;
    
    @Test
    public void TeamIntegrationTest.testCount() {
        Assert.assertNotNull("Data on demand for 'Team' failed to initialize correctly", dod.getRandomTeam());
        long count = teamDao.count();
        Assert.assertTrue("Counter for 'Team' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void TeamIntegrationTest.testFind() {
        Team obj = dod.getRandomTeam();
        Assert.assertNotNull("Data on demand for 'Team' failed to initialize correctly", obj);
        BigInteger id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Team' failed to provide an identifier", id);
        obj = teamDao.findOne(id);
        Assert.assertNotNull("Find method for 'Team' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'Team' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void TeamIntegrationTest.testFindAll() {
        Assert.assertNotNull("Data on demand for 'Team' failed to initialize correctly", dod.getRandomTeam());
        long count = teamDao.count();
        Assert.assertTrue("Too expensive to perform a find all test for 'Team', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<Team> result = teamDao.findAll();
        Assert.assertNotNull("Find all method for 'Team' illegally returned null", result);
        Assert.assertTrue("Find all method for 'Team' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void TeamIntegrationTest.testFindEntries() {
        Assert.assertNotNull("Data on demand for 'Team' failed to initialize correctly", dod.getRandomTeam());
        long count = teamDao.count();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<Team> result = teamDao.findAll(new org.springframework.data.domain.PageRequest(firstResult / maxResults, maxResults)).getContent();
        Assert.assertNotNull("Find entries method for 'Team' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'Team' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void TeamIntegrationTest.testSave() {
        Assert.assertNotNull("Data on demand for 'Team' failed to initialize correctly", dod.getRandomTeam());
        Team obj = dod.getNewTransientTeam(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'Team' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'Team' identifier to be null", obj.getId());
        teamDao.save(obj);
        Assert.assertNotNull("Expected 'Team' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void TeamIntegrationTest.testDelete() {
        Team obj = dod.getRandomTeam();
        Assert.assertNotNull("Data on demand for 'Team' failed to initialize correctly", obj);
        BigInteger id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Team' failed to provide an identifier", id);
        obj = teamDao.findOne(id);
        teamDao.delete(obj);
        Assert.assertNull("Failed to remove 'Team' with identifier '" + id + "'", teamDao.findOne(id));
    }
    
}