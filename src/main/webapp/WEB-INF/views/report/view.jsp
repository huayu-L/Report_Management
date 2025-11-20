<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${report.title}</title>
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .report-content {
            white-space: pre-wrap;
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .report-meta {
            color: #6c757d;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>${report.title}</h2>
            <div>
                <a href="${pageContext.request.contextPath}/report/edit/${report.id}" class="btn btn-warning">
                    <i class="fas fa-edit"></i> 编辑
                </a>
                <a href="${pageContext.request.contextPath}/report/list" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> 返回列表
                </a>
            </div>
        </div>
        
        <div class="report-meta mb-3">
            <p>
                <strong>报告类型：</strong>${report.reportType.typeName}<br>
                <strong>创建者：</strong>${report.creator.realName}<br>
                <strong>创建时间：</strong><fmt:formatDate value="${report.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/><br>
                <strong>更新时间：</strong><fmt:formatDate value="${report.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </p>
        </div>
        
        <div class="report-content">
            ${report.content}
        </div>
        
        <div class="mt-4">
            <h4>报告类型说明</h4>
            <p>${report.reportType.description}</p>
        </div>
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html> 