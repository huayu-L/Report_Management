<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>图表展示 - 销售报表管理系统</title>
    <style>
        .chart-controls {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            background-color: #3A2A4C;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            border: 1px solid #5A3D7A;
        }
        .control-group {
            flex: 1;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #E0C3FC;
        }
        .chart-select {
            width: 100%;
            padding: 10px;
            background-color: #2A1A3C;
            border: 1px solid #5A3D7A;
            border-radius: 4px;
            color: #E0C3FC;
        }
        .chart-container {
            background-color: #3A2A4C;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            margin-bottom: 20px;
            border: 1px solid #5A3D7A;
        }
        .chart-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-bottom: 15px;
        }
        .btn {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        .export-btn {
            background-color: #7B2CBF;
            color: white;
        }
        .export-btn:hover {
            background-color: #5A3D7A;
        }
        .refresh-btn {
            background-color: #9C4DFF;
            color: white;
        }
        .refresh-btn:hover {
            background-color: #7B2CBF;
        }
        canvas {
            width: 100% !important;
            height: 400px !important;
        }
    </style>
</head>
<body>
    <div class="chart-controls">
        <div class="control-group">
            <label for="reportSelect">选择报表</label>
            <select id="reportSelect" class="chart-select">
                <option value="">请选择报表</option>
                <c:forEach items="${reports}" var="report">
                    <option value="${report.id}">${report.title}</option>
                </c:forEach>
            </select>
        </div>
        <div class="control-group">
            <label for="chartType">图表类型</label>
            <select id="chartType" class="chart-select">
                <option value="bar">柱状图</option>
                <option value="line">折线图</option>
                <option value="pie">饼图</option>
                <option value="doughnut">环形图</option>
            </select>
        </div>
    </div>

    <div class="chart-container">
        <div class="chart-actions">
            <button class="btn refresh-btn">刷新数据</button>
            <button class="btn export-btn">导出数据</button>
        </div>
        <canvas id="dataChart"></canvas>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // 初始化图表
        const ctx = document.getElementById('dataChart').getContext('2d');
        let chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['一月', '二月', '三月', '四月', '五月', '六月'],
                datasets: [{
                    label: '销售额',
                    data: [12, 19, 3, 5, 2, 3],
                    backgroundColor: '#9C4DFF',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        labels: {
                            color: '#E0C3FC'
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            color: '#E0C3FC'
                        },
                        grid: {
                            color: '#5A3D7A'
                        }
                    },
                    x: {
                        ticks: {
                            color: '#E0C3FC'
                        },
                        grid: {
                            color: '#5A3D7A'
                        }
                    }
                }
            }
        });

        // 监听报表选择变化
        document.getElementById('reportSelect').addEventListener('change', function() {
            // 这里应该根据选择的报表ID加载数据
            console.log('选择的报表ID:', this.value);
            // 实际项目中应该通过AJAX加载数据
        });

        // 监听图表类型变化
        document.getElementById('chartType').addEventListener('change', function() {
            chart.destroy();
            chart = new Chart(ctx, {
                type: this.value,
                data: chart.data,
                options: chart.options
            });
        });

        // 刷新数据按钮
        document.querySelector('.refresh-btn').addEventListener('click', function() {
            // 这里应该重新加载数据
            console.log('刷新数据');
        });

        // 导出数据按钮
        document.querySelector('.export-btn').addEventListener('click', function() {
            // 这里应该实现数据导出功能
            console.log('导出数据');
        });
    </script>
</body>
</html>
