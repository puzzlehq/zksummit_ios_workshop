//
//  TextInput.swift
//  puzzle-ios
//
//  Created by Darvish Kamalia on 4/17/23.
//

import SwiftUI

struct TextInput: View {
    enum FieldState {
        case enabled
        case disabled
        case editing
        case error(message: String)
        
        var foregroundColor: Color {
            switch (self) {
            case .disabled: return .gray
            case .enabled: return .gray
            case .editing: return .black
            case .error: return .red
            }
        }
        
        var placeholderColor: Color {
            switch (self) {
            case .disabled: return .gray
            case .enabled: return .gray
            case .editing: return .gray
            case .error: return .gray
            }
        }
    }
    
    @State var state: FieldState = .enabled
    @State var placeholder: String = ""
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(state.placeholderColor))
            .padding(.all, 16)
            .foregroundColor(state.foregroundColor)
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(state.foregroundColor, style: StrokeStyle(lineWidth: 1.0)))
            
            if case .error(let message) = state {
                Text(message)
                    .foregroundColor(.red)
            }
        }
    }
}

struct TextInputPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextInput(state: .enabled, placeholder: "Enabled", text: .constant(""))
            TextInput(state: .disabled, placeholder: "Disabled", text: .constant(""))
            TextInput(state: .editing, placeholder: "Placeholder", text: .constant("Editing"))
            TextInput(state: .error(message: "This is an error"), placeholder: "Error", text: .constant(""))

        }
        .padding(.all, 20)
    }
    
    
}

