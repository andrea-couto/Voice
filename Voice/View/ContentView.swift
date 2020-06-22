import SwiftUI

struct ContentView: View
{
    @ObservedObject var speechToTextModel = SpeechToTextModel()
        
    let backgroundColor = Color(rgb: 0xA8DADC)
    let navigationSpacer = Spacer()
        
    var body: some View
    {
        NavigationView
        {
            VStack(alignment: .leading)
            {
                ScrollView
                {
                    MultilineTextField(speechToTextModel.defaultTextForDisplay,
                                       text: $speechToTextModel.textForDisplay,
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
            .navigationBarTitle("Speech to Text", displayMode: .large)
            .navigationBarItems(trailing:
                NavigationLink(destination: Text("TODO"))
                {
                    Text("Text to Speech")
                }
            )
            .onAppear(perform: speechToTextModel.setupSpeech)
        }
    }
    
    // TODO: - limit the number of toggles per second
    private func toggleCta()
    {
        speechToTextModel.toggleRecording()
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
