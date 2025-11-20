<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>打印输出 - 销售报表管理系统</title>
    <style>
        .print-container {
            background-color: #3A2A4C;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            border: 1px solid #5A3D7A;
            color: #E0C3FC;
        }
        .print-controls {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        .file-selector, .print-settings {
            flex: 1;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        .print-select, .print-input {
            width: 100%;
            padding: 10px;
            background-color: #2A1A3C;
            border: 1px solid #5A3D7A;
            border-radius: 4px;
            color: #E0C3FC;
            margin-bottom: 15px;
        }
        .preview-area {
            border: 1px dashed #5A3D7A;
            padding: 20px;
            min-height: 300px;
            margin-bottom: 20px;
            background-color: #2A1A3C;
        }
        .print-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        .print-btn {
            background-color: #9C4DFF;
            color: white;
        }
        .print-btn:hover {
            background-color: #7B2CBF;
        }
        .preview-btn {
            background-color: #7B2CBF;
            color: white;
        }
        .preview-btn:hover {
            background-color: #5A3D7A;
        }
        .cancel-btn {
            background-color: #4A3A5C;
            color: #E0C3FC;
        }
        .cancel-btn:hover {
            background-color: #5A4B6C;
        }
        
        @media print {
            body * {
                visibility: hidden;
            }
            .print-container, .print-container * {
                visibility: visible;
            }
            .print-container {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                background-color: white;
                color: black;
            }
            .print-actions {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="print-container">
        <h2>打印输出</h2>

        <div class="print-controls">
            <div class="file-selector">
                <label for="fileSelect">选择报表文件</label>
                <select id="fileSelect" class="print-select">
                    <option value="">请选择报表文件</option>
                    <c:forEach items="${reports}" var="report">
                        <option value="${report.id}">${report.title}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="print-settings">
                <label for="orientation">页面方向</label>
                <select id="orientation" class="print-select">
                    <option value="portrait">纵向</option>
                    <option value="landscape">横向</option>
                </select>

                <label for="copies">打印份数</label>
                <input type="number" id="copies" class="print-input" min="1" value="1">
            </div>
        </div>

        <div class="preview-area" id="previewArea">
            <p style="text-align: center; color: #B399D4;">选择报表文件后，这里将显示打印预览</p>
        </div>

        <div class="print-actions">
            <button class="btn preview-btn">刷新预览</button>
            <button class="btn print-btn">打印</button>
            <button class="btn cancel-btn" onclick="location.href='${pageContext.request.contextPath}/index'">取消</button>
        </div>
    </div>

    <script>
        // 监听文件选择变化
        document.getElementById('fileSelect').addEventListener('change', function() {
            const fileId = this.value;
            if (fileId) {
                // 这里应该根据选择的文件ID加载预览内容
                // 使用JSTL c:forEach代替JavaScript的find方法
                <c:forEach items="${reports}" var="report">
                    if (fileId == ${report.id}) {
                        document.getElementById('previewArea').innerHTML = `
                            <h3 style="text-align: center; color: #E0C3FC;">${report.title}</h3>
                            <p style="text-align: center; color: #B399D4;">这里是${report.title}的打印预览内容</p>
                        `;
                    }
                </c:forEach>
            } else {
                document.getElementById('previewArea').innerHTML = `
                    <p style="text-align: center; color: #B399D4;">选择报表文件后，这里将显示打印预览</p>
                `;
            }
        });

        // 打印按钮点击事件
        document.querySelector('.print-btn').addEventListener('click', function() {
            window.print();
        });

        // 预览按钮点击事件
        document.querySelector('.preview-btn').addEventListener('click', function() {
            const fileId = document.getElementById('fileSelect').value;
            if (fileId) {
                alert('已刷新预览内容');
            } else {
                alert('请先选择报表文件');
            }
        });
    </script>
</body>
</html>
