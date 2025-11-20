package com.example.controller;

import com.example.entity.Report;
import com.example.entity.User;
import com.example.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/reports")
public class ReportController {

    @Autowired
    private ReportService reportService;

    @PostMapping
    public ResponseEntity<Long> createReport(@RequestBody Report report) {
        Long id = reportService.createReport(report);
        return ResponseEntity.ok(id);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Void> updateReport(@PathVariable Long id, @RequestBody Report report) {
        report.setId(id);
        reportService.updateReport(report);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReport(@PathVariable Long id) {
        reportService.deleteReport(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Report> getReport(@PathVariable Long id) {
        Report report = reportService.getReportById(id);
        return ResponseEntity.ok(report);
    }

    @GetMapping
    public ResponseEntity<List<Report>> getAllReports() {
        List<Report> reports = reportService.getAllReports();
        return ResponseEntity.ok(reports);
    }

    @GetMapping("/search")
    public ResponseEntity<List<Report>> searchReports(Report condition) {
        List<Report> reports = reportService.searchReports(condition);
        return ResponseEntity.ok(reports);
    }

    @GetMapping("/count")
    public ResponseEntity<Integer> getReportCount() {
        int count = reportService.getReportCount();
        return ResponseEntity.ok(count);
    }

    @GetMapping("/list")
    public ModelAndView listReports(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }
        List<Report> reports = reportService.getAllReports();
        System.out.println("Retrieved reports count: " + reports.size()); // Debug log
        for (Report report : reports) {
            System.out.println("Report: " + report.getId() + " - " + report.getTitle()); // Debug log
        }
        ModelAndView mav = new ModelAndView("report");
        mav.addObject("reports", reports);
        System.out.println("ModelAndView reports attribute set with " + reports.size() + " items"); // Debug log
        return mav;
    }

    @GetMapping("/detail")
    public ModelAndView reportDetail(@RequestParam Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }
        Report report = reportService.getReportById(id);
        ModelAndView mav = new ModelAndView("report_detail");
        mav.addObject("report", report);
        return mav;
    }

    @PostMapping("/create")
    @ResponseBody
    public Map<String, Object> createReport(@RequestParam String title, 
                                          @RequestParam Integer typeId,
                                          @RequestParam String content,
                                          HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.put("success", false);
            response.put("message", "未登录");
            return response;
        }
        
        try {
            Report report = new Report();
            report.setTitle(title);
            report.setTypeId(typeId);
            report.setContent(content);
            report.setCreatorId(user.getId());
            
            Long reportId = reportService.createReport(report);
            boolean success = reportId != null;
            response.put("success", success);
            response.put("message", success ? "报表创建成功，ID: " + reportId : "报表创建失败");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "系统错误: " + e.getMessage());
        }
        return response;
    }

    @PostMapping("/update")
    public ModelAndView updateReport(Report report, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }
        Report existingReport = reportService.getReportById(report.getId());
        if (existingReport != null && (existingReport.getCreatorId().equals(user.getId()) || "admin".equals(user.getRole()))) {
            reportService.updateReport(report);
        }
        return new ModelAndView("redirect:/report/list");
    }

    @PostMapping("/delete")
    @ResponseBody
    public Map<String, Object> deleteReport(@RequestParam Long id, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.put("success", false);
            response.put("message", "未登录");
            return response;
        }
        
        Report report = reportService.getReportById(id);
        if (report != null && (report.getCreatorId().equals(user.getId()) || "admin".equals(user.getRole()))) {
            boolean success = reportService.deleteReport(id);
            response.put("success", success);
            response.put("message", success ? "删除成功" : "删除失败");
        } else {
            response.put("success", false);
            response.put("message", "无权限删除此报表");
        }
        return response;
    }

    @GetMapping("/type")
    public ModelAndView reportsByType(Integer typeId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }
        List<Report> reports = reportService.getReportsByType(typeId);
        ModelAndView mav = new ModelAndView("report");
        mav.addObject("reports", reports);
        return mav;
    }

    @GetMapping("/typeStats")
    @ResponseBody
    public Map<String, Object> getReportTypeStats(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        }
        return reportService.getReportTypeStats();
    }
}