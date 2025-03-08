import SwiftUI



extension Image {
    func fullScreenBackground() -> some View {
        self
            .resizable()
//            .scaledToFill()
            .ignoresSafeArea()
    }
}
