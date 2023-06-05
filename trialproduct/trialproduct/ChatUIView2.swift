//
//  ChatUIView2.swift
//  trialproduct
//
//  Created by Hiroto Narumiya on 2023/05/17.
//

import SwiftUI
import UIKit

struct ChatUIView2: View {
    @State var ChatUIScreenMode: ChatUIScreenMode = .ChatCommunicationMode
    @State var isChatMode: Bool = true
    @Binding var isOpenTopsWearWebsite:Bool!
    @Binding var isOpenBottomsWearWebsite:Bool!
    @Binding var isOpenShoesWearWebsite:Bool!
    @Binding var isOpenOuterWearWebsite:Bool!
    @ObservedObject var UserChatModelManager: ChatModelManager
    //@StateObject var AIChatMessage//: ChatHistory
    var body: some View {
        VStack{
            HStack(spacing:10){
                Button(action:{
                    ChatUIScreenMode = .ChatCommunicationMode
                }){
                    if ChatUIScreenMode == .ChatCommunicationMode{
                        Text("チャット").frame(width: 140,height:40).foregroundColor(.white).background(Color(red: 0.7, green: 0.7, blue: 0.7)).cornerRadius(10)
                    }else{
                        Text("チャット").frame(width: 140,height:40).foregroundColor(.black).background(Color(red: 0.9, green: 0.9, blue: 0.9)).cornerRadius(10)
                    }
                }
                Button(action:{
                    ChatUIScreenMode = .ModelOutputMode
                }){
                    if ChatUIScreenMode == .ModelOutputMode{
                        Text("モデル表示").frame(width: 140,height:40).foregroundColor(.white).background(Color(red: 0.7, green: 0.7, blue: 0.7)).cornerRadius(10)
                    }else{
                        Text("モデル表示").frame(width: 140,height:40).foregroundColor(.black).background(Color(red: 0.9, green: 0.9, blue: 0.9)).cornerRadius(10)
                    }
                }
            }//.offset(y:-10).border(.red)
            if ChatUIScreenMode == .ChatCommunicationMode{
                CommunicationScreenUIView( UserChatModelManager: UserChatModelManager)//.offset(y:-60)
            }else{
                ModelScreenUIView(isOpenTopsWearWebsite: $isOpenTopsWearWebsite,isOpenBottomsWearWebsite: $isOpenBottomsWearWebsite,isOpenShoesWearWebsite: $isOpenShoesWearWebsite,isOpenOuterWearWebsite: $isOpenOuterWearWebsite,UserChatModelManager: UserChatModelManager)//.offset(y:-60)
            }
        }.frame(maxHeight: .infinity)//.border(.red)
    }
}

struct CommunicationScreenUIView: View{
    @State var name: String = ""
    @State private var message = ""
    @State private var editting = false
    @StateObject var UserChatModelManager: ChatModelManager
    var body: some View{
        VStack{
            ScrollView(.vertical){
                    Spacer()
                    if UserChatModelManager.chathistories.count > 0{
                        ForEach(UserChatModelManager.chathistories){ chathistory in
                            if chathistory.chatspeaker == "User"{
                                VStack(spacing: 30){
                                    Text(chathistory.chatcontent)
                                        .padding([.top, .leading, .bottom], 10.0)
                                        .frame(maxWidth:200, alignment: .leading)
                                    .foregroundColor(.black).background(.green).cornerRadius(10)
                                }.frame(maxWidth: .infinity, alignment: .trailing )
                            }
                            if chathistory.chatspeaker == "AI"{
                                VStack(spacing: 30){
                                    HStack{
                                        Image(systemName: "person.circle.fill").resizable().frame(width:30,height: 30).padding(.horizontal, 2.0)
                                        Text(chathistory.chatcontent)
                                            .padding([.top, .leading, .bottom], 10.0)
                                            .frame(maxWidth:200, alignment: .leading)
                                        .foregroundColor(.black).background(.white).cornerRadius(10)}
                                }.frame(maxWidth: .infinity, alignment: .leading )
                            }
                        }
                }
            }.frame(maxWidth: .infinity).background(.cyan)
            
            
            HStack{
                Button(action:{
                    UserChatModelManager.SendMessage(chatroom: "", message: name)
                }){
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
            }.border(.blue).padding(.bottom)
        }.border(.blue)
    }
    
}

struct ModelScreenUIView: View{
    @Binding var isOpenTopsWearWebsite:Bool!
    @Binding var isOpenBottomsWearWebsite:Bool!
    @Binding var isOpenShoesWearWebsite:Bool!
    @Binding var isOpenOuterWearWebsite:Bool!
    @StateObject var UserChatModelManager: ChatModelManager
    //@Binding var isOpenItemWebsiteUIView: Bool!
    let temp_imageURL: String = "https://item-shopping.c.yimg.jp/i/g/masanagoya_1994012"
    let message: String = ""
    var body: some View{
        if UserChatModelManager.isModelMade{
            VStack{
                ScrollView(.vertical){
                    Spacer()
                    Button(action:{
                        self.isOpenTopsWearWebsite = true
                    }){
                        ZStack{
                            Rectangle().foregroundColor(.white)
                            HStack{
                                AsyncImage(url: URL(string: UserChatModelManager.TopsWear!.imageurl)){ image in
                                        image.resizable().offset(x:0)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 110, height: 110)
                                    
                                Text(UserChatModelManager.TopsWear!.name).fontWeight(.bold).foregroundColor(Color.black).frame(width:180,height:180).offset(x:0,y:-5)
                            }
                        }.frame(width:340,height: 180)
                    }
                    Button(action:{
                        self.isOpenBottomsWearWebsite = true
                    }){
                        ZStack{
                            Rectangle().foregroundColor(.white)
                            HStack{
                                AsyncImage(url: URL(string: UserChatModelManager.BottomsWear!.imageurl)){ image in
                                    image.resizable().frame(width: 110, height: 110)//.border(.red)
                                } placeholder: {
                                    ProgressView()
                                }
                                //.frame(width: 110, height: 110)
                                Text(UserChatModelManager.BottomsWear!.name).fontWeight(.bold).foregroundColor(Color.black).frame(width:180,height:180).offset(x:0,y:-5)
                                
                            }
                        }.frame(width:340,height: 180).foregroundColor(.white)
                    }
                    Button(action:{
                        self.isOpenShoesWearWebsite = true
                    }){
                        ZStack{
                            Rectangle().foregroundColor(.white)
                            HStack{
                                AsyncImage(url: URL(string: UserChatModelManager.ShoesWear!.imageurl)){ image in
                                    image.resizable().frame(width: 110, height: 110)//.border(.red)
                                } placeholder: {
                                    ProgressView()
                                }
                                //.frame(width: 110, height: 110)
                                Text(UserChatModelManager.ShoesWear!.name).fontWeight(.bold).foregroundColor(Color.black).frame(width:180,height:180).offset(x:0,y:-5)
                                
                            }
                        }.frame(width:340,height: 180).foregroundColor(.white)
                    }
                    Button(action:{
                        self.isOpenOuterWearWebsite = true
                    }){
                        ZStack{
                            Rectangle().foregroundColor(.white)
                            HStack{
                                AsyncImage(url: URL(string: UserChatModelManager.OuterWear!.imageurl)){ image in
                                    image.resizable().scaledToFit().frame(width: 110, height: 110)//.border(.red)
                                } placeholder: {
                                    ProgressView()
                                }
                                //.frame(width: 110, height: 110)
                                Text(UserChatModelManager.OuterWear!.name).fontWeight(.bold).foregroundColor(Color.black).frame(width:180,height:180).offset(x:0,y:-5)
                                
                            }
                        }.frame(width:340,height: 180).foregroundColor(.white)
                    }
                }.frame(width: 360,height: 480).background(Color(red: 0.8, green: 0.8, blue: 0.8))//.border(.red)
                ScrollView{
                    Text(UserChatModelManager.aimessage).padding(.all, 7.0).frame(width: 340,alignment: .leading).background(Color(red: 0.9, green: 0.9, blue: 0.9))
                }
                .frame(width: 340, height: 150).background(Color(red: 0.9, green: 0.9, blue: 0.9))
            }
            
        }
        if !UserChatModelManager.isModelMade{
            ModelScreenUIViewCover()
        }
    }
}


struct ModelScreenUIViewCover: View{
    var body: some View{
        ZStack{
            Rectangle().foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.6))
            Text("モデルが未作成です。")
                .foregroundColor(Color.black)
        }.background(.gray)
    }
}


struct ChatUIView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

