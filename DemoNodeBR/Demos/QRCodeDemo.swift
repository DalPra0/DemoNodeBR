import Foundation

struct QRCodeDemo {
    static let html = """
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, sans-serif;
            padding: 20px;
            background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            min-height: 100vh;
        }
        .container {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            max-width: 500px;
            margin: 0 auto;
            text-align: center;
        }
        h1 { color: #333; margin-bottom: 10px; font-size: 28px; }
        .subtitle { color: #666; margin-bottom: 30px; font-size: 14px; }
        #qrcode {
            display: inline-block;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 15px;
            margin-bottom: 20px;
            min-height: 296px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .info {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 10px;
            color: #1976d2;
            font-size: 14px;
            margin-top: 20px;
        }
        .status {
            padding: 10px;
            background: #d4edda;
            color: #155724;
            border-radius: 8px;
            margin-bottom: 15px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>QR Code Generator</h1>
        <p class="subtitle">Swift envia dados para JavaScript</p>
        <div class="status" id="status">Digite algo acima e clique em Gerar QR</div>
        <div id="qrcode"></div>
        <div class="info">
            Swift UI → JavaScript → QR Code gerado → callback Swift
            <br><br>
            <strong>Interação completa entre Swift e JavaScript!</strong>
        </div>
    </div>

    <script>
        let qrcode = null;
        
        function handleSwiftMessage(message) {
            console.log('Swift → JS:', message);
            
            const container = document.getElementById('qrcode');
            container.innerHTML = '';
            
            qrcode = new QRCode(container, {
                text: message,
                width: 256,
                height: 256,
                colorDark: '#000000',
                colorLight: '#ffffff',
                correctLevel: QRCode.CorrectLevel.H
            });
            
            document.getElementById('status').textContent = 'QR Code gerado: ' + message;
            
            if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                window.webkit.messageHandlers.swiftHandler.postMessage('QR gerado: ' + message);
            }
        }
        
        window.onload = function() {
            handleSwiftMessage('https://github.com/DalPra0');
        };
    </script>
</body>
</html>
"""
}
