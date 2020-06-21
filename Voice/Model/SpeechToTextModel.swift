import SwiftUI

class SpeechToTextModel: ObservableObject
{
    @Published var textForDisplay = "🗣 ➡️ 📃️"
    
    //TODO: - start listening and updating textForDisplay function
}

func requestTranscribePermissions() {
    SFSpeechRecognizer.requestAuthorization
    {
        authStatus
        in
        DispatchQueue.main.async {
            if authStatus == .authorized {
                print("Good to go!")
            } else {
                print("Transcription permission was declined.")
            }
        }
    }
}
