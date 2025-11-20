<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>销售报表管理系统</title>
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
        .welcome-container {
            text-align: center;
            background-color: #2A1A3C;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            width: 400px;
            border: 1px solid #5A3D7A;
        }
        h1 {
            color: #9C4DFF;
            margin-bottom: 30px;
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            margin: 10px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
        }
        .btn-login {
            background-color: #9C4DFF;
            color: white;
        }
        .btn-register {
            background-color: #7B2CBF;
            color: white;
        }
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
    <div class="welcome-container">
        <h1>欢迎使用报表管理系统</h1>
        <p>请登录或注册以继续</p>
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-login">登录</a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-register">注册</a>
        </div>
    </div>
</body>
</html>
