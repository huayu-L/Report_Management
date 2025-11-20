<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>首页 - 销售报表管理系统</title>
    <style>
        .chart-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }
        .chart-card {
            flex: 1;
            min-width: 400px;
            background-color: #3A2A4C;
            border-radius: 5px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            border: 1px solid #5A3D7A;
        }
        .chart-title {
            color: #9C4DFF;
            margin-bottom: 15px;
            text-align: center;
        }
        canvas {
            width: 100% !important;
            height: 300px !important;
        }
    </style>
</head>
<body>
    <div class="chart-container">
        <div class="chart-card">
            <h3 class="chart-title">报表类型统计</h3>
            <canvas id="reportTypeChart"></canvas>
        </div>
        <div class="chart-card">
            <h3 class="chart-title">账户统计</h3>
            <canvas id="accountStatChart"></canvas>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/chart.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('DOM fully loaded, initializing charts...');
            
            try {
                // 报表类型统计图数据 (饼图)
                const pieData = {
                    labels: ['销售报表', '财务报表', '库存报表', '运营报表'],
                    datasets: [{
                        data: [35, 25, 20, 20],
                        backgroundColor: [
                            '#9C4DFF',
                            '#7B2CBF',
                            '#B399D4',
                            '#5A3D7A'
                        ],
                        borderWidth: 1
                    }]
                };

                // 账户统计图数据 (柱状图)
                const barData = {
                    labels: ['普通用户', '管理员', '审核员'],
                    datasets: [{
                        label: '用户数量',
                        data: [120, 15, 30],
                        backgroundColor: '#9C4DFF',
                        borderWidth: 1
                    }]
                };

                // 初始化饼图
                const pieCtx = document.getElementById('reportTypeChart');
                if (pieCtx) {
                    console.log('Initializing pie chart...');
                    new Chart(pieCtx.getContext('2d'), {
                        type: 'pie',
                        data: pieData,
                        options: {
                            responsive: true,
                            plugins: {
                                legend: {
                                    position: 'right',
                                    labels: {
                                        color: '#E0C3FC'
                                    }
                                }
                            }
                        }
                    });
                } else {
                    console.error('Pie chart canvas not found');
                }

                // 初始化柱状图
                const barCtx = document.getElementById('accountStatChart');
                if (barCtx) {
                    console.log('Initializing bar chart...');
                    new Chart(barCtx.getContext('2d'), {
                        type: 'bar',
                        data: barData,
                        options: {
                            responsive: true,
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    ticks: {
                                        color: '#E0C3FC'
                                    },
                                    grid: {
                                        color: 'rgba(90, 61, 122, 0.5)'
                                    }
                                },
                                x: {
                                    ticks: {
                                        color: '#E0C3FC'
                                    },
                                    grid: {
                                        color: 'rgba(90, 61, 122, 0.5)'
                                    }
                                }
                            },
                            plugins: {
                                legend: {
                                    labels: {
                                        color: '#E0C3FC'
                                    }
                                }
                            }
                        }
                    });
                } else {
                    console.error('Bar chart canvas not found');
                }
            } catch (error) {
                console.error('Chart initialization error:', error);
            }
        });
    </script>
</body>
</html>
