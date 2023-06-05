//
//  PreUIView.swift
//  trialproduct
//
//  Created by Hiroto Narumiya on 2023/05/28.
//

import SwiftUI

struct PreUIView: View {
    @State var opacity: Double = 1.0
    var body: some View {
        VStack(spacing:30){
            Text("FashionAI")
                .font(.system(size: 50, weight: .black, design: .default))
                .fontWeight(.bold)
                .offset(x:0,y:0)
                .foregroundColor(Color(red: 0, green: 0, blue: 0,opacity: opacity))
            Text("あなたに新しい買い物体験を").foregroundColor(Color(red: 0, green: 0, blue: 0,opacity: opacity))
            Text("Presented by TeamKnowledge").offset(y:295).foregroundColor(Color(red: 0, green: 0, blue: 0,opacity: opacity))
        }.frame(width:375,height:812)
            .background(Color(red:1.0,green:1.0,blue:0.9,opacity: opacity)).onAppear {
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false){timer in
                    withAnimation(.easeInOut(duration: 2.8)) {
                        // NOTE: opacityを変更する画面再描画に対してアニメーションを行う
                        self.opacity = 0.0
                    }
                }
                
            }
    }
}

struct PreUIView_Previews: PreviewProvider {
    static var previews: some View {
        PreUIView()
    }
}


//画面ピクセルサイズ早見表
//iPhone11 Pro: 375×812
//iPhone12Pro 844 390
//iPhone12ProMax 926 428
//iPhone13Pro 844 390
//iPhone13ProMax 926 428
//iPhone14Pro 852 393
//iPhone14ProMax 932 430
//iPadPro11inch 1194 834
//iPadPro12.9inch 1366 1024
//https://www.vamp.jp/archives/246
