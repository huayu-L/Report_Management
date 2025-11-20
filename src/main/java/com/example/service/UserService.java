package com.example.service;

import com.example.entity.User;
import java.util.List;
import java.util.Map;

public interface UserService {
    User login(String username, String password);
    boolean register(User user);
    List<User> getAllUsers();
    boolean updateUser(User user);
    boolean deleteUser(Integer id);
    Map<String, Object> getAccountStats();
}
