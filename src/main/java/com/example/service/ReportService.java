package com.example.service;

import com.example.entity.Report;
import java.util.List;
import java.util.Map;

public interface ReportService {
    // 创建报告
    Long createReport(Report report);
    
    // 更新报告
    boolean updateReport(Report report);
    
    // 删除报告
    boolean deleteReport(Long id);
    
    // 获取报告详情
    Report getReportById(Long id);
    
    // 获取所有报告
    List<Report> getAllReports();
    
    // 条件查询报告
    List<Report> searchReports(Report condition);
    
    // 获取报告总数
    int getReportCount();

    List<Report> getReportsByType(Integer typeId);
    Map<String, Object> getReportTypeStats();
}
