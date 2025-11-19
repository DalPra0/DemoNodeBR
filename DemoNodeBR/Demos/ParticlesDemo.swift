import Foundation

struct ParticlesDemo {
    static let html = """
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            overflow: hidden;
        }
        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .content {
            position: relative;
            z-index: 10;
            color: white;
            text-align: center;
            padding: 40px 20px;
        }
        h1 {
            font-size: 32px;
            margin-bottom: 10px;
            text-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }
        .subtitle {
            font-size: 18px;
            opacity: 0.9;
            margin-bottom: 40px;
        }
        .controls {
            display: flex;
            flex-direction: column;
            gap: 15px;
            max-width: 400px;
            margin: 0 auto;
        }
        .control-group {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 20px;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
        }
        input[type="range"] {
            width: 100%;
            height: 40px;
        }
        select {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: none;
            font-size: 16px;
            background: white;
        }
        .preset-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-top: 20px;
        }
        button {
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }
        button:active {
            transform: scale(0.95);
            background: rgba(255, 255, 255, 0.3);
        }
    </style>
</head>
<body>
    <div id="particles-js"></div>
    
    <div class="content">
        <h1>Particles.js</h1>
        <p class="subtitle">Efeitos de partículas interativos</p>
        
        <div class="controls">
            <div class="control-group">
                <label>Número de Partículas: <span id="countValue">80</span></label>
                <input type="range" id="particleCount" min="10" max="200" value="80" oninput="updateCount()">
            </div>
            
            <div class="control-group">
                <label>Velocidade: <span id="speedValue">3</span></label>
                <input type="range" id="speed" min="1" max="10" value="3" oninput="updateSpeed()">
            </div>
            
            <div class="control-group">
                <label>Formato</label>
                <select id="shape" onchange="updateShape()">
                    <option value="circle">Círculo</option>
                    <option value="edge">Triângulo</option>
                    <option value="triangle">Triângulo 2</option>
                    <option value="polygon">Polígono</option>
                    <option value="star">Estrela</option>
                </select>
            </div>
            
            <div class="preset-buttons">
                <button onclick="preset('snow')">Neve</button>
                <button onclick="preset('nasa')">NASA</button>
                <button onclick="preset('bubble')">Bolhas</button>
                <button onclick="preset('confetti')">Confete</button>
            </div>
        </div>
    </div>

    <script>
        let currentConfig = {
            particles: {
                number: { value: 80 },
                color: { value: "#ffffff" },
                shape: {
                    type: "circle"
                },
                opacity: {
                    value: 0.5,
                    random: false
                },
                size: {
                    value: 3,
                    random: true
                },
                line_linked: {
                    enable: true,
                    distance: 150,
                    color: "#ffffff",
                    opacity: 0.4,
                    width: 1
                },
                move: {
                    enable: true,
                    speed: 3,
                    direction: "none",
                    random: false,
                    straight: false,
                    out_mode: "out",
                    bounce: false
                }
            },
            interactivity: {
                detect_on: "canvas",
                events: {
                    onhover: {
                        enable: true,
                        mode: "grab"
                    },
                    onclick: {
                        enable: true,
                        mode: "push"
                    },
                    resize: true
                },
                modes: {
                    grab: {
                        distance: 140,
                        line_linked: { opacity: 1 }
                    },
                    push: { particles_nb: 4 }
                }
            },
            retina_detect: true
        };

        particlesJS('particles-js', currentConfig);

        function updateCount() {
            const value = document.getElementById('particleCount').value;
            document.getElementById('countValue').textContent = value;
            currentConfig.particles.number.value = parseInt(value);
            particlesJS('particles-js', currentConfig);
        }

        function updateSpeed() {
            const value = document.getElementById('speed').value;
            document.getElementById('speedValue').textContent = value;
            currentConfig.particles.move.speed = parseInt(value);
            particlesJS('particles-js', currentConfig);
        }

        function updateShape() {
            const value = document.getElementById('shape').value;
            currentConfig.particles.shape.type = value;
            particlesJS('particles-js', currentConfig);
        }

        function preset(type) {
            if (type === 'snow') {
                currentConfig.particles.number.value = 100;
                currentConfig.particles.color.value = "#ffffff";
                currentConfig.particles.shape.type = "circle";
                currentConfig.particles.size.value = 5;
                currentConfig.particles.move.speed = 1;
                currentConfig.particles.move.direction = "bottom";
                currentConfig.particles.line_linked.enable = false;
            } else if (type === 'nasa') {
                currentConfig.particles.number.value = 160;
                currentConfig.particles.color.value = "#ffffff";
                currentConfig.particles.shape.type = "circle";
                currentConfig.particles.size.value = 2;
                currentConfig.particles.move.speed = 0.5;
                currentConfig.particles.line_linked.enable = false;
                currentConfig.particles.opacity.value = 0.8;
            } else if (type === 'bubble') {
                currentConfig.particles.number.value = 40;
                currentConfig.particles.color.value = "#ffffff";
                currentConfig.particles.shape.type = "circle";
                currentConfig.particles.size.value = 10;
                currentConfig.particles.move.speed = 2;
                currentConfig.particles.move.direction = "top";
                currentConfig.particles.line_linked.enable = false;
            } else if (type === 'confetti') {
                currentConfig.particles.number.value = 120;
                currentConfig.particles.color.value = ["#ff0000", "#00ff00", "#0000ff", "#ffff00", "#ff00ff"];
                currentConfig.particles.shape.type = "polygon";
                currentConfig.particles.size.value = 8;
                currentConfig.particles.move.speed = 5;
                currentConfig.particles.move.direction = "bottom";
                currentConfig.particles.line_linked.enable = false;
            }
            particlesJS('particles-js', currentConfig);
        }
        
        function handleSwiftMessage(message) {
            console.log('📱 Swift → JS:', message);
            
            if (message.startsWith('changeStyle:')) {
                const style = message.split(':')[1];
                
                if (style === 'snow') {
                    changeStyle('snow');
                    if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                        window.webkit.messageHandlers.swiftHandler.postMessage('Estilo Snow ativado! ❄️');
                    }
                } else if (style === 'stars') {
                    changeStyle('stars');
                    if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                        window.webkit.messageHandlers.swiftHandler.postMessage('Estilo Stars ativado! 🌟');
                    }
                } else if (style === 'bubbles') {
                    changeStyle('bubbles');
                    if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                        window.webkit.messageHandlers.swiftHandler.postMessage('Estilo Bubbles ativado! 🔴');
                    }
                }
            }
        }
    </script>
</body>
</html>
"""
}
