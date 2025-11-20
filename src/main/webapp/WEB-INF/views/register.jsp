<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册 - 销售报表管理系统</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #1E0F32;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #E0C3FC;
        }
        .register-container {
            background-color: #2A1A3C;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            width: 400px;
            border: 1px solid #5A3D7A;
        }
        h1 {
            color: #9C4DFF;
            text-align: center;
            margin-bottom: 30px;
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
            background-color: #3A2A4C;
            border: 1px solid #5A3D7A;
            border-radius: 5px;
            font-size: 16px;
            color: #E0C3FC;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #9C4DFF;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #7B2CBF;
        }
        .error {
            color: #FF6B6B;
            margin-bottom: 20px;
            text-align: center;
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
        }
        .login-link a {
            color: #9C4DFF;
            text-decoration: none;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h1>用户注册</h1>
        <% if (request.getParameter("error") != null) { %>
            <div class="error">用户名已存在，请使用其他用户名</div>
        <% } %>
        <form action="${pageContext.request.contextPath}/user/register" method="post">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">确认密码</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <div class="form-group">
                <label for="realName">真实姓名</label>
                <input type="text" id="realName" name="realName">
            </div>
            <div class="form-group">
                <label for="email">邮箱</label>
                <input type="email" id="email" name="email">
            </div>
            <div class="form-group">
                <label for="phone">电话</label>
                <input type="tel" id="phone" name="phone">
            </div>
            <button type="submit" class="btn">注册</button>
        </form>
        <div class="login-link">
            已有账号？<a href="${pageContext.request.contextPath}/login">立即登录</a>
        </div>
    </div>
</body>
</html>
