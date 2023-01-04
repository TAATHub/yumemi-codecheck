//
//  ContentView.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/04.
//

import SwiftUI

enum BloodType: String {
    case unkown
    case a
    case b
    case o
    case ab
    
    func typeText() -> String {
        switch self {
        case .a, .b, .o, .ab:
            return self.rawValue.uppercased()
        default:
            return "不明"
        }
    }
}

struct ContentView: View {
    // TODO: ViewModelに移動させる
    @State var name: String = ""
    @State var birthday: Date = Date()
    @State var bloodType: BloodType = .unkown
    
    var body: some View {
        Form {
            TextField("名前を入力", text: $name)
            // TODO: 未選択状態を検知したい
            DatePicker("生年月日", selection: $birthday, displayedComponents: [.date])
            Picker("血液型", selection: $bloodType) {
                Text("未入力").tag(BloodType.unkown)
                Text("\(BloodType.a.typeText())型").tag(BloodType.a)
                Text("\(BloodType.b.typeText())型").tag(BloodType.b)
                Text("\(BloodType.o.typeText())型").tag(BloodType.o)
                Text("\(BloodType.ab.typeText())型").tag(BloodType.ab)
            }

            Button("占う") {
                // TODO: ViewModel経由でAPIリクエスト
                print("名前: \(name), 生年月日: \(birthday), 血液型: \(bloodType)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
