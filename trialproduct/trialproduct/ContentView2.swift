//
//  ContentView2.swift
//  trialproduct
//
//  Created by Hiroto Narumiya on 2023/05/17.
//

import SwiftUI

struct ContentView2: View {
    @State var isOpenSideMenu: Bool = false
    @State var PresentScreenMode: ScreenMode = .DefaultMode
    @State var isOpenTopsWearWebsite:Bool! = false
    @State var isOpenBottomsWearWebsite:Bool! = false
    @State var isOpenShoesWearWebsite:Bool! = false
    @State var isOpenOuterWearWebsite:Bool! = false
    @StateObject var UserChatModelManager: ChatModelManager = ChatModelManager(userid: "12345", username: "narumiya")
    var body: some View {
        NavigationStack{
            ZStack{
                if(PresentScreenMode == .DefaultMode){
                    VStack{
                        HomeUIView()
                    }
                }
                if(PresentScreenMode == .ConsultingMode){
                    VStack{
                        ChatUIView2(isOpenTopsWearWebsite: $isOpenTopsWearWebsite, isOpenBottomsWearWebsite: $isOpenBottomsWearWebsite, isOpenShoesWearWebsite: $isOpenShoesWearWebsite, isOpenOuterWearWebsite: $isOpenOuterWearWebsite,UserChatModelManager: UserChatModelManager)
                    }
                }
                SideMenuView(isOpen: $isOpenSideMenu,ScreenMode: $PresentScreenMode, parentwidth: 100, parentheight: 250)
                
                if isOpenTopsWearWebsite{
                    TopsItemWebsiteUIView(isOpenItemWebsiteUIView: $isOpenTopsWearWebsite, ItemURL: UserChatModelManager.TopsWear?.url)
                }
                if isOpenBottomsWearWebsite{
                    BottomsItemWebsiteUIView(isOpenItemWebsiteUIView: $isOpenBottomsWearWebsite, ItemURL: UserChatModelManager.BottomsWear?.url)
                }
                if isOpenShoesWearWebsite{
                    ShoesItemWebsiteUIView(isOpenItemWebsiteUIView: $isOpenShoesWearWebsite, ItemURL: UserChatModelManager.ShoesWear?.url)
                }
                if isOpenOuterWearWebsite{
                    OuterItemWebsiteUIView(isOpenItemWebsiteUIView: $isOpenOuterWearWebsite, ItemURL: UserChatModelManager.OuterWear?.url)
                }
            }
            
            //.border(.red)
            .toolbar{
                ToolbarItemGroup(placement: .navigation){
                    Button(action:{self.isOpenSideMenu.toggle()}){
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)}
                    /*
                    Image(systemName: "cart.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                    Text("FashionAI")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(width: 90, height:10)*/
                }
                
            }
        }
        //.border(.red)
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
