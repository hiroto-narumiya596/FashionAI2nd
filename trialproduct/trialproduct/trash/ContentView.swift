//
//  ContentView.swift
//  trialproduct
//
//  Created by Hiroto Narumiya on 2023/05/13.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var PresentScreenMode: ScreenMode = .DefaultMode
    @State var isChatMode: Bool = false
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack{
                VStack{
                    if PresentScreenMode == .ConsultingMode{
                        ZStack{
                            /*
                            Rectangle()
                                .padding(.bottom, -8.0)
                                .foregroundColor(.brown)*/
                            ChatUIView(isChatMode: $isChatMode)
                        }
                    }
                    if PresentScreenMode == .DefaultMode{
                        Rectangle()
                            .padding(.bottom, -8.0)
                            .foregroundColor(.white)
                    }
                    if PresentScreenMode == .Menu2{
                        Rectangle()
                            .padding(.bottom, -8.0)
                            .foregroundColor(.blue)
                    }
                    if PresentScreenMode == .Menu3{
                        Rectangle()
                            .padding(.bottom, -8.0)
                            .foregroundColor(.green)
                    }
                    if PresentScreenMode == .UserSettingMode{
                        Rectangle()
                            .padding(.bottom, -8.0)
                            .foregroundColor(.yellow)
                    }
                    HStack(spacing:0){
                        Button(action: {
                            PresentScreenMode = .DefaultMode
                        }){
                            Text("ホーム")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width/5,height: geometry.size.width/5)
                                .background(.pink)
                                .border(.white)
                                .padding(.bottom, 8)
                        }
                        Button(action: {
                            PresentScreenMode = .ConsultingMode
                            isChatMode = true
                        }){
                            Text("相談")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                
                                .frame(width: geometry.size.width/5,height: geometry.size.width/5)
                                .border(.white)
                                .background(.pink)
                                .padding(.bottom, 8)
                        }
                        Button(action: {
                            PresentScreenMode = .Menu2
                        }){
                            Text("Menu2")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width/5,height: geometry.size.width/5)
                                .background(.pink)
                                .border(.white)
                                .padding(.bottom, 8)
                        }
                        Button(action: {
                            PresentScreenMode = .Menu3
                        }){
                            Text("Menu3")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width/5,height: geometry.size.width/5)
                                .background(.pink)
                                .border(.white)
                                .padding(.bottom, 8)
                        }
                        Button(action: {
                            PresentScreenMode = .UserSettingMode
                        }){
                            Text("ユーザー設定")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width/5,height: geometry.size.width/5)
                                .background(.pink)
                                .border(.white)
                                .padding(.bottom, 8)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
                .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.517))
            }
        }
    }
}

/*
 Rectangle()
     .padding(.bottom, -8.0)
     .searchable(text: $searchText)
     .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity:1.0))
 */




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
