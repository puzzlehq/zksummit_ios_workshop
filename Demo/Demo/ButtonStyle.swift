//
//  Button.swift
//  puzzle-ios
//
//  Created by Darvish Kamalia on 4/18/23.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(.black)
            .cornerRadius(8)
            .font(.subheadline)
     }
}
