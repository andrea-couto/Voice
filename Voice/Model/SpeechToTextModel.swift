import SwiftUI
import Speech

class SpeechToTextModel: NSObject, ObservableObject
{
    @State var textForDisplay = ""
    
    @Published var buttonEnabled  = false
    let defaultTextForDisplay   = "🗣 ➡️ 📃️"
    // TODO: - published var for button image
        
    let speechRecognizer        = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))

    var recognitionRequest      : SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask         : SFSpeechRecognitionTask?
    let audioEngine             = AVAudioEngine()

    func toggleRecording()
    {
        // TODO: - button image "mic"/"mic.fill"

        if audioEngine.isRunning
        {
            self.audioEngine.stop()
            self.recognitionRequest?.endAudio()
            self.buttonEnabled = false
//            self.btnStart.setTitle("Start Recording", for: .normal)
        }
        else
        {
            self.startRecording()
//            self.btnStart.setTitle("Stop Recording", for: .normal)
        }
    }
    
    func setupSpeech()
    {
        self.speechRecognizer?.delegate = self

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
        if recognitionTask != nil
        {
            recognitionTask?.cancel()
            recognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()
        do
        {
            try audioSession.setCategory(.record, mode: .measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        }
        catch let error
        {
            print("There was an error setting up the recording session: \(error)")
        }

        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        let inputNode = audioEngine.inputNode

        guard let recognitionRequest = recognitionRequest else
        {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }

        recognitionRequest.shouldReportPartialResults = true

        print("recording")
        self.recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler:
        {
            (result, error)
            in

            if (error != nil || result?.isFinal ?? false), let result = result
            {
                // TODO: - textForDisplay not setting but the string is there in result??
                // tried dispatching to main there's still an issue
                self.textForDisplay = result.bestTranscription.formattedString
                print("Text for display: \(String(describing: self.textForDisplay))")
                print("result best transcription: \(result.bestTranscription.formattedString)")

                if let error = error
                {
                    print("There was an error: \(error)")
                }
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.buttonEnabled = true
            }
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat)
        {
            (buffer, when)
            in
            self.recognitionRequest?.append(buffer)
        }

        self.audioEngine.prepare()

        do
        {
            try self.audioEngine.start()
        }
        catch
        {
            print("audioEngine couldn't start because of an error.")
        }
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
