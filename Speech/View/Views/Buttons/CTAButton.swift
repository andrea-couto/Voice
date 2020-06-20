import SwiftUI

struct CTAButton: View
{
    var onToggle: (() -> Void)
    
    var body: some View
    {
        Button(action: onToggle)
        {
            Image(systemName: "mic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60, alignment: .center)
        }
        .frame(width: 100, height: 100, alignment: .center)
        .foregroundColor(Color.white)
        .background(Color.red)
        .mask(Circle())
    }
}
