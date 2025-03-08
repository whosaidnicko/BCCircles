
import SwiftUI

extension View {
    func withAutoPreviewEnvironment() -> some View {
        self.environmentObject(ViewModel())
    }
}
