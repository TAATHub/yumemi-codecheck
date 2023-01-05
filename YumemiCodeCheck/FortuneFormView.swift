//
//  FortuneFormView.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/05.
//

import SwiftUI

struct FortuneFormView<ViewModel: FortuneViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            // TODO: SeparatorViewとして切り出したい。カラーを引数として。
            Color.gray.frame(height: 1)
            
            HStack(spacing: 20) {
                Text("名前")
                TextField("名前を入力", text: $viewModel.name)
            }
            .padding(.vertical, 8)
            
            
            Color.gray.frame(height: 1)
            DatePicker("生年月日", selection: $viewModel.birthday, displayedComponents: [.date])
                .padding(.vertical, 8)
            
            Color.gray.frame(height: 1)
            HStack(spacing: 20) {
                Text("血液型")
                Spacer()
                Picker("血液型", selection: $viewModel.bloodType) {
                    Text("未入力").tag(BloodType.unkown)
                    Text("\(BloodType.a.typeText())型").tag(BloodType.a)
                    Text("\(BloodType.b.typeText())型").tag(BloodType.b)
                    Text("\(BloodType.o.typeText())型").tag(BloodType.o)
                    Text("\(BloodType.ab.typeText())型").tag(BloodType.ab)
                }
            }
            Color.gray.frame(height: 1)
        }
    }
}
