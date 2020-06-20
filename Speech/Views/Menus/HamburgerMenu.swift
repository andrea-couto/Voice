import SwiftUI

struct HamburgerMenu: View
{
    var body: some View
    {
        Button(action:
        {
            withAnimation
            {
                // TODO: - open menu
                print("Test")
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
