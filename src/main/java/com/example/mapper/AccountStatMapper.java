package com.example.mapper;

import com.example.entity.AccountStat;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface AccountStatMapper {
    AccountStat findByUserId(@Param("userId") Integer userId);

    int updateLoginStat(@Param("userId") Long userId);

    int updateReportStat(@Param("userId") Long userId);

    Map<String, Object> getUserStats(@Param("userId") Long userId);

    List<Map<String, Object>> getAllUserStats();
}
