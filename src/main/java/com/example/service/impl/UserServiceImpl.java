package com.example.service.impl;

import com.example.entity.User;
import com.example.mapper.AccountStatMapper;
import com.example.mapper.UserMapper;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service

@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;
    
    @Autowired
    private AccountStatMapper accountStatMapper;

    @Override
    public User login(String username, String password) {
        User user = userMapper.findByUsername(username);
        if (user != null && password.equals(user.getPassword())) {
            // 更新登录统计
            accountStatMapper.updateLoginStat(user.getId());
            return user;
        }
        return null;
    }

    @Override
    public boolean register(User user) {
        if (userMapper.findByUsername(user.getUsername()) != null) {
            return false; // 用户名已存在
        }
        user.setRole("user"); // 默认用户角色
        int result = userMapper.insert(user);
        if (result > 0) {
            // 初始化账户统计
            accountStatMapper.updateLoginStat(user.getId());
            return true;
        }
        return false;
    }

    @Override
    public List<User> getAllUsers() {
        return userMapper.findAll();
    }

    @Override
    public boolean updateUser(User user) {
        return userMapper.update(user) > 0;
    }

    @Override
    public boolean deleteUser(Integer id) {
        return userMapper.delete(id) > 0;
    }

    @Override
    public Map<String, Object> getAccountStats() {
        List<Map<String, Object>> stats = userMapper.getAccountStats();
        Map<String, Object> result = new HashMap<>();
        List<String> labels = new ArrayList<>();
        List<Integer> values = new ArrayList<>();
        
        for (Map<String, Object> stat : stats) {
            labels.add((String) stat.get("roleName"));
            values.add(((Number) stat.get("count")).intValue());
        }
        
        result.put("labels", labels);
        result.put("values", values);
        return result;
    }
}
