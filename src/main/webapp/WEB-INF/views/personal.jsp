<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>个人设置 - 销售报表管理系统</title>
    <style>
        .personal-container {
            background-color: #3A2A4C;
            padding: 20px;
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
        input[type="password"],
        input[type="email"],
        input[type="tel"] {
            width: 100%;
            padding: 12px;
            background-color: #2A1A3C;
            border: 1px solid #5A3D7A;
            border-radius: 4px;
            font-size: 16px;
            color: #E0C3FC;
            transition: all 0.3s;
        }
        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus,
        input[type="tel"]:focus {
            border-color: #9C4DFF;
            outline: none;
            box-shadow: 0 0 0 2px rgba(156, 77, 255, 0.3);
        }
        .section-title {
            font-size: 18px;
            color: #9C4DFF;
            margin: 25px 0 15px;
            padding-bottom: 5px;
            border-bottom: 1px solid #5A3D7A;
        }
        .btn-group {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        .save-btn {
            background-color: #9C4DFF;
            color: white;
        }
        .save-btn:hover {
            background-color: #7B2CBF;
        }
        .cancel-btn {
            background-color: #4A3A5C;
            color: #E0C3FC;
        }
        .cancel-btn:hover {
            background-color: #5A4B6C;
        }
    </style>
</head>
<body>
    <div class="personal-container">
        <h2>个人设置</h2>
        
        <form action="${pageContext.request.contextPath}/user/update" method="post">
            <input type="hidden" name="id" value="${user.id}">
            
            <div class="section-title">基本信息</div>
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" value="${user.username}" readonly>
            </div>
            
            <div class="form-group">
                <label for="realName">真实姓名</label>
                <input type="text" id="realName" name="realName" value="${user.realName}">
            </div>
            
            <div class="form-group">
                <label for="email">邮箱</label>
                <input type="email" id="email" name="email" value="${user.email}">
            </div>
            
            <div class="form-group">
                <label for="phone">电话</label>
                <input type="tel" id="phone" name="phone" value="${user.phone}">
            </div>
            
            <div class="section-title">修改密码</div>
            <div class="form-group">
                <label for="currentPassword">当前密码</label>
                <input type="password" id="currentPassword" name="currentPassword">
            </div>
            
            <div class="form-group">
                <label for="newPassword">新密码</label>
                <input type="password" id="newPassword" name="newPassword">
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">确认新密码</label>
                <input type="password" id="confirmPassword" name="confirmPassword">
            </div>
            
            <div class="btn-group">
                <button type="button" class="btn cancel-btn" onclick="location.href='${pageContext.request.contextPath}/index'">取消</button>
                <button type="submit" class="btn save-btn">保存修改</button>
            </div>
        </form>
    </div>

    <script>
        // 表单验证
        document.querySelector('form').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword && newPassword !== confirmPassword) {
                e.preventDefault();
                alert('新密码与确认密码不一致');
                return false;
            }
            
            if (newPassword && !document.getElementById('currentPassword').value) {
                e.preventDefault();
                alert('请输入当前密码');
                return false;
            }
            
            return true;
        });
    </script>
</body>
</html>
