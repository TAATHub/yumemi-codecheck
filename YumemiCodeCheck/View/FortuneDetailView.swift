//
//  FortuneDetailView.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/06.
//

import SwiftUI

struct FortuneDetailView: View {
    var fortuneResult: FortuneResult
    
    var body: some View {
        VStack(spacing: 16) {
            Text("あなたにピッタリな都道府県は")
                .padding()
            
            Text(fortuneResult.name)
                .font(.system(size: 24, weight: .bold))
            
            Text(fortuneResult.capital)
            
            Text(fortuneResult.brief)
            
            Spacer()
        }
        .padding()
    }
}

struct FortuneDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FortuneDetailView(fortuneResult: FortuneResult(name: "京都府",
                                                       capital: "京都市",
                                                       brief: "京都府（きょうとふ）は、日本の近畿地方に位置する府。府庁所在地は京都市。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』"))
    }
}
