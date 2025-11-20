<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>报表管理 - 销售报表管理系统</title>
    <style>
        .report-container {
            margin-top: 20px;
        }
        .search-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            background-color: #3A2A4C;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            border: 1px solid #5A3D7A;
        }
        .search-input {
            flex: 1;
            padding: 10px;
            background-color: #2A1A3C;
            border: 1px solid #5A3D7A;
            border-radius: 4px;
            color: #E0C3FC;
        }
        .search-btn {
            background-color: #9C4DFF;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .search-btn:hover {
            background-color: #7B2CBF;
        }
        .add-btn {
            background-color: #7B2CBF;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            margin-left: auto;
            transition: background-color 0.3s;
        }
        .add-btn:hover {
            background-color: #5A3D7A;
        }
        .report-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #3A2A4C;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            border: 1px solid #5A3D7A;
        }
        .report-table th, .report-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #5A3D7A;
            color: #E0C3FC;
        }
        .report-table th {
            background-color: #9C4DFF;
            color: white;
        }
        .report-table tr:hover {
            background-color: #4A3A5C;
        }
        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
            font-size: 14px;
            transition: all 0.3s;
        }
        .edit-btn {
            background-color: #B399D4;
            color: white;
        }
        .edit-btn:hover {
            background-color: #9C4DFF;
        }
        .delete-btn {
            background-color: #E74C3C;
            color: white;
        }
        .delete-btn:hover {
            background-color: #C0392B;
        }
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .page-item {
            margin: 0 5px;
        }
        .page-link {
            padding: 8px 12px;
            background-color: #3A2A4C;
            border: 1px solid #5A3D7A;
            border-radius: 4px;
            text-decoration: none;
            color: #E0C3FC;
            transition: all 0.3s;
        }
        .page-link:hover {
            background-color: #4A3A5C;
        }
        .page-link.active {
            background-color: #9C4DFF;
            color: white;
            border-color: #9C4DFF;
        }
    </style>
</head>
<body>
    <div class="report-container">
        <div class="search-bar">
            <select class="search-input">
                <option value="">所有类型</option>
                <option value="1">销售报表</option>
                <option value="2">库存报表</option>
                <option value="3">财务报表</option>
                <option value="4">客户报表</option>
            </select>
            <input type="text" class="search-input" placeholder="搜索报表...">
            <button class="search-btn">搜索</button>
            <button class="add-btn" id="addReportBtn">新增报表</button>
        </div>

        <!-- 新增报表模态窗口 -->
        <div id="addReportModal" class="modal" style="display:none;">
            <div class="modal-content" style="background-color:#3A2A4C;padding:20px;border-radius:5px;max-width:500px;margin:auto;margin-top:50px;">
                <h3 style="color:#9C4DFF;margin-bottom:20px;">新增报表</h3>
                <form id="reportForm">
                    <div style="margin-bottom:15px;">
                        <label style="display:block;margin-bottom:5px;color:#E0C3FC;">报表标题</label>
                        <input type="text" name="title" required style="width:100%;padding:8px;background-color:#2A1A3C;border:1px solid #5A3D7A;border-radius:4px;color:#E0C3FC;">
                    </div>
                    <div style="margin-bottom:15px;">
                        <label style="display:block;margin-bottom:5px;color:#E0C3FC;">报表类型</label>
                        <select name="typeId" required style="width:100%;padding:8px;background-color:#2A1A3C;border:1px solid #5A3D7A;border-radius:4px;color:#E0C3FC;">
                            <option value="">请选择类型</option>
                            <option value="1">销售报表</option>
                            <option value="2">库存报表</option>
                            <option value="3">财务报表</option>
                        </select>
                    </div>
                    <div style="margin-bottom:20px;">
                        <label style="display:block;margin-bottom:5px;color:#E0C3FC;">报表内容</label>
                        <textarea name="content" rows="4" required style="width:100%;padding:8px;background-color:#2A1A3C;border:1px solid #5A3D7A;border-radius:4px;color:#E0C3FC;"></textarea>
                    </div>
                    <div style="text-align:right;">
                        <button type="button" id="cancelBtn" style="padding:8px 15px;background-color:#5A3D7A;color:white;border:none;border-radius:4px;margin-right:10px;cursor:pointer;">取消</button>
                        <button type="submit" style="padding:8px 15px;background-color:#9C4DFF;color:white;border:none;border-radius:4px;cursor:pointer;">提交</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- 确保jQuery加载 -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function() {
                // 新增报表按钮处理 - 显示模态窗口
                $('#addReportBtn').click(function() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/user/checkLogin',
                        type: 'GET',
                        success: function(response) {
                            if (response.loggedIn) {
                                $('#addReportModal').show();
                            } else {
                                alert('请先登录系统');
                                window.location.href = '${pageContext.request.contextPath}/login';
                            }
                        },
                        error: function(xhr) {
                            console.error('Error checking login:', xhr.statusText);
                            alert('系统错误，请稍后再试');
                        }
                    });
                });

                // 取消按钮
                $('#cancelBtn').click(function() {
                    $('#addReportModal').hide();
                });

                // 表单提交处理
                $('#reportForm').submit(function(e) {
                    e.preventDefault();
                    const form = $(this);
                    $.ajax({
                        url: '${pageContext.request.contextPath}/report/create',
                        type: 'POST',
                        data: form.serialize(),
                        success: function(response) {
                            if (response.success) {
                                alert(response.message);
                                $('#addReportModal').hide();
                                form[0].reset();
                                location.reload();
                            } else {
                                alert(response.message);
                            }
                        },
                        error: function(xhr) {
                            console.error('Add report error:', xhr.responseText);
                            let errorMsg = '添加失败';
                            try {
                                const json = JSON.parse(xhr.responseText);
                                errorMsg = json.message || errorMsg;
                            } catch (e) {}
                            alert(errorMsg);
                        }
                    });
                });

                // 删除按钮处理 - 改为AJAX方式
                $('.delete-btn').click(function() {
                    const reportId = $(this).data('report-id');
                    if (confirm('确定删除此报表吗？')) {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/report/delete',
                            type: 'POST',
                            data: { id: reportId },
                            success: function() {
                                // 局部刷新表格
                                location.reload();
                            },
                            error: function(xhr) {
                                console.error('Delete error:', xhr.statusText);
                                alert('删除失败: ' + xhr.responseText);
                            }
                        });
                    }
                });
            });
        </script>
        </div>

        <table class="report-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>标题</th>
                    <th>类型</th>
                    <th>创建者</th>
                    <th>创建时间</th>
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
                        <td>
                            <button class="action-btn edit-btn" onclick="location.href='${pageContext.request.contextPath}/report/detail?id=${report.id}'">编辑</button>
                            <button class="action-btn delete-btn" data-report-id="${report.id}">删除</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="pagination">
            <a href="#" class="page-link">&laquo;</a>
            <a href="#" class="page-link active">1</a>
            <a href="#" class="page-link">2</a>
            <a href="#" class="page-link">3</a>
            <a href="#" class="page-link">&raquo;</a>
        </div>
    </div>
</body>
</html>
