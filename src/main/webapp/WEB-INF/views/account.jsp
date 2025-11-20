<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>账户管理 - 销售报表管理系统</title>
    <style>
        .account-container {
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
            background-color: #7B2CBF;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .search-btn:hover {
            background-color: #5A3D7A;
        }
        .add-btn {
            background-color: #9C4DFF;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            margin-left: auto;
            transition: all 0.3s;
        }
        .add-btn:hover {
            background-color: #7B2CBF;
        }
        .account-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #3A2A4C;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            border: 1px solid #5A3D7A;
        }
        .account-table th, .account-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #5A3D7A;
            color: #E0C3FC;
        }
        .account-table th {
            background-color: #5A3D7A;
            color: white;
        }
        .account-table tr:hover {
            background-color: #2A1A3C;
        }
        .action-btn {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
            transition: all 0.3s;
        }
        .edit-btn {
            background-color: #9C4DFF;
            color: white;
        }
        .edit-btn:hover {
            background-color: #7B2CBF;
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
            border: 1px solid #5A3D7A;
            border-radius: 3px;
            text-decoration: none;
            color: #9C4DFF;
            background-color: #3A2A4C;
        }
        .page-link:hover {
            background-color: #2A1A3C;
        }
        .page-link.active {
            background-color: #9C4DFF;
            color: white;
            border-color: #9C4DFF;
        }
        .role-admin {
            color: #E74C3C;
            font-weight: bold;
        }
        .role-user {
            color: #2ecc71;
        }
    </style>
</head>
<body>
    <div class="account-container">
        <div class="search-bar">
            <select class="search-input">
                <option value="">所有角色</option>
                <option value="admin">管理员</option>
                <option value="user">普通用户</option>
            </select>
            <input type="text" class="search-input" placeholder="搜索用户...">
            <button class="search-btn">搜索</button>
            <button class="add-btn" onclick="location.href='${pageContext.request.contextPath}/user/detail'">新增用户</button>
        </div>

        <table class="account-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>用户名</th>
                    <th>真实姓名</th>
                    <th>角色</th>
                    <th>邮箱</th>
                    <th>电话</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.username}</td>
                        <td>${user.realName}</td>
                        <td>
                            <span class="${user.role == 'admin' ? 'role-admin' : 'role-user'}">
                                ${user.role == 'admin' ? '管理员' : '普通用户'}
                            </span>
                        </td>
                        <td>${user.email}</td>
                        <td>${user.phone}</td>
                        <td>
                            <button class="action-btn edit-btn" onclick="location.href='${pageContext.request.contextPath}/user/detail?id=${user.id}'">编辑</button>
                            <button class="action-btn delete-btn" onclick="if(confirm('确定删除此用户吗？')) location.href='${pageContext.request.contextPath}/user/delete?id=${user.id}'">删除</button>
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
