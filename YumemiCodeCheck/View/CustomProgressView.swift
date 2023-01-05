//
//  CustomProgressView.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/05.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ZStack {
            Color.clear
                // 他にやり方はないのか？
                // .contentShape(Rectangle())を試してみたけどダメだった
                // https://stackoverflow.com/questions/56819847/tap-action-not-working-when-color-is-clear-swiftui
                .background(Color.white.opacity(0.0001))
            ProgressView()
                .padding(16)
                .background(Color.gray)
                .progressViewStyle(.circular)
                .tint(.white)
                .cornerRadius(8)
        }
    }
}
