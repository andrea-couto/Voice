import SwiftUI

struct ContentView: View
{
    @State private var isMenuOpen = false

    @State private var textfieldValue: String = ""
    let backgroundColor = Color(rgb: 0xA8DADC)
    let navigationSpacer = Spacer()
    
    static var textfieldValue: String = ""
    static var bindingTextfieldValue = Binding<String>(get: { textfieldValue },
                                                       set: { textfieldValue = $0 } )
    
    @State private var recording = false
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            HStack(alignment: .center, spacing: 0)
            {
                HamburgerMenu(isOpen: isMenuOpen,
                              onToggle:
                {
                    self.toggleMenu()
                })
                navigationSpacer
                // TODO: - font & color
                Text("Speech to Text")
                    .font(.largeTitle)
                navigationSpacer
            }
            
            ScrollView
            {
                MultilineTextField("🗣 ➡️ 📃️",
                                   text: ContentView.bindingTextfieldValue,
                                   userEnabled: false)
                .cornerRadius(10)
                .padding([.horizontal], 10)
            }
                        
            HStack(alignment: .center)
            {
                Spacer()
                CTAButton(onToggle: toggleCta)
                Spacer()
            }
            
            Spacer()
        }
            .background(backgroundColor.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
    }
    
    private func toggleCta()
    {
        self.recording.toggle()
        print("recording: \(recording.description)")
    }
    
    private func toggleMenu()
    {
        self.isMenuOpen.toggle()
        print("menu: \(isMenuOpen.description)")
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
