package com.example.controller;

import com.example.entity.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private ServletContext servletContext;

    @PostMapping("/login")
    public ModelAndView login(String username, String password, HttpSession session) {
        User user = userService.login(username, password);
        if (user != null) {
            session.setAttribute("user", user);
            return new ModelAndView("redirect:/index");
        }
        return new ModelAndView("redirect:/login?error=true");
    }

    @PostMapping("/register")
    public ModelAndView register(User user, HttpSession session) {
        if (userService.register(user)) {
            return new ModelAndView("redirect:/login?register=success");
        }
        return new ModelAndView("redirect:/register?error=true");
    }

    @GetMapping("/logout")
    public ModelAndView logout(HttpSession session) {
        session.invalidate();
        return new ModelAndView("redirect:/login");
    }

    @GetMapping("/list")
    public ModelAndView listUsers(HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            return new ModelAndView("redirect:/login");
        }
        List<User> users = userService.getAllUsers();
        ModelAndView mav = new ModelAndView("account");
        mav.addObject("users", users);
        return mav;
    }

    @PostMapping("/update")
    public ModelAndView updateUser(User user, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser != null && (currentUser.getId().equals(user.getId()) || "admin".equals(currentUser.getRole()))) {
            userService.updateUser(user);
        }
        return new ModelAndView("redirect:/user/list");
    }

    @GetMapping("/delete")
    public ModelAndView deleteUser(Integer id, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser != null && "admin".equals(currentUser.getRole())) {
            userService.deleteUser(id);
        }
        return new ModelAndView("redirect:/user/list");
    }

    @GetMapping("/accountStats")
    @ResponseBody
    public Map<String, Object> getAccountStats(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        }
        return userService.getAccountStats();
    }

    @GetMapping("/checkLogin")
    @ResponseBody
    public Map<String, Object> checkLogin(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        response.put("loggedIn", session.getAttribute("user") != null);
        return response;
    }
}
