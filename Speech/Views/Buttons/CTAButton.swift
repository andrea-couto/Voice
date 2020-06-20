import SwiftUI

struct CTAButton: View
{
    private let startConverting =
    {
        // TODO: - listen and populate the textield
        // TODO: - switch image to mic.fill / mic based on current state
        print("start converting")
    }
    
    var body: some View
    {
        Button(action: startConverting)
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
