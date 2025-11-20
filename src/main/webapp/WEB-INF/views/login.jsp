<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录 - 销售报表管理系统</title>
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
        .login-container {
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
        input[type="password"] {
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
        .register-link {
            text-align: center;
            margin-top: 20px;
        }
        .register-link a {
            color: #9C4DFF;
            text-decoration: none;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>用户登录</h1>
        <% if (request.getParameter("error") != null) { %>
            <div class="error">用户名或密码错误，请重试</div>
        <% } %>
        <% if (request.getParameter("register") != null) { %>
            <div style="color: #2ecc71; margin-bottom: 20px; text-align: center;">注册成功，请登录</div>
        <% } %>
        <form action="${pageContext.request.contextPath}/user/login" method="post">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn">登录</button>
        </form>
        <div class="register-link">
            还没有账号？<a href="${pageContext.request.contextPath}/register">立即注册</a>
        </div>
    </div>
</body>
</html>
