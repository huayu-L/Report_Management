<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${report.id == null ? '新建报告' : '编辑报告'}</title>
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>${report.id == null ? '新建报告' : '编辑报告'}</h2>
        
        <form id="reportForm" class="mt-4">
            <input type="hidden" id="id" name="id" value="${report.id}">
            
            <div class="mb-3">
                <label for="title" class="form-label">报告标题</label>
                <input type="text" class="form-control" id="title" name="title" value="${report.title}" required>
            </div>
            
            <div class="mb-3">
                <label for="typeId" class="form-label">报告类型</label>
                <select class="form-select" id="typeId" name="typeId" required>
                    <option value="">请选择报告类型</option>
                    <c:forEach items="${reportTypes}" var="type">
                        <option value="${type.id}" ${report.reportType.id == type.id ? 'selected' : ''}>
                            ${type.typeName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="content" class="form-label">报告内容</label>
                <textarea class="form-control" id="content" name="content" rows="10" required>${report.content}</textarea>
            </div>
            
            <div class="mb-3">
                <button type="submit" class="btn btn-primary">保存</button>
                <a href="${pageContext.request.contextPath}/report/list" class="btn btn-secondary">返回</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#reportForm').on('submit', function(e) {
                e.preventDefault();
                
                var report = {
                    id: $('#id').val() ? parseInt($('#id').val()) : null,
                    title: $('#title').val(),
                    content: $('#content').val(),
                    reportType: {
                        id: parseInt($('#typeId').val())
                    }
                };
                
                var url = '${pageContext.request.contextPath}/api/reports';
                var method = report.id ? 'PUT' : 'POST';
                if (report.id) {
                    url += '/' + report.id;
                }
                
                $.ajax({
                    url: url,
                    type: method,
                    contentType: 'application/json',
                    data: JSON.stringify(report),
                    success: function() {
                        window.location.href = '${pageContext.request.contextPath}/report/list';
                    },
                    error: function() {
                        alert('保存失败，请重试');
                    }
                });
            });
        });
    </script>
</body>
</html> 