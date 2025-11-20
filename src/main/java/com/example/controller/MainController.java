package com.example.controller;

import com.example.entity.User;
import com.example.entity.Report;
import com.example.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    private ServletContext servletContext;
    
    @Autowired
    private ReportService reportService;

    @GetMapping("/")
    public ModelAndView index() {
        return new ModelAndView("redirect:/welcome");
    }

    @GetMapping("/welcome")
    public ModelAndView welcome() {
        return new ModelAndView("welcome");
    }

    @GetMapping("/login")
    public ModelAndView login() {
        return new ModelAndView("login");
    }

    @GetMapping("/register")
    public ModelAndView register() {
        return new ModelAndView("register");
    }

    @GetMapping("/index")
    public ModelAndView home(HttpSession session, HttpServletResponse response) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }
        // 设置缓存控制头
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        return new ModelAndView("index");
    }

    @GetMapping("/home")
    public ModelAndView homePage(HttpSession session, HttpServletResponse response) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }
        // 设置缓存控制头
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        return new ModelAndView("home");
    }

    @GetMapping("/personal")
    public ModelAndView personal(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }
        ModelAndView mav = new ModelAndView("personal");
        mav.addObject("user", user);
        return mav;
    }

    @GetMapping("/setting")
    public ModelAndView setting(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }
        return new ModelAndView("setting");
    }

    @GetMapping("/chart")
    public ModelAndView chart(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }
        return new ModelAndView("chart");
    }

    @GetMapping("/print")
    public ModelAndView print(HttpSession session, HttpServletResponse response) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }
        // 设置缓存控制头
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        
        // 获取报表数据
        List<Report> reports = reportService.getAllReports();
        ModelAndView mav = new ModelAndView("print");
        mav.addObject("reports", reports);
        return mav;
    }
}
