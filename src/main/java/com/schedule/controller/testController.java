package com.schedule.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class testController {

    @RequestMapping(value = "/testGoPage", method = RequestMethod.GET)
    public String testGoPage() {

        System.out.println("GO_TESTPAGE");
        return "index";
    }
}
