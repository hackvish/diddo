// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.cisco.diddo.web;

import com.cisco.diddo.constants.TASK;
import com.cisco.diddo.dao.TaskDao;
import com.cisco.diddo.dao.UserDao;
import com.cisco.diddo.dao.UserStoryDao;
import com.cisco.diddo.entity.Task;
import com.cisco.diddo.web.TaskController;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.util.Arrays;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect TaskController_Roo_Controller {
    
    @Autowired
    TaskDao TaskController.taskDao;
    
    @Autowired
    UserDao TaskController.userDao;
    
    @Autowired
    UserStoryDao TaskController.userStoryDao;
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String TaskController.create(@Valid Task task, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, task);
            return "tasks/create";
        }
        uiModel.asMap().clear();
        taskDao.save(task);
        return "redirect:/tasks/" + encodeUrlPathSegment(task.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String TaskController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Task());
        return "tasks/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String TaskController.show(@PathVariable("id") BigInteger id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("task", taskDao.findOne(id));
        uiModel.addAttribute("itemId", id);
        return "tasks/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String TaskController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("tasks", taskDao.findAll(new org.springframework.data.domain.PageRequest(firstResult / sizeNo, sizeNo)).getContent());
            float nrOfPages = (float) taskDao.count() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("tasks", taskDao.findAll());
        }
        addDateTimeFormatPatterns(uiModel);
        return "tasks/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String TaskController.update(@Valid Task task, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, task);
            return "tasks/update";
        }
        uiModel.asMap().clear();
        taskDao.save(task);
        return "redirect:/tasks/" + encodeUrlPathSegment(task.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String TaskController.updateForm(@PathVariable("id") BigInteger id, Model uiModel) {
        populateEditForm(uiModel, taskDao.findOne(id));
        return "tasks/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String TaskController.delete(@PathVariable("id") BigInteger id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Task task = taskDao.findOne(id);
        taskDao.delete(task);
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/tasks";
    }
    
    void TaskController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("task_startdate_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
        uiModel.addAttribute("task_enddate_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
    }
    
    void TaskController.populateEditForm(Model uiModel, Task task) {
        uiModel.addAttribute("task", task);
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("tasks", Arrays.asList(TASK.values()));
        uiModel.addAttribute("users", userDao.findAll());
        uiModel.addAttribute("userstorys", userStoryDao.findAll());
    }
    
    String TaskController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}