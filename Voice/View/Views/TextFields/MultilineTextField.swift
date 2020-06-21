import SwiftUI

struct MultilineTextField: View
{
    private var placeholder: String
    private var onCommit: (() -> Void)?
    private var userEnabled = false
    // TODO: - ratio of superview
    @State private var viewHeight: CGFloat = 400
    @State private var shouldShowPlaceholder = false
    @Binding private var text: String
    
    private var internalText: Binding<String>
    {
        Binding<String>(get: { self.text } )
        {
            self.text = $0
            self.shouldShowPlaceholder = $0.isEmpty
        }
    }

    var body: some View
    {
        ZStack(alignment: .topLeading)
        {
            UITextViewWrapper(text: self.internalText,
                              onDone: onCommit,
                              userEnabled: userEnabled)
                .frame(minHeight: viewHeight, maxHeight: viewHeight)
            placeholderView
        }        
    }

    var placeholderView: some View
    {
        Group
        {
            if shouldShowPlaceholder
            {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }
    
    init (_ placeholder: String = "",
          text: Binding<String>,
          userEnabled: Bool,
          onCommit: (() -> Void)? = nil)
    {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self._text = text
        self.userEnabled = userEnabled
        self._shouldShowPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
    }
}


private struct UITextViewWrapper: UIViewRepresentable
{
    typealias UIViewType = UITextView

    @Binding var text: String
    var onDone: (() -> Void)?
    var userEnabled = false

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView
    {
        let textField = UITextView()
        textField.delegate = context.coordinator

        // TODO: - allow copy, but fix the keyboard coming up if we only want the program to update the textfield
        textField.isEditable = userEnabled
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = userEnabled
        textField.isScrollEnabled = true
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.black
        if nil != onDone
        {
            textField.returnKeyType = .done
        }

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }

    func updateUIView(_ uiView: UITextView,
                      context: UIViewRepresentableContext<UITextViewWrapper>)
    {
        if uiView.text != self.text
        {
            uiView.text = self.text
        }
        if uiView.window != nil, !uiView.isFirstResponder
        {
            uiView.becomeFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator
    {
        return Coordinator(text: $text, userEnabled: userEnabled, onDone: onDone)
    }

    final class Coordinator: NSObject, UITextViewDelegate
    {
        var text: Binding<String>
        var onDone: (() -> Void)?

        init(text: Binding<String>, userEnabled: Bool, onDone: (() -> Void)? = nil)
        {
            self.text = text
            self.onDone = onDone
        }

        func textViewDidChange(_ uiView: UITextView)
        {
            text.wrappedValue = uiView.text
        }

        func textView(_ textView: UITextView,
                      shouldChangeTextIn range: NSRange,
                      replacementText text: String) -> Bool
        {
            if let onDone = self.onDone, text == "\n"
            {
                textView.resignFirstResponder()
                onDone()
                return false
            }
            return true
        }
    }
}
