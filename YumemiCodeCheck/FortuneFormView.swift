//
//  ContentView.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/04.
//

import SwiftUI

struct FortuneFormView<ViewModel: FortuneViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Form {
            TextField("名前を入力", text: $viewModel.name)
            // TODO: 未選択状態を検知したい
            DatePicker("生年月日", selection: $viewModel.birthday, displayedComponents: [.date])
            Picker("血液型", selection: $viewModel.bloodType) {
                Text("未入力").tag(BloodType.unkown)
                Text("\(BloodType.a.typeText())型").tag(BloodType.a)
                Text("\(BloodType.b.typeText())型").tag(BloodType.b)
                Text("\(BloodType.o.typeText())型").tag(BloodType.o)
                Text("\(BloodType.ab.typeText())型").tag(BloodType.ab)
            }

            Button("占う") {
                viewModel.onFortuneButtonTapped()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FortuneFormView(viewModel: FortuneViewModel())
    }
}
