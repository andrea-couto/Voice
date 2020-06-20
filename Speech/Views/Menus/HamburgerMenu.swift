import SwiftUI

struct HamburgerMenu: View
{
    var isOpen: Bool = false
    var onToggle: (() -> Void)?
    
    var body: some View
    {
        Button(action:
        {
            withAnimation
            {
                // TODO: - open menu
                self.onToggle?()
            }
        })
        {
            Image(systemName: "line.horizontal.3")
                .imageScale(.large)
                .foregroundColor(.black)
        }
        .padding(.leading, 20)
    }
}
