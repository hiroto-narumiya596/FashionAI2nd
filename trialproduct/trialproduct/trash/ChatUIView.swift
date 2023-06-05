//
//  ChatUIView.swift
//  trialproduct
//
//  Created by Hiroto Narumiya on 2023/05/16.
//

import Foundation
import SwiftUI

struct ChatUIView: View{
    @Binding var isChatMode: Bool
    @State var name: String = ""
    @State private var message = ""
    @State private var editting = false
    var body: some View{
        VStack(spacing:0){
            Rectangle().border(.white).foregroundColor(Color(red: 0.5, green: 0.9, blue: 0.9))
            Rectangle().border(.white).foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
            ZStack{
                Rectangle().frame(width:.infinity,height:65).foregroundColor(Color(red: 0.838, green: 0.802, blue: 0.803))
                HStack(alignment: .center, spacing:15){
                    Button(action:{print("OK")}){
                        ZStack{
                            Circle().padding(.leading, 3.0).frame(width: 45, height:45)
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .frame(width: 27, height:27)
                                .foregroundColor(.white)
                        }
                    }
                    TextField("ご要望をどうぞ", text: $name,
                              
                              onEditingChanged: { begin in
                                  /// 入力開始処理
                                  if begin {
                                      self.editting = true    // 編集フラグをオン
                                      self.message = ""       // メッセージをクリア
                                          
                                      /// 入力終了処理
                                  } else {
                                      self.editting = false   // 編集フラグをオフ
                                  }
                    }).frame(width: 300,height: 40).border(.white)
                }
            }
        }
    }
}


struct CommunicationUIView: UIViewRepresentable{
    var text: String
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
    }
}

class CommunicationUIViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct ChatUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
