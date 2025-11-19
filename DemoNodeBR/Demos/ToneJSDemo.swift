import Foundation

struct ToneJSDemo {
    static let html = """
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/tone@14.8.49/build/Tone.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            padding: 20px;
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            min-height: 100vh;
            padding-bottom: 100px;
        }
        .container {
            background: white;
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            max-width: 500px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
        }
        .synth-controls {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin-bottom: 20px;
        }
        .key {
            aspect-ratio: 1;
            border: none;
            border-radius: 15px;
            font-size: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: bold;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .key:active {
            transform: scale(0.9);
        }
        button {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            font-weight: bold;
            font-size: 16px;
            margin-top: 10px;
        }
        button:active {
            transform: scale(0.95);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Sintetizador</h1>
        
        <div class="synth-controls">
            <button class="key" onclick="playNote('C4')">C</button>
            <button class="key" onclick="playNote('D4')">D</button>
            <button class="key" onclick="playNote('E4')">E</button>
            <button class="key" onclick="playNote('F4')">F</button>
            <button class="key" onclick="playNote('G4')">G</button>
            <button class="key" onclick="playNote('A4')">A</button>
            <button class="key" onclick="playNote('B4')">B</button>
            <button class="key" onclick="playNote('C5')">C5</button>
        </div>
        
        <button onclick="playSequence()">Tocar Sequência</button>
    </div>

    <script>
        const synth = new Tone.Synth().toDestination();
        let started = false;
        
        async function playNote(note) {
            if (!started) {
                await Tone.start();
                started = true;
            }
            synth.triggerAttackRelease(note, '8n');
        }
        
        function playSequence() {
            if (!synth) {
                alert('Clique em Tocar Nota primeiro para ativar o áudio');
                return;
            }
            
            const now = Tone.now();
            synth.triggerAttackRelease('C4', '8n', now);
            synth.triggerAttackRelease('E4', '8n', now + 0.5);
            synth.triggerAttackRelease('G4', '8n', now + 1);
            synth.triggerAttackRelease('C5', '8n', now + 1.5);
        }
        
        function handleSwiftMessage(message) {
            console.log('📱 Swift → JS:', message);
            
            if (message.startsWith('playNote:')) {
                const note = message.split(':')[1];
                playNote(note);
                if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                    window.webkit.messageHandlers.swiftHandler.postMessage('Nota ' + note + ' tocada!');
                }
            } else if (message === 'playSequence') {
                playSequence();
                if (window.webkit && window.webkit.messageHandlers.swiftHandler) {
                    window.webkit.messageHandlers.swiftHandler.postMessage('Sequência tocada!');
                }
            }
        }
    </script>
</body>
</html>
"""
}
