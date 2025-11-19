import Foundation

enum JSLibrary: String, CaseIterable, Identifiable {
    case chartjs = "Chart.js"
    case tensorflow = "TensorFlow.js"
    case tonejs = "Tone.js"
    case d3 = "D3.js"
    case particles = "Particles.js"
    case lottie = "Lottie-web"
    case qrcode = "QRCode.js"
    
    var id: String { rawValue }
    var name: String { rawValue }
    
    var description: String {
        switch self {
        case .chartjs:
            return "Gráficos interativos e animados"
        case .tensorflow:
            return "Machine Learning no navegador"
        case .tonejs:
            return "Síntese de áudio e música"
        case .d3:
            return "Visualizações de dados poderosas"
        case .particles:
            return "Efeitos de partículas animadas"
        case .lottie:
            return "Animações complexas"
        case .qrcode:
            return "Gerador de QR Code"
        }
    }
    
    var icon: String {
        switch self {
        case .chartjs:
            return "chart.bar.fill"
        case .tensorflow:
            return "brain.head.profile"
        case .tonejs:
            return "waveform"
        case .d3:
            return "chart.xyaxis.line"
        case .particles:
            return "sparkles"
        case .lottie:
            return "play.circle.fill"
        case .qrcode:
            return "qrcode"
        }
    }
}
