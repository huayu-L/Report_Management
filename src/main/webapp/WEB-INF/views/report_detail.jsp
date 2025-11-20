<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${empty report.id ? '新增' : '编辑'}报表 - 销售报表管理系统</title>
    <style>
        .form-container {
            margin-top: 20px;
            background-color: #3A2A4C;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            border: 1px solid #5A3D7A;
            color: #E0C3FC;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input[type="text"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            background-color: #2A1A3C;
            border: 1px solid #5A3D7A;
            border-radius: 4px;
            font-size: 16px;
            color: #E0C3FC;
        }
        textarea {
            min-height: 150px;
            resize: vertical;
        }
        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .save-btn {
            background-color: #9C4DFF;
            color: white;
        }
        .cancel-btn {
            background-color: #4A3A5C;
            color: #E0C3FC;
        }
        .save-btn:hover {
            background-color: #7B2CBF;
        }
        .cancel-btn:hover {
            background-color: #5A4B6C;
        }
    </style>
</head>
<body>
    <!-- 继承index.jsp的布局 -->
    <jsp:include page="index.jsp"/>

    <!-- 主内容区 -->
    <div class="content-area">
        <div class="form-container">
            <h2>${empty report.id ? '新增报表' : '编辑报表'}</h2>
            <form action="${pageContext.request.contextPath}/report/${empty report.id ? 'create' : 'update'}" method="post">
                <input type="hidden" name="id" value="${report.id}">
                <input type="hidden" name="creatorId" value="${user.id}">
                
                <div class="form-group">
                    <label for="title">报表标题</label>
                    <input type="text" id="title" name="title" value="${report.title}" required>
                </div>
                
                <div class="form-group">
                    <label for="typeId">报表类型</label>
                    <select id="typeId" name="typeId" required>
                        <option value="">请选择报表类型</option>
                        <c:forEach items="${reportTypes}" var="type">
                            <option value="${type.id}" ${report.typeId == type.id ? 'selected' : ''}>${type.typeName}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="content">报表内容</label>
                    <textarea id="content" name="content" required>${report.content}</textarea>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn save-btn">保存</button>
                    <button type="button" class="btn cancel-btn" onclick="location.href='${pageContext.request.contextPath}/report/list'">取消</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
