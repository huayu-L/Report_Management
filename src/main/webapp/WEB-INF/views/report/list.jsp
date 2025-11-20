<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>报告列表</title>
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>报告列表</h2>
        
        <!-- 搜索栏 -->
        <div class="row mb-3">
            <div class="col">
                <form id="searchForm" class="row g-3">
                    <div class="col-md-4">
                        <input type="text" class="form-control" id="title" name="title" placeholder="报告标题">
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" id="typeId" name="typeId">
                            <option value="">选择报告类型</option>
                            <c:forEach items="${reportTypes}" var="type">
                                <option value="${type.id}">${type.typeName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary">搜索</button>
                    </div>
                    <div class="col-md-2">
                        <a href="${pageContext.request.contextPath}/report/create" class="btn btn-success">
                            <i class="fas fa-plus"></i> 新建报告
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- 报告列表 -->
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>标题</th>
                        <th>类型</th>
                        <th>创建者</th>
                        <th>创建时间</th>
                        <th>更新时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${reports}" var="report">
                        <tr>
                            <td>${report.id}</td>
                            <td>${report.title}</td>
                            <td>${report.reportType.typeName}</td>
                            <td>${report.creator.realName}</td>
                            <td>${report.createTime}</td>
                            <td>${report.updateTime}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/report/view/${report.id}" class="btn btn-info btn-sm">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/report/edit/${report.id}" class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <button class="btn btn-danger btn-sm" onclick="deleteReport(${report.id})">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 分页 -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage - 1}">上一页</a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage + 1}">下一页</a>
                </li>
            </ul>
        </nav>
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function deleteReport(id) {
            if (confirm('确定要删除这份报告吗？')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/api/reports/' + id,
                    type: 'DELETE',
                    success: function() {
                        location.reload();
                    },
                    error: function() {
                        alert('删除失败，请重试');
                    }
                });
            }
        }
    </script>
</body>
</html> 