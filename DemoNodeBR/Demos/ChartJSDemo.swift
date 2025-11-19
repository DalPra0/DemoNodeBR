import Foundation

struct ChartJSDemo {
    static let html = """
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding-bottom: 100px;
        }
        .container {
            background: white;
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            max-width: 600px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
        }
        .chart-container {
            position: relative;
            height: 300px;
            margin-bottom: 20px;
        }
        .controls {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }
        button {
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: bold;
            cursor: pointer;
            font-size: 16px;
        }
        button:active {
            transform: scale(0.95);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Vendas 2024</h1>
        <div class="chart-container">
            <canvas id="myChart"></canvas>
        </div>
        <div class="controls">
            <button onclick="updateData()">Atualizar Dados</button>
            <button onclick="changeType('line')">Linha</button>
            <button onclick="changeType('bar')">Barras</button>
            <button onclick="changeType('doughnut')">Rosca</button>
        </div>
    </div>

    <script>
        let myChart = null;
        
        window.onload = function() {
            setTimeout(function() {
                const canvas = document.getElementById('myChart');
                if (!canvas) {
                    console.error('Canvas not found');
                    return;
                }
                
                const ctx = canvas.getContext('2d');
                
                myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun'],
                        datasets: [{
                            label: 'Vendas 2024',
                            data: [12, 19, 8, 15, 25, 18],
                            backgroundColor: [
                                'rgba(102, 126, 234, 0.8)',
                                'rgba(118, 75, 162, 0.8)',
                                'rgba(237, 100, 166, 0.8)',
                                'rgba(255, 154, 158, 0.8)',
                                'rgba(250, 208, 196, 0.8)',
                                'rgba(161, 196, 253, 0.8)'
                            ],
                            borderColor: [
                                'rgb(102, 126, 234)',
                                'rgb(118, 75, 162)',
                                'rgb(237, 100, 166)',
                                'rgb(255, 154, 158)',
                                'rgb(250, 208, 196)',
                                'rgb(161, 196, 253)'
                            ],
                            borderWidth: 2
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: true,
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top'
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            }, 500);
        };

        function updateData() {
            myChart.data.datasets[0].data = [
                Math.floor(Math.random() * 100) + 20,
                Math.floor(Math.random() * 100) + 20,
                Math.floor(Math.random() * 100) + 20,
                Math.floor(Math.random() * 100) + 20,
                Math.floor(Math.random() * 100) + 20,
                Math.floor(Math.random() * 100) + 20
            ];
            myChart.update();
        }

        function changeType(type) {
            if (myChart) {
                myChart.config.type = type;
                myChart.update();
            }
        }
        
        function handleSwiftMessage(message) {
            console.log('📱 Swift → JS:', message);
            
            if (message === 'updateData') {
                updateData();
                if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                    window.webkit.messageHandlers.swiftHandler.postMessage('Dados atualizados!');
                }
            } else if (message.startsWith('changeType:')) {
                const type = message.split(':')[1];
                changeType(type);
                if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                    window.webkit.messageHandlers.swiftHandler.postMessage('Tipo alterado para ' + type);
                }
            }
        }
    </script>
</body>
</html>
"""
}