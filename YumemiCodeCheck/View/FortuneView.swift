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
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                VStack {
                    Text("都道府県占い")
                        .font(.system(size: 24))
                    
                    Text("名前や生年月日、血液型を入力して、あなたにピッタリな都道府県を占います！")
                        .padding(.vertical)
                    
                    // 入力フォーム
                    FortuneFormView(viewModel: viewModel)
                    
                    Spacer()
                    
                    Button("占う") {
                        Task {
                            await viewModel.onFortuneButtonTapped()
                        }
                    }
                    .buttonStyle(GrowingButton(width: 240))
                }
                .padding()
                // 同一階層に定義した複数のアラートが表示されない問題は、iOS 15から使えるalert(_:isPresented:actions:message:)で解決できる
                // 参考：https://tech.amefure.com/swift-alert
                .alert("確認", isPresented: $viewModel.isInvalidInputAlertPresented, actions: {
                    Button("OK") {}
                }, message: {
                    Text("入力値が不正です。")
                })
                .alert("エラー", isPresented: $viewModel.isErrorAlertPresented, actions: {
                    Button("OK") {}
                }, message: {
                    Text("エラーが発生しました。再度お試しください。")
                })
                
                if viewModel.isLoading {
                    CustomProgressView()
                }
            }
            .navigationDestination(for: NavigationPath.self) { path in
                switch path {
                case .fortuneDetail(let result):
                    FortuneDetailView(fortuneResult: result)
                default:
                    // 遷移を中断させることはできない？
                    EmptyView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FortuneView(viewModel: FortuneViewModel())
    }
}
