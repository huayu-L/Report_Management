package com.example.mapper;

import com.example.entity.User;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserMapper {
    @Select("SELECT * FROM user WHERE username = #{username}")
    User findByUsername(String username);

    @Insert("INSERT INTO user(username, password, real_name, email, phone, role) " +
            "VALUES(#{username}, #{password}, #{realName}, #{email}, #{phone}, #{role})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(User user);

    @Update("UPDATE user SET password=#{password}, real_name=#{realName}, email=#{email}, " +
            "phone=#{phone}, role=#{role} WHERE id=#{id}")
    int update(User user);

    @Delete("DELETE FROM user WHERE id=#{id}")
    int delete(Integer id);

    @Select("SELECT * FROM user")
    List<User> findAll();

    @Select("SELECT * FROM user WHERE id=#{id}")
    User findById(Integer id);

    @Select("SELECT role as roleName, COUNT(id) as count FROM user GROUP BY role")
    List<Map<String, Object>> getAccountStats();
}
