//
//  HomeUIView.swift
//  trialproduct
//
//  Created by Hiroto Narumiya on 2023/05/28.
//

import SwiftUI

struct HomeUIView: View {
    var temp_news:[news] = [news(id:"2220", newscontent: "・GlobalWorkが最新のコートを発表"),news(id:"2221", newscontent: "・GlobalWorkが最新のコートを発表"),news(id:"2222", newscontent: "・GlobalWorkが最新のコートを発表"),news(id:"2223", newscontent: "・GlobalWorkが最新のコートを発表"),news(id:"2224", newscontent: "・GlobalWorkが最新のコートを発表"),news(id:"2225", newscontent: "・GlobalWorkが最新のコートを発表"),news(id:"2226", newscontent: "・GlobalWorkが最新のコートを発表"),news(id:"2227", newscontent: "・GlobalWorkが最新のコートを発表"),news(id:"2228", newscontent: "・GlobalWorkが最新のコートを発表")]
    var body: some View {
        VStack(alignment: .leading){
            Text("あなたへのおすすめ")
                .font(.title2)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .padding(.top, 10.0)
            VStack{
                ScrollView(.horizontal){
                    HStack{
                        Rectangle().padding(.trailing, 10.0).frame(width:300,height:370)
                        Rectangle().padding(.trailing, 10.0).frame(width:300,height:370)
                        Rectangle().padding(.trailing, 10.0).frame(width:300,height:370)
                        Rectangle().padding(.trailing, 10.0).frame(width:300,height:370)
                    }.padding(.bottom, 30.0).frame(height:400)
                }
            }
            Text("トレンド")
                .font(.title2)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                //.padding(.top, 10.0)
            VStack(alignment: .leading){
                ScrollViewReader{reader in
                    ScrollView(.vertical){
                        ForEach(temp_news){ news in
                            Text(news.newscontent).multilineTextAlignment(.leading).padding(.bottom, 10.0)//.id(0)
                      
                        }.frame(width: 355,alignment: .leading)
                        //}.frame(width:355, height:180)
                    }.frame(width:355, height:180)
                }
                
            }.frame(width:355, height:180)//.border(.red)
        }
        .padding(.leading, 10.0)
    }
    
    struct news: Identifiable{
        let id: String
        let newscontent: String
    }
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
