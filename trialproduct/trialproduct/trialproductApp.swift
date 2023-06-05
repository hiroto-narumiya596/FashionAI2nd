//
//  trialproductApp.swift
//  trialproduct
//
//  Created by Hiroto Narumiya on 2023/05/13.
//

import SwiftUI

//YahooAPIのグローバル変数
var YahooAPIKEY: String = "https://shopping.yahooapis.jp/ShoppingWebService/V3/itemSearch?appid=dj00aiZpPWw4WVJkM1YzR1NKMyZzPWNvbnN1bWVyc2VjcmV0Jng9NTM-"

@main
struct trialproductApp: App {

    var body: some Scene {
        WindowGroup {
            ZStack{
                ContentView2()
                PreUIView() //余力があれば
            }
        }
    }
}


//画面ピクセルサイズ早見表
//iPhone11Pro: 375×812
//iPhone12Pro 844 390
//iPhone12ProMax 926 428
//iPhone13Pro 844 390
//iPhone13ProMax 926 428
//iPhone14Pro 852 393
//iPhone14ProMax 932 430
//iPadPro11inch 1194 834
//iPadPro12.9inch 1366 1024
//https://www.vamp.jp/archives/246
