package com.example.mapper;

import com.example.entity.Report;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReportMapper {
    int insert(Report report);

    int update(Report report);

    int deleteById(Long id);

    Report selectById(Long id);

    List<Report> selectByTypeId(Integer typeId);

    List<Report> selectAll();

    List<Map<String, Object>> selectReportTypeStats();

    List<Report> selectByCondition(Report condition);

    int count();
}
