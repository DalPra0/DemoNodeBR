import Foundation

struct LottieDemo {
    static let html = """
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bodymovin/5.12.2/lottie.min.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, sans-serif;
            padding: 20px;
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            min-height: 100vh;
            padding-bottom: 100px;
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
        #lottie {
            width: 100%;
            height: 400px;
            margin-bottom: 20px;
            background: #f8f9fa;
            border-radius: 15px;
        }
        .status {
            padding: 10px;
            background: #d4edda;
            color: #155724;
            border-radius: 8px;
            margin-bottom: 15px;
            font-weight: 600;
        }
        .info {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 10px;
            color: #1976d2;
            font-size: 14px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Lottie Animation</h1>
        <p class="subtitle">Swift controla JavaScript</p>
        <div class="status" id="status">Carregando...</div>
        <div id="lottie"></div>
        <div class="info">Use os controles do Swift acima para controlar a animação!</div>
    </div>

    <script>
        let animation = null;
        
        function loadAnimation() {
            try {
                animation = lottie.loadAnimation({
                    container: document.getElementById('lottie'),
                    renderer: 'svg',
                    loop: true,
                    autoplay: true,
                    path: 'https://lottie.host/4db68bbd-31f6-4cd8-b6f9-2a5b7f7c3e1a/kTp04RPDMB.json'
                });
                
                animation.addEventListener('DOMLoaded', function() {
                    document.getElementById('status').textContent = 'Pronto! Use os botões do Swift';
                });
            } catch(error) {
                document.getElementById('status').textContent = 'Erro ao carregar';
                document.getElementById('status').style.background = '#f8d7da';
            }
        }
        
        function handleSwiftMessage(message) {
            console.log('Swift → JS:', message);
            
            if (message === 'play' && animation) {
                animation.play();
                document.getElementById('status').textContent = 'Reproduzindo...';
                if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                    window.webkit.messageHandlers.swiftHandler.postMessage('Playing');
                }
            } else if (message === 'pause' && animation) {
                animation.pause();
                document.getElementById('status').textContent = 'Pausado';
                if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                    window.webkit.messageHandlers.swiftHandler.postMessage('Paused');
                }
            } else if (message === 'stop' && animation) {
                animation.stop();
                document.getElementById('status').textContent = 'Parado';
                if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                    window.webkit.messageHandlers.swiftHandler.postMessage('Stopped');
                }
            } else if (message === 'reverse' && animation) {
                animation.setDirection(animation.playDirection * -1);
                animation.play();
                document.getElementById('status').textContent = 'Reverso!';
                if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                    window.webkit.messageHandlers.swiftHandler.postMessage('Reversed');
                }
            }
        }
        
        window.onload = function() {
            setTimeout(loadAnimation, 500);
        };
    </script>
</body>
</html>
"""
}
