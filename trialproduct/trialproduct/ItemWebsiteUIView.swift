//
//  ItemWebsiteUIView.swift
//  trialproduct
//
//  Created by Hiroto Narumiya on 2023/05/29.
//

import SwiftUI
import WebKit

struct TopsItemWebsiteUIView: View {
    @Binding var isOpenItemWebsiteUIView: Bool!
    @State var opacity: Double = 1.0
    @State var ItemURL: String!
    var body: some View {
        NavigationStack{
            VStack{
                ItemWebsiteUIViewRepresentable(loardUrl: URL(string: ItemURL)!).frame(width: 375, height: 690)
            }.frame(width: 375,height: 812)
                .background(Color(red: 0.6, green: 0.6, blue: 0.6,opacity:0.6)).toolbar{
                    ToolbarItem(placement:.navigationBarTrailing){
                        Button(action:{withAnimation(.linear(duration: 1)) {
                            isOpenItemWebsiteUIView.toggle()
                            opacity = 0
                        }}){
                            Image(systemName: "xmark").foregroundColor(.black)
                        }
                    }
                }
        }.opacity(opacity)
    }
}


struct BottomsItemWebsiteUIView: View {
    @Binding var isOpenItemWebsiteUIView: Bool!
    @State var opacity: Double = 1.0
    @State var ItemURL: String!
    @State var temp_ItemURL: String! = "https://store.shopping.yahoo.co.jp/masanagoya/1994012.html"
    var body: some View {
        NavigationStack{
            VStack{
                ItemWebsiteUIViewRepresentable(loardUrl: URL(string: ItemURL)!).frame(width: 375, height: 690)
            }.frame(width: 375,height: 812)
                .background(Color(red: 0.6, green: 0.6, blue: 0.6,opacity:0.6)).toolbar{
                    ToolbarItem(placement:.navigationBarTrailing){
                        Button(action:{withAnimation(.linear(duration: 1)) {
                            isOpenItemWebsiteUIView.toggle()
                            opacity = 0
                        }}){
                            Image(systemName: "xmark").foregroundColor(.black)
                        }
                    }
                }
        }.opacity(opacity)
    }
}


struct ShoesItemWebsiteUIView: View {
    @Binding var isOpenItemWebsiteUIView: Bool!
    @State var opacity: Double = 1.0
    @State var ItemURL: String!
    @State var temp_ItemURL: String! = "https://store.shopping.yahoo.co.jp/masanagoya/1994012.html"
    var body: some View {
        NavigationStack{
            VStack{
                ItemWebsiteUIViewRepresentable(loardUrl: URL(string: ItemURL)!).frame(width: 375, height: 690)
            }.frame(width: 375,height: 812)
                .background(Color(red: 0.6, green: 0.6, blue: 0.6,opacity:0.6)).toolbar{
                    ToolbarItem(placement:.navigationBarTrailing){
                        Button(action:{withAnimation(.linear(duration: 1)) {
                            isOpenItemWebsiteUIView.toggle()
                            opacity = 0
                        }}){
                            Image(systemName: "xmark").foregroundColor(.black)
                        }
                    }
                }
        }.opacity(opacity)
    }
}

struct OuterItemWebsiteUIView: View {
    @Binding var isOpenItemWebsiteUIView: Bool!
    @State var opacity: Double = 1.0
    @State var ItemURL: String!
    @State var temp_ItemURL: String! = "https://store.shopping.yahoo.co.jp/masanagoya/1994012.html"
    var body: some View {
        NavigationStack{
            VStack{
                ItemWebsiteUIViewRepresentable(loardUrl: URL(string: ItemURL)!).frame(width: 375, height: 690)
            }.frame(width: 375,height: 812)
                .background(Color(red: 0.6, green: 0.6, blue: 0.6,opacity:0.6)).toolbar{
                    ToolbarItem(placement:.navigationBarTrailing){
                        Button(action:{withAnimation(.linear(duration: 1)) {
                            isOpenItemWebsiteUIView.toggle()
                            opacity = 0
                        }}){
                            Image(systemName: "xmark").foregroundColor(.black)
                        }
                    }
                }
        }.opacity(opacity)
    }
}

struct ItemWebsiteUIViewRepresentable: UIViewRepresentable{
    let loardUrl: URL
    
    func makeUIView(context: Context) -> WKWebView {
            return WKWebView()
        }
        
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: loardUrl)
        uiView.load(request)
    }
}


struct ItemWebsiteUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
