//
//  GrowingButton.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/07.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: width, height: height)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
