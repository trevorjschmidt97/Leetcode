import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var navigationPath = NavigationPath()
}

class ScreenViewModel: ObservableObject {
    @Published var info = "info"
}
extension ScreenViewModel: Equatable {
    static func == (lhs: ScreenViewModel, rhs: ScreenViewModel) -> Bool {
        lhs.info == rhs.info
    }
}
extension ScreenViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(info)
    }
}

class SearchViewModel: ObservableObject {
    @Published var info = "info"
}
extension SearchViewModel: Equatable {
    static func == (lhs: SearchViewModel, rhs: SearchViewModel) -> Bool {
        lhs.info == rhs.info
    }
}
extension SearchViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(info)
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @StateObject var screenViewModel = ScreenViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ScrollView {
                NavigationLink(value: screenViewModel) {
                    Text(screenViewModel.info)
                }
            }
            .navigationDestination(for: ScreenViewModel.self) { model in
                ScreenView(viewModel: model)
            }
        }
    }
}

struct ScreenView: View {
    
    @ObservedObject var viewModel: ScreenViewModel
    
    var body: some View {
        Text(viewModel.info)
        NavigationLink(value: SearchViewModel()) {
            Text("Search")
        }
    }
}

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        Text(viewModel.info)
        Button("change") {
            
        }
    }
}
