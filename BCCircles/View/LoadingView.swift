
import SwiftUI

struct LoadingView: View {
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack{
            Background()
            VStack {
                Image("circlesLoading")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 408)
                
                Spacer()
                Text("Loading")
                    .Cherry(32)
                Image("simpleFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .overlay {
                        Image("ringLoad")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 60)
                            .rotationEffect(.degrees(rotationAngle))
                            .onAppear {
                                startRotation()
                            }
                    }
                
                
            }
            .padding(.vertical,50)
        }
    }
}

#Preview {
    LoadingView()
}


extension LoadingView {
    private func startRotation() {
        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
            rotationAngle = 360
        }
    }
}
