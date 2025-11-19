import SwiftUI

struct LibraryDemoView: View {
    let library: JSLibrary
    @StateObject private var viewModel: LibraryDemoViewModel
    @State private var swiftMessage: String? = nil
    @State private var inputText: String = "https://github.com/DalPra0"
    
    init(library: JSLibrary) {
        self.library = library
        _viewModel = StateObject(wrappedValue: LibraryDemoViewModel(library: library))
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                VStack(spacing: 0) {
                    swiftControlsView
                    
                    JSWebView(
                        htmlContent: viewModel.htmlContent,
                        library: library,
                        swiftToJSMessage: $swiftMessage
                    )
                }
            }
        }
        .navigationTitle(library.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.isLoading = false
        }
    }
    
    @ViewBuilder
    private var swiftControlsView: some View {
        VStack(spacing: 12) {
            switch library {
            case .chartjs:
                HStack(spacing: 10) {
                    Button("📊 Atualizar Dados") {
                        swiftMessage = "updateData"
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
                    
                    Button("📈 Linha") {
                        swiftMessage = "changeType:line"
                    }
                    .buttonStyle(.bordered)
                    
                    Button("📊 Barra") {
                        swiftMessage = "changeType:bar"
                    }
                    .buttonStyle(.bordered)
                }
                
            case .tensorflow:
                HStack(spacing: 10) {
                    Button("🧠 Treinar Regressão") {
                        swiftMessage = "trainRegression"
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.pink)
                    
                    Button("🔢 Operações Tensor") {
                        swiftMessage = "runTensorOps"
                    }
                    .buttonStyle(.bordered)
                }
                
            case .tonejs:
                VStack(spacing: 8) {
                    HStack(spacing: 10) {
                        ForEach(["C4", "E4", "G4", "C5"], id: \.self) { note in
                            Button(note) {
                                swiftMessage = "playNote:\(note)"
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                        }
                    }
                    Button("🎵 Tocar Sequência") {
                        swiftMessage = "playSequence"
                    }
                    .buttonStyle(.bordered)
                }
                
            case .d3:
                HStack(spacing: 10) {
                    Button("➕ Adicionar Nó") {
                        swiftMessage = "addNode"
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    
                    Button("🔗 Conectar Aleatório") {
                        swiftMessage = "addRandomLink"
                    }
                    .buttonStyle(.bordered)
                    
                    Button("🔄 Reset") {
                        swiftMessage = "reset"
                    }
                    .buttonStyle(.bordered)
                }
                
            case .particles:
                HStack(spacing: 10) {
                    Button("❄️ Snow") {
                        swiftMessage = "changeStyle:snow"
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.cyan)
                    
                    Button("🌟 Stars") {
                        swiftMessage = "changeStyle:stars"
                    }
                    .buttonStyle(.bordered)
                    
                    Button("🔴 Bubbles") {
                        swiftMessage = "changeStyle:bubbles"
                    }
                    .buttonStyle(.bordered)
                }
                
            case .lottie:
                HStack(spacing: 10) {
                    Button("▶️ Play") {
                        swiftMessage = "play"
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    
                    Button("⏸ Pause") {
                        swiftMessage = "pause"
                    }
                    .buttonStyle(.bordered)
                    
                    Button("⏹ Stop") {
                        swiftMessage = "stop"
                    }
                    .buttonStyle(.bordered)
                    
                    Button("⏪ Reverso") {
                        swiftMessage = "reverse"
                    }
                    .buttonStyle(.bordered)
                }
                
            case .qrcode:
                HStack {
                    TextField("Digite URL ou texto", text: $inputText)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                    Button("Gerar QR") {
                        swiftMessage = inputText
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
    }
}
