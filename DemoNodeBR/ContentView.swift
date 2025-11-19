import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LibraryListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.libraries) { library in
                NavigationLink(destination: LibraryDemoView(library: library)) {
                    HStack(spacing: 16) {
                        Image(systemName: library.icon)
                            .font(.title2)
                            .foregroundStyle(.blue)
                            .frame(width: 40)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(library.rawValue)
                                .font(.headline)
                            Text(library.description)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("JavaScript além do Node.js")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView()
}
