<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>主页 - 销售报表管理系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Arial', sans-serif;
            background-color: #1E0F32;
            color: #E0C3FC;
        }
        .container {
            display: flex;
            min-height: 100vh;
        }
        .sidebar {
            width: 220px;
            background-color: #0F0821;
            padding: 20px 0;
            border-right: 1px solid #5A3D7A;
        }
        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid #5A3D7A;
        }
        .sidebar-header h3 {
            color: #E0C3FC;
            margin-bottom: 10px;
        }
        .sidebar-header p {
            color: #B399D4;
            font-size: 14px;
        }
        .nav-menu {
            margin-top: 20px;
        }
        .nav-item {
            padding: 12px 20px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .nav-item:hover {
            background-color: #3A2A4C;
        }
        .nav-item.active {
            background-color: #9C4DFF;
        }
        .nav-item a {
            color: #E0C3FC;
            text-decoration: none;
            display: block;
        }
        .main-content {
            flex: 1;
            background-color: #1E0F32;
        }
        .top-bar {
            background-color: #2A1A3C;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            border-bottom: 1px solid #5A3D7A;
        }
        .user-info {
            display: flex;
            align-items: center;
        }
        .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            border: 1px solid #5A3D7A;
        }
        .logout-btn {
            background-color: #FF6B6B;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .logout-btn:hover {
            background-color: #E74C3C;
        }
        .content-area {
            padding: 20px;
        }
        .welcome-card {
            background-color: #3A2A4C;
            border-radius: 5px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            text-align: center;
            border: 1px solid #5A3D7A;
        }
        .welcome-card h2 {
            color: #9C4DFF;
            margin-bottom: 15px;
        }
        .welcome-card p {
            color: #B399D4;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 侧边栏 -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="user-info">
                    <img src="https://via.placeholder.com/40" alt="用户头像">
                    <div>
                        <h3>${user.realName}</h3>
                        <p>${user.role == 'admin' ? '管理员' : '普通用户'}</p>
                        <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/user/logout'">退出登录</button>
                    </div>
                </div>
            </div>
            <div class="nav-menu">
                <div class="nav-item" id="home-nav">
                    <a href="javascript:void(0)" onclick="loadContent('home')">首页</a>
                </div>
                <div class="nav-item" id="report-nav">
                    <a href="javascript:void(0)" onclick="loadContent('api/reports/list')">报表管理</a>
                </div>
                <div class="nav-item" id="chart-nav">
                    <a href="javascript:void(0)" onclick="loadContent('chart')">图表展示</a>
                </div>
                <div class="nav-item" id="print-nav">
                    <a href="javascript:void(0)" onclick="loadContent('print')">打印输出</a>
                </div>
                <div class="nav-item" id="setting-nav">
                    <a href="javascript:void(0)" onclick="loadContent('setting')">系统设置</a>
                </div>
                <div class="nav-item" id="personal-nav">
                    <a href="javascript:void(0)" onclick="loadContent('personal')">个人设置</a>
                </div>
                <c:if test="${user.role == 'admin'}">
                    <div class="nav-item" id="account-nav">
                        <a href="javascript:void(0)" onclick="loadContent('user/list')">账户管理</a>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- 主内容区 -->
        <div class="main-content">
            <!-- 内容区 -->
            <div class="content-area" id="content-area">
                <!-- 内容将通过AJAX动态加载 -->
            </div>
        </div>
    </div>

    <script>
        // 默认加载首页
        window.onload = function() {
            loadContent('home');
            document.getElementById('home-nav').classList.add('active');
        };

        // 加载内容函数
        function loadContent(page) {
            try {
                // 重置所有导航项的active类
                document.querySelectorAll('.nav-item').forEach(item => {
                    item.classList.remove('active');
                });
                
                // 为当前导航项添加active类
                const navItem = event.target.closest('.nav-item');
                if (navItem) {
                    navItem.classList.add('active');
                }
                
                // 使用AJAX加载内容
                const xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    if (this.readyState == 4) {
                        if (this.status == 200) {
                            document.getElementById('content-area').innerHTML = this.responseText;
                        } else {
                            console.error('加载内容失败:', this.status, this.statusText);
                            const status = this.status;
                            document.getElementById('content-area').innerHTML = `
                                <div class="error-message">
                                    <h3>加载内容失败</h3>
                                    <p>无法加载请求的页面: ` + page + `</p>
                                    <p>状态码: ` + status + `</p>
                                </div>
                            `;
                        }
                    }
                };
                xhr.onerror = function() {
                    console.error('AJAX请求错误');
                            document.getElementById('content-area').innerHTML = 
                                '<div class="error-message">' +
                                    '<h3>网络错误</h3>' +
                                    '<p>无法连接到服务器</p>' +
                                '</div>';
                };
                xhr.open('GET', '${pageContext.request.contextPath}/' + page, true);
                xhr.send();
            } catch (error) {
                console.error('加载内容时出错:', error);
                const errorMsg = error.message;
                document.getElementById('content-area').innerHTML = 
                    '<div class="error-message">' +
                        '<h3>系统错误</h3>' +
                        '<p>' + errorMsg + '</p>' +
                    '</div>';
            }
        }
    </script>
</body>
</html>
