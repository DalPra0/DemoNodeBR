import Foundation

struct TensorFlowDemo {
    static let html = """
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@4.11.0/dist/tf.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tensorflow-models/mobilenet@2.1.0"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tensorflow-models/posenet@2.2.2"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            padding: 20px;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
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
            margin-bottom: 10px;
            font-size: 28px;
        }
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 14px;
        }
        .section {
            margin-bottom: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 15px;
        }
        .section-title {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
        }
        .upload-label {
            display: block;
            width: 100%;
            padding: 15px;
            border: 2px dashed #ddd;
            border-radius: 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
            color: #666;
            font-weight: 600;
        }
        .upload-label:hover {
            border-color: #f5576c;
            color: #f5576c;
        }
        input[type="file"] {
            display: none;
        }
        #preview {
            max-width: 100%;
            border-radius: 10px;
            margin: 15px 0;
            display: none;
        }
        .result {
            margin-top: 15px;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            color: white;
            display: none;
        }
        .result.show {
            display: block;
        }
        .prediction-item {
            padding: 10px 0;
            border-bottom: 1px solid rgba(255,255,255,0.2);
            font-size: 16px;
        }
        .prediction-item:last-child {
            border-bottom: none;
        }
        .probability {
            float: right;
            font-weight: bold;
        }
        canvas {
            width: 100%;
            border-radius: 10px;
            background: white;
            margin-top: 10px;
        }
        button {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        button:active {
            transform: scale(0.95);
        }
        button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        .status {
            text-align: center;
            padding: 15px;
            background: #fff3cd;
            border-radius: 10px;
            color: #856404;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .status.success {
            background: #d4edda;
            color: #155724;
        }
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(0,0,0,0.1);
            border-radius: 50%;
            border-top-color: #f5576c;
            animation: spin 1s ease-in-out infinite;
        }
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        .info {
            background: #e3f2fd;
            padding: 12px;
            border-radius: 8px;
            font-size: 13px;
            color: #1976d2;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>TensorFlow.js</h1>
        <p class="subtitle">Machine Learning rodando no navegador</p>
        
        <div id="modelStatus" class="status">
            <span class="loading"></span> Carregando MobileNet...
        </div>
        
        <div class="section">
            <div class="section-title">Reconhecimento de Imagem</div>
            <label for="imageUpload" class="upload-label" id="uploadLabel">
                Escolher Foto
            </label>
            <input type="file" id="imageUpload" accept="image/*" disabled>
            <img id="preview">
            <div class="result" id="imageResult"></div>
            <div class="info">
                MobileNet é uma rede neural treinada com milhões de imagens. 
                Consegue identificar 1000+ objetos diferentes!
            </div>
        </div>
        
        <div class="section">
            <div class="section-title">Regressão Linear ao Vivo</div>
            <canvas id="regressionCanvas" width="500" height="300"></canvas>
            <button onclick="trainRegression()">Treinar Modelo</button>
            <div class="info" id="regressionInfo">
                Treinamento de rede neural para aprender a função y = 2x
            </div>
        </div>
        
        <div class="section">
            <div class="section-title">Operações com Tensores</div>
            <canvas id="tensorCanvas" width="500" height="300"></canvas>
            <button onclick="runTensorOps()">Executar Operações</button>
            <div class="info" id="tensorInfo">
                Multiplicação de matrizes usando GPU
            </div>
        </div>
    </div>

    <script>
        let mobilenet_model;
        let modelLoaded = false;
        
        async function loadMobileNet() {
            try {
                mobilenet_model = await mobilenet.load();
                modelLoaded = true;
                document.getElementById('modelStatus').innerHTML = 'Modelo carregado com sucesso!';
                document.getElementById('modelStatus').classList.add('success');
                document.getElementById('imageUpload').disabled = false;
                document.getElementById('uploadLabel').textContent = 'Escolher Foto';
            } catch (error) {
                console.error('Erro:', error);
                document.getElementById('modelStatus').innerHTML = 'Erro ao carregar modelo';
                document.getElementById('modelStatus').style.background = '#f8d7da';
                document.getElementById('modelStatus').style.color = '#721c24';
            }
        }
        
        document.getElementById('imageUpload').addEventListener('change', async function(e) {
            const file = e.target.files[0];
            if (!file) return;
            
            const img = document.getElementById('preview');
            img.src = URL.createObjectURL(file);
            img.style.display = 'block';
            
            img.onload = async function() {
                document.getElementById('imageResult').innerHTML = '<div style="text-align:center"><span class="loading"></span> Analisando imagem...</div>';
                document.getElementById('imageResult').classList.add('show');
                
                try {
                    const predictions = await mobilenet_model.classify(img);
                    
                    let html = '<strong>Top 3 Previsões:</strong><br><br>';
                    predictions.slice(0, 3).forEach((pred, i) => {
                        const className = pred.className.split(',')[0];
                        html += `<div class="prediction-item">
                            ${i + 1}. ${className}
                            <span class="probability">${(pred.probability * 100).toFixed(1)}%</span>
                        </div>`;
                    });
                    
                    document.getElementById('imageResult').innerHTML = html;
                } catch (error) {
                    document.getElementById('imageResult').innerHTML = 'Erro ao classificar imagem';
                }
            };
        });
        
        async function trainRegression() {
            const canvas = document.getElementById('regressionCanvas');
            const ctx = canvas.getContext('2d');
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            
            document.getElementById('regressionInfo').textContent = 'Preparando dados...';
            
            const xs_data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
            const ys_data = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20];
            
            const scaleX = canvas.width / 12;
            const scaleY = canvas.height / 25;
            
            ctx.fillStyle = '#f8f9fa';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            ctx.fillStyle = '#667eea';
            xs_data.forEach((x, i) => {
                const px = x * scaleX;
                const py = canvas.height - ys_data[i] * scaleY;
                ctx.beginPath();
                ctx.arc(px, py, 8, 0, 2 * Math.PI);
                ctx.fill();
            });
            
            const xs = tf.tensor2d(xs_data, [10, 1]);
            const ys = tf.tensor2d(ys_data, [10, 1]);
            
            const model = tf.sequential();
            model.add(tf.layers.dense({ units: 8, activation: 'relu', inputShape: [1] }));
            model.add(tf.layers.dense({ units: 1 }));
            model.compile({ optimizer: tf.train.adam(0.1), loss: 'meanSquaredError' });
            
            await model.fit(xs, ys, {
                epochs: 100,
                callbacks: {
                    onEpochEnd: (epoch, logs) => {
                        if (epoch % 20 === 0) {
                            document.getElementById('regressionInfo').textContent = 
                                `Epoch ${epoch}/100 - Loss: ${logs.loss.toFixed(4)}`;
                        }
                    }
                }
            });
            
            const predictions = model.predict(xs);
            const predArray = await predictions.array();
            
            ctx.strokeStyle = '#f5576c';
            ctx.lineWidth = 4;
            ctx.beginPath();
            predArray.forEach((pred, i) => {
                const px = xs_data[i] * scaleX;
                const py = canvas.height - pred[0] * scaleY;
                if (i === 0) ctx.moveTo(px, py);
                else ctx.lineTo(px, py);
            });
            ctx.stroke();
            
            ctx.fillStyle = '#333';
            ctx.font = 'bold 16px -apple-system';
            ctx.fillText('Dados reais (pontos)', 20, 30);
            ctx.fillText('Predição do modelo (linha)', 20, 55);
            
            document.getElementById('regressionInfo').textContent = 
                'Modelo treinado! Aprendeu a função y = 2x com sucesso';
            
            xs.dispose();
            ys.dispose();
            predictions.dispose();
            model.dispose();
        }
        
        function runTensorOps() {
            const canvas = document.getElementById('tensorCanvas');
            const ctx = canvas.getContext('2d');
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            
            const a = tf.tensor2d([[5, 3], [2, 4]], [2, 2]);
            const b = tf.tensor2d([[1, 2], [3, 1]], [2, 2]);
            
            const sum = tf.add(a, b);
            const product = tf.matMul(a, b);
            
            const sumArray = sum.arraySync();
            const productArray = product.arraySync();
            
            ctx.fillStyle = '#f8f9fa';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            ctx.fillStyle = '#333';
            ctx.font = 'bold 18px -apple-system';
            ctx.fillText('Operações com Tensores (GPU)', 20, 30);
            
            ctx.font = '16px -apple-system';
            ctx.fillText('Matriz A:', 20, 70);
            ctx.fillText('[[5, 3], [2, 4]]', 120, 70);
            
            ctx.fillText('Matriz B:', 20, 100);
            ctx.fillText('[[1, 2], [3, 1]]', 120, 100);
            
            ctx.font = 'bold 16px -apple-system';
            ctx.fillText('A + B =', 20, 150);
            drawMatrix(ctx, sumArray, 120, 135, '#4facfe');
            
            ctx.fillText('A × B =', 20, 230);
            drawMatrix(ctx, productArray, 120, 215, '#f5576c');
            
            document.getElementById('tensorInfo').textContent = 
                `Operações executadas na GPU em ${tf.getBackend()} backend`;
            
            a.dispose();
            b.dispose();
            sum.dispose();
            product.dispose();
        }
        
        function drawMatrix(ctx, matrix, x, y, color) {
            const size = 35;
            const gap = 5;
            
            matrix.forEach((row, i) => {
                row.forEach((val, j) => {
                    const px = x + j * (size + gap);
                    const py = y + i * (size + gap);
                    
                    ctx.fillStyle = color;
                    ctx.fillRect(px, py, size, size);
                    
                    ctx.fillStyle = 'white';
                    ctx.font = 'bold 16px -apple-system';
                    ctx.textAlign = 'center';
                    ctx.fillText(val, px + size/2, py + size/2 + 5);
                });
            });
        }
        
        window.onload = function() {
            loadMobileNet();
        };
        
        function handleSwiftMessage(message) {
            console.log('📱 Swift → JS:', message);
            
            if (message === 'trainRegression') {
                trainRegression();
                if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                    window.webkit.messageHandlers.swiftHandler.postMessage('Treinamento iniciado!');
                }
            } else if (message === 'runTensorOps') {
                runTensorOps();
                if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                    window.webkit.messageHandlers.swiftHandler.postMessage('Operações executadas!');
                }
            }
        }
    </script>
</body>
</html>
"""
}
