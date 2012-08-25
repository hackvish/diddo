// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.cisco.diddo.web;

import com.cisco.diddo.entity.Impediment;
import com.cisco.diddo.web.ImpedimentController;
import java.math.BigInteger;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

privileged aspect ImpedimentController_Roo_Controller_Json {
    
    @RequestMapping(value = "/{id}", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> ImpedimentController.showJson(@PathVariable("id") BigInteger id) {
        Impediment impediment = impedimentDao.findOne(id);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json; charset=utf-8");
        if (impediment == null) {
            return new ResponseEntity<String>(headers, HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<String>(impediment.toJson(), headers, HttpStatus.OK);
    }
    
    @RequestMapping(value = "/jsonArray", method = RequestMethod.POST, headers = "Accept=application/json")
    public ResponseEntity<String> ImpedimentController.createFromJsonArray(@RequestBody String json) {
        for (Impediment impediment: Impediment.fromJsonArrayToImpediments(json)) {
            impedimentDao.save(impediment);
        }
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        return new ResponseEntity<String>(headers, HttpStatus.CREATED);
    }
    
    @RequestMapping(method = RequestMethod.PUT, headers = "Accept=application/json")
    public ResponseEntity<String> ImpedimentController.updateFromJson(@RequestBody String json) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        Impediment impediment = Impediment.fromJsonToImpediment(json);
        if (impedimentDao.save(impediment) == null) {
            return new ResponseEntity<String>(headers, HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<String>(headers, HttpStatus.OK);
    }
    
    @RequestMapping(value = "/jsonArray", method = RequestMethod.PUT, headers = "Accept=application/json")
    public ResponseEntity<String> ImpedimentController.updateFromJsonArray(@RequestBody String json) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        for (Impediment impediment: Impediment.fromJsonArrayToImpediments(json)) {
            if (impedimentDao.save(impediment) == null) {
                return new ResponseEntity<String>(headers, HttpStatus.NOT_FOUND);
            }
        }
        return new ResponseEntity<String>(headers, HttpStatus.OK);
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, headers = "Accept=application/json")
    public ResponseEntity<String> ImpedimentController.deleteFromJson(@PathVariable("id") BigInteger id) {
        Impediment impediment = impedimentDao.findOne(id);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        if (impediment == null) {
            return new ResponseEntity<String>(headers, HttpStatus.NOT_FOUND);
        }
        impedimentDao.delete(impediment);
        return new ResponseEntity<String>(headers, HttpStatus.OK);
    }
    
}
