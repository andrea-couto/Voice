import SwiftUI

struct ContentView: View
{
    @State private var textfieldValue: String = ""
    let backgroundColor = Color(rgb: 0xA8DADC)
    let navigationSpacer = Spacer()
    
    static var textfieldValue: String = ""
    static var bindingTextfieldValue = Binding<String>(get: { textfieldValue },
                                                       set: { textfieldValue = $0 } )
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            HStack(alignment: .center, spacing: 0)
            {
                HamburgerMenu()
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
                                   onCommit:
                {
                    // TODO: - do something with the text
                    print("Final text: \(ContentView.textfieldValue)")
                })
                .cornerRadius(10)
                .padding([.horizontal], 10)
            }
        }
            .background(backgroundColor.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
    }

}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
