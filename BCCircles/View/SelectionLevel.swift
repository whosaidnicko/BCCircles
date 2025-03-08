import SwiftUI

struct SelectionLevel: View {
    @EnvironmentObject private var vm: SceneController
    @EnvironmentObject private var viewModel: ViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ZStack {
            Background()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(vm.levelStates, id: \.levelIndex) { level in
                 
                        Button{
                            
                            if viewModel.isOnSound {
                                AudioManager.audioManager.playClickSound()
                            }
                            if viewModel.isOnVibration {
                                viewModel.triggerVibration()
                            }
                            
                            viewModel.indexLvl = level.levelIndex
                            withAnimation {
                                viewModel.selectedApp = .game
                            }
                          
                            
                        }label: {
                            LevelButton(level: level)
                        }
                        
                 
                        .disabled(!level.isOpen)
                        //
                        
                    }
                }
                .padding()
            }
            
        }
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                CustomBackButtom(){viewModel.selectedApp = .main}
            }
        }
    }
}

// Кнопка уровня
struct LevelButton: View {
    var level: LvlModel
    
    var body: some View {
        
        ZStack {
            
            Image(level.isOpen && !level.isFinished ? "currentSimpleFrame" : "simpleFrame")
                .resizable()
                .scaledToFit()
                .opacity(level.isOpen ? 1 : 0.5)
            
            
            Text("\(level.levelIndex + 1)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        
    }
}
#Preview {
    SelectionLevel()
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
        .environmentObject(SceneController())
}
