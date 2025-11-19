import SwiftUI
import Combine

class LibraryDemoViewModel: ObservableObject {
    @Published var isLoading = true
    let library: JSLibrary
    
    init(library: JSLibrary) {
        self.library = library
    }
    
    var htmlContent: String {
        switch library {
        case .chartjs:
            return ChartJSDemo.html
        case .tensorflow:
            return TensorFlowDemo.html
        case .tonejs:
            return ToneJSDemo.html
        case .d3:
            return D3Demo.html
        case .particles:
            return ParticlesDemo.html
        case .lottie:
            return LottieDemo.html
        case .qrcode:
            return QRCodeDemo.html
        }
    }
}
