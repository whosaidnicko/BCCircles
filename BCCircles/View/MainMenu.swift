
import SwiftUI

struct MainMenu: View {
    @EnvironmentObject private var vm: ViewModel
    var body: some View {
        ZStack{
            Background()
            
            VStack {
                VStack(spacing: -32){
                    HStack {
                        Spacer()
//                        Button {
//                            
//                        } label: {
//                          
//                        }

                        NavigationLink(destination: SettingsView().navigationBarBackButtonHidden()){
                        Image("btnSettings")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 32)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            if vm.isOnSound {
                                AudioManager.audioManager.playClickSound()
                            }
                            if vm.isOnVibration {
                                vm.triggerVibration()
                            }
                            
                        })
                        .padding(.horizontal)
                    }
                    
                    Image("ringsForMain")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                }
                
                Spacer()
                
                
//                NavigationLink(destination: SelectionLevel().navigationBarBackButtonHidden()){
                Button{
                    if vm.isOnSound {
                                          AudioManager.audioManager.playClickSound()
                                      }
                                      if vm.isOnVibration {
                                          vm.triggerVibration()
                                      }
                    vm.selectedApp = .lvl
    
                }label: {
                    Image("simpleFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .overlay{
                            Image(systemName: "arrowtriangle.forward.fill")
                                .resizable()
                                .frame(width: 40, height: 45)
                                .foregroundStyle(.white)
                        }
                }
                   
//                }
//                .simultaneousGesture(TapGesture().onEnded {
//                    if vm.isOnSound {
//                        AudioManager.audioManager.playClickSound()
//                    }
//                    if vm.isOnVibration {
//                        vm.triggerVibration()
//                    }
//                    
//                })
            }
            .padding(.vertical,50)
            
        }
    }
}

#Preview {
    MainMenu()
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
        .environmentObject(SceneController())
}
extension View {
    func olupaerbiozp() -> some View {
        self.modifier(Mouwlopsbuws())
    }
}
