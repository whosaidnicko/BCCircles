

import SwiftUI

struct Background: View {
    var imageName: String
    
    init(_ image: String = "bg") {
            self.imageName = image
        }
    
    var body: some View {
        ZStack {
            Image(imageName)
                .fullScreenBackground()
            
        }
    }
}

#Preview {
    Background()
}

