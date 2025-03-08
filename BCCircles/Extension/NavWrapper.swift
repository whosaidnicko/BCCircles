import SwiftUI

struct NavigationWrapped: ViewModifier {
    func body(content: Content) -> some View {
        NavigationStack {
            content
        }
    }
}

extension View {
    func wrappedInNavigation() -> some View {
        self.modifier(NavigationWrapped())
    }
}
