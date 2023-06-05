//
//  SliderUIView.swift
//  trialproduct
//
//  Created by Hiroto Narumiya on 2023/05/17.
//

import SwiftUI



struct SideMenuView: View{
    @Binding var isOpen: Bool
    @Binding var ScreenMode: ScreenMode
    var parentwidth: CGFloat
    var parentheight: CGFloat
    var body:some View{
        NavigationStack{
            VStack(alignment: .leading, spacing:10){
                Button(action:{
                    self.isOpen.toggle()
                    ScreenMode = .DefaultMode
                }){
                    Text("ホーム")
                        .foregroundColor(Color.black)
                }
                Button(action:{
                    self.isOpen.toggle()
                    ScreenMode = .ConsultingMode
                }){
                    Text("チャット機能").foregroundColor(Color.black)
                }
                Button(action:{UnDecidedUIView()}){
                    Text("コミュニティー").foregroundColor(Color.black)
                }
                Button(action:{UnDecidedUIView()}){
                    Text("アカウント情報").foregroundColor(Color.black)
                }
            }
            //.border(.blue)
            .offset(x:-25,y:-280)
        }
        .frame(maxWidth: 200, maxHeight: .infinity)
        .background(Color(red: 0.8, green: 0.8, blue: 0.8))
        //.border(.red)
        .offset(x:-87)
        .opacity(self.isOpen ? 1.0 : 0.0)
        .opacity(1.0)
        .animation(.easeIn(duration: 0.5))
        .onTapGesture {
            self.isOpen = false
        }
    }
}

struct UnDecidedUIView: View{
    var body: some View{
        Text("UN")
    }
}


struct Slider_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
