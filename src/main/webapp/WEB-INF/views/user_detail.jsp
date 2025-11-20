<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${empty user.id ? '新增' : '编辑'}用户 - 销售报表管理系统</title>
    <style>
        .form-container {
            margin-top: 20px;
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
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
        input[type="tel"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        .btn-group {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 30px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        .save-btn {
            background-color: #2ecc71;
            color: white;
        }
        .cancel-btn {
            background-color: #95a5a6;
            color: white;
        }
    </style>
</head>
<body>
    <!-- 继承index.jsp的布局 -->
    <jsp:include page="index.jsp"/>

    <!-- 主内容区 -->
    <div class="content-area">
        <div class="form-container">
            <h2>${empty user.id ? '新增用户' : '编辑用户'}</h2>
            <form action="${pageContext.request.contextPath}/user/${empty user.id ? 'create' : 'update'}" method="post">
                <input type="hidden" name="id" value="${user.id}">
                
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input type="text" id="username" name="username" value="${user.username}" ${empty user.id ? '' : 'readonly'} required>
                </div>
                
                <c:if test="${empty user.id}">
                    <div class="form-group">
                        <label for="password">密码</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="confirmPassword">确认密码</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                    </div>
                </c:if>
                
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
                
                <div class="form-group">
                    <label for="role">角色</label>
                    <select id="role" name="role" required>
                        <option value="user" ${user.role == 'user' ? 'selected' : ''}>普通用户</option>
                        <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>管理员</option>
                    </select>
                </div>
                
                <div class="btn-group">
                    <button type="button" class="btn cancel-btn" onclick="location.href='${pageContext.request.contextPath}/user/list'">取消</button>
                    <button type="submit" class="btn save-btn">保存</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // 表单验证
        document.querySelector('form').addEventListener('submit', function(e) {
            if (document.getElementById('password') && 
                document.getElementById('password').value !== document.getElementById('confirmPassword').value) {
                e.preventDefault();
                alert('密码与确认密码不一致');
                return false;
            }
            return true;
        });
    </script>
</body>
</html>
