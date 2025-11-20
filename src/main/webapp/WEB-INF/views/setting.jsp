<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>系统设置 - 销售报表管理系统</title>
    <style>
        .setting-container {
            background-color: #3A2A4C;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            border: 1px solid #5A3D7A;
            color: #E0C3FC;
        }
        .setting-group {
            margin-bottom: 25px;
        }
        .setting-title {
            font-size: 18px;
            color: #9C4DFF;
            margin-bottom: 15px;
            padding-bottom: 5px;
            border-bottom: 1px solid #5A3D7A;
        }
        .color-options {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }
        .color-option {
            width: 50px;
            height: 50px;
            border-radius: 5px;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.3s;
        }
        .color-option:hover {
            transform: scale(1.1);
            box-shadow: 0 0 10px rgba(0,0,0,0.3);
        }
        .color-option.selected {
            border-color: #E0C3FC;
            box-shadow: 0 0 15px rgba(156, 77, 255, 0.5);
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        .setting-select {
            width: 100%;
            padding: 10px;
            background-color: #2A1A3C;
            border: 1px solid #5A3D7A;
            border-radius: 4px;
            color: #E0C3FC;
            margin-bottom: 15px;
        }
        .setting-actions {
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
            transition: all 0.3s;
        }
        .save-btn {
            background-color: #7B2CBF;
            color: white;
        }
        .save-btn:hover {
            background-color: #5A3D7A;
        }
        .reset-btn {
            background-color: #4A3A5C;
            color: #E0C3FC;
        }
        .reset-btn:hover {
            background-color: #5A4B6C;
        }
        .cancel-btn {
            background-color: #E74C3C;
            color: white;
        }
        .cancel-btn:hover {
            background-color: #C0392B;
        }
    </style>
</head>
<body>
    <div class="setting-container">
        <h2>系统设置</h2>
        
        <div class="setting-group">
            <div class="setting-title">主题设置</div>
            <label>主色调</label>
            <div class="color-options">
                <div class="color-option selected" style="background-color: #9C4DFF;" data-color="#9C4DFF"></div>
                <div class="color-option" style="background-color: #7B2CBF;" data-color="#7B2CBF"></div>
                <div class="color-option" style="background-color: #5A3D7A;" data-color="#5A3D7A"></div>
                <div class="color-option" style="background-color: #B399D4;" data-color="#B399D4"></div>
                <div class="color-option" style="background-color: #4A3A5C;" data-color="#4A3A5C"></div>
            </div>
        </div>
        
        <div class="setting-group">
            <div class="setting-title">显示设置</div>
            <label for="pageSize">每页显示数量</label>
            <select id="pageSize" class="setting-select">
                <option value="10">10条</option>
                <option value="20" selected>20条</option>
                <option value="50">50条</option>
                <option value="100">100条</option>
            </select>
            
            <label for="defaultSort">默认排序方式</label>
            <select id="defaultSort" class="setting-select">
                <option value="createTimeDesc">创建时间(最新)</option>
                <option value="createTimeAsc">创建时间(最早)</option>
                <option value="titleAsc">标题(A-Z)</option>
                <option value="titleDesc">标题(Z-A)</option>
            </select>
        </div>
        
        <div class="setting-actions">
            <button class="btn reset-btn">恢复默认</button>
            <button class="btn save-btn">保存设置</button>
            <button class="btn cancel-btn" onclick="location.href='${pageContext.request.contextPath}/index'">取消</button>
        </div>
    </div>

    <script>
        // 颜色选择
        document.querySelectorAll('.color-option').forEach(option => {
            option.addEventListener('click', function() {
                document.querySelectorAll('.color-option').forEach(opt => {
                    opt.classList.remove('selected');
                });
                this.classList.add('selected');
            });
        });

        // 保存设置
        document.querySelector('.save-btn').addEventListener('click', function() {
            const themeColor = document.querySelector('.color-option.selected').dataset.color;
            const pageSize = document.getElementById('pageSize').value;
            const defaultSort = document.getElementById('defaultSort').value;
            
            // 这里应该将设置保存到服务器
            alert('设置已保存');
        });

        // 恢复默认设置
        document.querySelector('.reset-btn').addEventListener('click', function() {
            document.querySelector('.color-option[data-color="#9C4DFF"]').click();
            document.getElementById('pageSize').value = '20';
            document.getElementById('defaultSort').value = 'createTimeDesc';
            alert('已恢复默认设置');
        });
    </script>
</body>
</html>
