import SwiftUI
import Speech

class SpeechToTextModel: NSObject, ObservableObject
{
    @State var textForDisplay = ""
    
    @Published var buttonEnabled  = false
    let defaultTextForDisplay   = "🗣 ➡️ 📃️"
    // TODO: - published var for button image
    
    private var recording = false

    func toggleRecording()
    {
        // TODO: - switch on whether recording is running, update button enabled & button image "mic"/"mic.fill"
        recording.toggle()
        print("recording: \(recording.description)")
    }
    
    func setupSpeech()
    {
        SFSpeechRecognizer.requestAuthorization
        {
            [weak self] (authStatus)
            in
            DispatchQueue.main.async
            {
                switch authStatus
                {
                case .authorized:
                    self?.buttonEnabled = true
                case .denied, .restricted, .notDetermined:
                    self?.buttonEnabled = false
                @unknown default:
                    self?.buttonEnabled = false
                }
            }
         }
     }
    
    func startRecording()
    {
        // TODO: -
    }
}

extension SpeechToTextModel: SFSpeechRecognizerDelegate
{
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool)
    {
        DispatchQueue.main.async
        {
            [weak self]
            in
            if available
            {
                self?.buttonEnabled = true
            }
            else
            {
                self?.buttonEnabled = false
            }
        }
    }
}
