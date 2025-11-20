package com.example.service.impl;

import com.example.entity.Report;
import com.example.mapper.AccountStatMapper;
import com.example.mapper.ReportMapper;
import com.example.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ReportServiceImpl implements ReportService {

    @Autowired
    private ReportMapper reportMapper;
    
    @Autowired
    private AccountStatMapper accountStatMapper;

    @Override
    public List<Report> getAllReports() {
        return reportMapper.selectAll();
    }

    @Override
    public Report getReportById(Long id) {
        return reportMapper.selectById(id);
    }

    @Override
    @Transactional
    public Long createReport(Report report) {
        reportMapper.insert(report);
        return report.getId();
    }

    @Override
    @Transactional
    public boolean updateReport(Report report) {
        return reportMapper.update(report) > 0;
    }

    @Override
    @Transactional
    public boolean deleteReport(Long id) {
        return reportMapper.deleteById(id) > 0;
    }

    @Override
    public List<Report> getReportsByType(Integer typeId) {
        return reportMapper.selectByTypeId(typeId);
    }

    @Override
    public Map<String, Object> getReportTypeStats() {
        List<Map<String, Object>> stats = reportMapper.selectReportTypeStats();
        Map<String, Object> result = new HashMap<>();
        List<String> labels = new ArrayList<>();
        List<Integer> values = new ArrayList<>();
        
        for (Map<String, Object> stat : stats) {
            labels.add((String) stat.get("typeName"));
            values.add(((Number) stat.get("count")).intValue());
        }
        
        result.put("labels", labels);
        result.put("values", values);
        return result;
    }

    @Override
    public List<Report> searchReports(Report condition) {
        return reportMapper.selectByCondition(condition);
    }

    @Override
    public int getReportCount() {
        return reportMapper.count();
    }
}
