

import SwiftUI

extension Font {
    static let cherry = "CherryBombOne-Regular"
}

extension Text {

    func Cherry(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.custom(Font.cherry, size: size))
            .foregroundStyle(color)
    }

    
    func SFBold(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .bold))
            .foregroundStyle(color)
    }
    
    func SFMedium(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .medium))
            .foregroundStyle(color)
    }
    
    func SFRegular(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .regular))
            .foregroundStyle(color)
    }
    
}

extension View {
    
    func Cherry(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.custom(Font.cherry, size: size))
            .foregroundStyle(color)
    }

    
    func SFBold(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .bold))
            .foregroundStyle(color)
    }
    
    func SFMedium(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .medium))
            .foregroundStyle(color)
    }
    
    func SFRegular(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .regular))
            .foregroundStyle(color)
    }
}








struct fon: View {
    var body: some View {

        VStack(spacing: 40){
            Text("Rainbow Delight")
                .Cherry( 24)
            Text("Rainbow Delight")
//                .GeologicaBold(size: 24)
            Text("Rainbow Delight")
                .font(.custom("Geologica-Bold", size: 24))
                .foregroundStyle(.white)
            Text("Rainbow Delight")
                .font(.system(size: 24))

        }
    }
}
#Preview {
    ZStack {
        Color.gray
        fon()
    }
  
}
