# 🚀 DemoNodeBR - JavaScript além do Node.js

App demo para palestra mostrando a integração de bibliotecas JavaScript em aplicações Swift nativas usando WebKit.

## 📱 Demos Incluídas

### 1. 📊 Chart.js
- Gráficos interativos e animados
- Troca entre tipos: barras, linhas, rosca
- Atualização de dados em tempo real
- **Demo**: Visualização de vendas 2024

### 2. 🧠 TensorFlow.js
- Machine Learning no navegador
- Modelo treinado em tempo real
- **Demo**: Preditor de preço de casas baseado em área e quartos

### 3. 🎹 Tone.js
- Síntese de áudio e música
- Sintetizador interativo com 8 notas
- Controles de forma de onda e volume
- Sequenciador automático
- **Demo**: Mini sintetizador musical

### 4. 🌐 D3.js
- Visualizações de dados poderosas
- Gráfico de rede interativo com física
- Arraste os nós
- Adicione novos nós dinamicamente
- **Demo**: Rede de tecnologias

### 5. ✨ Particles.js
- Efeitos de partículas animadas
- 4 presets: neve, nasa, bolhas, confete
- Controles de quantidade, velocidade e formato
- Interação com mouse
- **Demo**: Sistema de partículas configurável

### 6. 🎬 Lottie-web
- Animações vetoriais complexas do After Effects
- 4 animações diferentes
- Controles de play/pause/stop
- Ajuste de velocidade
- **Demo**: Player de animações Lottie

### 7. 📱 QRCode.js
- Gerador de QR codes instantâneo
- 3 tamanhos disponíveis
- Presets: WhatsApp, Email, WiFi, URL
- Atualização em tempo real
- **Demo**: Gerador interativo de QR codes

## 🛠️ Como Usar na Palestra

### Antes de Começar
1. Abra o projeto no Xcode
2. Selecione um simulador ou dispositivo físico
3. Build e rode o app (⌘ + R)

### Durante a Demo
1. **Tela inicial**: Mostra lista com as 7 bibliotecas
2. **Toque em qualquer item**: Abre o mini-app correspondente
3. **Interaja**: Todos os exemplos são totalmente interativos
4. **Volte**: Use o botão de voltar para escolher outro exemplo

### Ordem Sugerida para Apresentação
1. **Chart.js** - Começa simples, visual impressionante
2. **QRCode.js** - Útil, prático, gera QR ao vivo
3. **Particles.js** - Efeito "wow", muito visual
4. **Tone.js** - Interativo, pessoal vai gostar do áudio
5. **TensorFlow.js** - Machine Learning, mostra poder
6. **D3.js** - Complexidade, visualização avançada
7. **Lottie-web** - Animações profissionais

### Dicas para a Palestra
- **Chart.js**: Mostre mudança de tipo (barras → linha → rosca)
- **QRCode.js**: Gere um QR com o link da palestra ao vivo
- **Particles.js**: Use os presets (neve é sempre sucesso!)
- **Tone.js**: Toque a sequência automática
- **TensorFlow.js**: Mude os valores para mostrar predição
- **D3.js**: Arraste os nós, adicione novos
- **Lottie**: Mostre diferentes animações e velocidades

## 🎯 Principais Pontos a Destacar

1. **WebKit como Ponte**: Todo código JS roda no WKWebView
2. **CDNs**: Bibliotecas carregadas via CDN (sem instalação)
3. **Interatividade**: JS manipula DOM, Swift gerencia navegação
4. **Performance**: Tudo roda nativamente no dispositivo
5. **Facilidade**: Sem frameworks complexos, apenas HTML + JS

## 🔧 Estrutura do Código

```
DemoNodeBR/
├── Models/
│   └── JSLibrary.swift          # Enum com as 7 bibliotecas
├── Views/
│   ├── JSWebView.swift          # WebView wrapper
│   └── LibraryDemoView.swift    # View de cada demo
├── Demos/                       # HTMLs de cada biblioteca
│   ├── ChartJSDemo.swift
│   ├── TensorFlowDemo.swift
│   ├── ToneJSDemo.swift
│   ├── D3Demo.swift
│   ├── ParticlesDemo.swift
│   ├── LottieDemo.swift
│   └── QRCodeDemo.swift
└── ContentView.swift            # Tela principal
```

## 💡 Mensagem Final da Palestra

"Como vocês viram, JavaScript vai muito além do Node.js. Com WebKit, podemos trazer todo o ecossistema JavaScript para apps nativos iOS - de gráficos a machine learning, de áudio a QR codes. A ponte entre Swift e JavaScript abre um mundo de possibilidades!"

## 🎤 Boa Sorte na Palestra!

Qualquer dúvida, só chamar! 🚀
