

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var vm: ViewModel
    var body: some View {
        ZStack{
            Background()
            
            switch vm.selectedApp {
                
            case .loading:
                LoadingView()
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            vm.selectedApp = .welcome
                        }
                    }
            case .welcome:
                WelcomeView()
                    .transition(.slide)
            case .main:
                MainMenu()
                    .wrappedInNavigation()
            case .lvl:
                SelectionLevel()
                    .wrappedInNavigation()
            case .game:
                GameSceneView(index: vm.indexLvl)
                    
            }
        }
        .olupaerbiozp()
        .onChange(of: vm.selectedApp){new in
//            print(vm.selectedApp)
        }
        
    }
}

#Preview {
    RootView()
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
        .environmentObject(SceneController())
}
