import SwiftUI
import Combine

class LibraryListViewModel: ObservableObject {
    @Published var libraries: [JSLibrary] = JSLibrary.allCases
    
    func getLibrary(at index: Int) -> JSLibrary {
        return libraries[index]
    }
}
