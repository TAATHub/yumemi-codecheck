//
//  ContentView.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/04.
//

import SwiftUI

struct FortuneView<ViewModel: FortuneViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("都道府県占い")
                .font(.system(size: 24))
            
            Text("名前や生年月日、血液型を入力して、あなたにピッタリな都道府県を占います！")
                .padding(.vertical)
            
            FortuneFormView(viewModel: viewModel)
            
            Spacer()
            
            Button("占う") {
                Task {
                    await viewModel.onFortuneButtonTapped()
                }
            }
            .fontWeight(.bold)
            .padding(12)
            .frame(width: 200)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FortuneView(viewModel: FortuneViewModel())
    }
}
