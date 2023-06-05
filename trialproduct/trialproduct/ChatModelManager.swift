//
//  ChatModelManager.swift
//  trialproduct
//
//  Created by Hiroto Narumiya on 2023/05/17.
//

import Foundation


class ChatModelManager: NSObject, ObservableObject{
    var userid: String
    var username: String
    @Published var isModelMade: Bool
    @Published var aimessage: String = ""
    @Published var chathistories: [ChatHistory]
    @Published var TopsWear: ItemData?
    @Published var BottomsWear: ItemData?
    @Published var ShoesWear: ItemData?
    @Published var OuterWear: ItemData?
    
    init(userid: String, username: String) {
        self.userid = userid
        self.username = username
        self.isModelMade = false //後で必ずfalseに戻すこと
        self.chathistories = []
    }
    
    
    // データベースにメッセージを送信する関数
    func SendMessage(chatroom: String, message: String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let chatmessage: ChatHistory = ChatHistory(id: UUID().uuidString, chatid: "12345", chattimestamp: dateFormatter.string(from: Date()), chatspeaker: "User", chatcontent: message)
        let SentChatHistoryJSON: ChatHistoryJSON = ChatHistoryJSON(id: chatmessage.id, chatid: chatmessage.chatid, chattimestamp: chatmessage.chattimestamp, chatspeaker: chatmessage.chatspeaker, chatcontent: String(chatmessage.chatcontent))
        self.chathistories.append(chatmessage)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        guard let jsonData = try? encoder.encode(SentChatHistoryJSON)else{//jsonデータの作成
            return
        }
        //let decoded1 = try! JSONDecoder().decode(ChatHistoryJSON.self, from: jsonData) jsonデコードのテスト（成功）
        //let jsonstr:String = String(data: jsonData, encoding: .utf8)!
        guard let posturl = URL(string: "http://127.0.0.1:8000/UpdateUserChatData") else{return} //適宜変更すること
        var post_request = URLRequest(url: posturl)
        post_request.httpMethod = "POST"
        post_request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        post_request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: post_request) {(data, response, error) in
            
            //エラーの確認を行う
            if let error = error {
                print("Failed to get item info: \(error)")
                return;
            }
            //レスポンスが200台じゃない場合、通信エラーの表示になる
            if let response = response as? HTTPURLResponse {
                if !(200...299).contains(response.statusCode) {
                    print("Response status code does not indicate success: \(response.statusCode)")
                    return
                }
            }
            
            //レスポンスデータの受け取り部分
            if let mimeType = response?.mimeType,
                mimeType == "application/json",
                let data = data{
                //var json :Dictionary = NSJSONSerialization.JSONObjectWithData(data, options:0, error: nil)
                //let datanew = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let decoded = try! JSONDecoder().decode(ResponseDataSetJSON.self, from: data)
                let new_ai_chatdata = ChatHistory(id: decoded.AIChatData!.id!, chatid: decoded.AIChatData!.chatid!, chattimestamp: decoded.AIChatData!.chattimestamp!, chatspeaker: decoded.AIChatData!.chatspeaker!, chatcontent: decoded.AIChatData!.chatcontent!)
                DispatchQueue.main.async {
                    self.TopsWear = ItemData(id: decoded.TopsWear!.id!, name: decoded.TopsWear!.name!, description: decoded.TopsWear!.description!, url: decoded.TopsWear!.url!, imageurl: decoded.TopsWear!.imageurl!)
                    self.BottomsWear = ItemData(id: decoded.BottomsWear!.id!, name: decoded.BottomsWear!.name!, description: decoded.BottomsWear!.description!, url: decoded.BottomsWear!.url!, imageurl: decoded.BottomsWear!.imageurl!)
                    self.ShoesWear = ItemData(id: decoded.ShoesWear!.id!, name: decoded.ShoesWear!.name!, description: decoded.ShoesWear!.description!, url: decoded.ShoesWear!.url!, imageurl: decoded.ShoesWear!.imageurl!)
                    self.OuterWear = ItemData(id: decoded.OuterWear!.id!, name: decoded.OuterWear!.name!, description: decoded.OuterWear!.description!, url: decoded.OuterWear!.url!, imageurl: decoded.OuterWear!.imageurl!)
                    self.chathistories.append(new_ai_chatdata)
                    self.isModelMade = true
                    self.aimessage = new_ai_chatdata.chatcontent
                }
                
                return
            }
            
        }
        task.resume()
        
    }
    
    
    func ReceiveChatHistories() {
    }
    
    
    //以下、HTTP通信用のjsonデータ形式を定義
    //チャットルームのjsonデータ形式
    struct ChatHistoriesJSON: Codable{
        let useid: String?
        let username: String?
        let chathistories: [ChatHistoryJSON]?
    }
   
    //サーバー側からのレスポンスのjsonデータ形式
    struct ResponseDataSetJSON: Codable{
        let id: String?
        let AIChatData: ChatHistoryJSON?
        let TopsWear: ItemDataJSON?
        let BottomsWear: ItemDataJSON?
        let ShoesWear: ItemDataJSON?
        let OuterWear: ItemDataJSON?
    }
    
    //1チャットのjsonデータ形式
    struct ChatHistoryJSON: Codable{
        let id: String?
        let chatid: String?
        let chattimestamp: String?
        let chatspeaker: String?
        let chatcontent: String?
    }

    //アイテムデータのjsonデータ形式
    struct ItemDataJSON: Codable{
        let id: String?
        let name: String?
        let description: String?
        let url: String?
        let imageurl: String?
    }
}


//以下フロント側用のデータ形式を定義
//サーバー側からのレスポンスのデータセット
struct ResponseDataSet: Identifiable{
    let id: String
    let AIChatData: ChatHistory
    let TopsWear: ItemData
    let BottomsWear: ItemData
    let ShoesWear: ItemData
    let OuterWear: ItemData
}

//チャット記録
struct ChatHistory: Identifiable{
    let id: String
    let chatid: String
    let chattimestamp: String
    let chatspeaker: String
    let chatcontent: String
}

//アイテムデータ
struct ItemData: Identifiable{
    let id: String
    let name: String
    let description: String
    let url: String
    let imageurl: String
}



//http://127.0.0.1:8000/UpdateUserChatData/{"id": "68e5f952-3f80-4dd7-a3a1-b2b20990244d", "chatid": "1234", "chattimestamp": "2023-05-24 17:43:59.003394", "chatspeaker": "AI", "chatcontent": "Hello World"}
