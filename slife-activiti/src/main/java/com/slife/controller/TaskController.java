package com.slife.controller;

import com.slife.base.entity.ReturnDTO;
import com.slife.base.vo.DataTable;
import com.slife.form.StartTaskForm;
import com.slife.service.TaskService;
import com.slife.util.ReturnDTOUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

/**
 * @Author felixu
 * @Date 2018.08.14
 */
@Controller
@RequestMapping("/task")
@Api(value = "任务管理的前端控制器", tags = "任务管理接口", description = "任务相关")
public class TaskController {

    @Autowired
    TaskService taskService;

    @ApiOperation(value = "进入流程管理页面", notes = "进入流程管理页面")
    @GetMapping(value = "/todo")
    public String list(Model model, HttpServletRequest request) {
        model.addAttribute("url", request.getContextPath()+"/task/todo/");
        return "task/todoList";
    }

    @ApiOperation(value = "待办列表", notes = "待办列表")
    @PostMapping("/todo/list")
    @ResponseBody
    public DataTable todoList(@RequestBody DataTable dt) {
        return taskService.getTodoTasks(dt);
    }

    @ApiOperation(value = "开始流程", notes = "开始任务")
    @PostMapping("/todo/start")
    public ReturnDTO start(@RequestBody StartTaskForm form, BindingResult result) {
        if (result.hasErrors()) {

        }
        return ReturnDTOUtil.success();
    }
}
