from fastapi import FastAPI
import ClassLibrary
import json
import uuid
import datetime
import openai
import requests
import os

# 環境構築
app = FastAPI()
openai.api_key = os.environ["OPENAI_SECRETKEY"] # OPENAIのAPIKEY。ここは書き換えてください。
YahooKey = "https://shopping.yahooapis.jp/ShoppingWebService/V3/itemSearch?appid="+os.environ["Yahoo_APIKEY"] # YahooのAPIKEY。ここは書き換えてください。

# 仮のデータ。統合したら消してもらって大丈夫。
temp_message = "最近の夏服のトレンドは、パステルカラーのシャツに重めのカラーのジーンズです。シューズは、Nikeが良いでしょう。Nikeは最近新しい01モデルを発表したので、買うなら今でしょう。"
temp_AIChatData = ClassLibrary.ChatHistory(id=str(uuid.uuid4()),chatid="12345",chattimestamp=str(datetime.datetime.now()),chatspeaker="AI",chatcontent=temp_message)
temp_TopsData = ClassLibrary.ItemData(id=str(uuid.uuid4()),name="tシャツ Tシャツ Champion Authentic T-SHIRTS/ チャンピオン コットン Tシャツ(1/2スリーブ)",description="『タイムセール実施中』",url="https://store.shopping.yahoo.co.jp/zozo/28046612.html",imageurl="https://item-shopping.c.yimg.jp/i/g/zozo_28046612") 
temp_BottomsData = ClassLibrary.ItemData(id=str(uuid.uuid4()),name="シェフパンツ メンズ ワイドパンツ チノパン テーパードパンツ ルーズ ゆったり ツイル 無地 デニム ストライプ チェック柄 カモフラ柄 イージーパンツ ボトムス",description="メンズチノパン/メンズワイドパンツ/シェフパンツ<br><br>ゆったりとしたシルエットで太ももから裾に向かって細くなる<br>テーパードシルエットのトレンドシェフパンツ！<br>動きやすくストレスフリーの着用感！腰回りにボリュームのあるトレンドな仕上がりに！<br><br><br>サイズ：単位(cm)<br>メーカーウエスト/ヒップ/股上/股下/モモ幅/裾幅<br>【M】 76-84/108/30/68/34/17<br>【L】 84-94/112/31/69/35/18<br>【LL】94-104/116/32/70/36/19<br>※基本的に、XL・LL・2Lのサイズはすべて同じサイズです。<br>メーカーによってはサイズの呼称が違うため、XL・LL・2Lと商品により表示の違いがあります。<br><br>素材：ポリエステル100％<br>6-デニム　綿100％<br><br>※製造工程の過程による、小さなほつれ、微小な縫製のずれなどの<br>返品対応は致しかねます。ご了承ください。<br><br><br>≪アイテムガイド≫<br>・着用サイズ感：ルーズ<br>・生地の厚さ：ふつう<br>・透け感：なし<br>・伸縮性：若干あり<br>※上記サイズ感はスタッフ個人的な感想となります。<br><br>モデル：身長 178cm<br>胸囲88cm/ウエスト68cm/ヒップ87cm<br>商品は【Ｌサイズ】を着用<br>当店ではお裾直しは承っておりませんのでご了承下さい",url="https://store.shopping.yahoo.co.jp/topism/bottoms-60-topism.html",imageurl="https://item-shopping.c.yimg.jp/i/g/topism_bottoms-60-topism") 
temp_ShoesData = ClassLibrary.ItemData(id=str(uuid.uuid4()),name="NIKE ナイキ WMNS AIR MAX KOKO SANDAL CI8798 002 / 003 / 100 ウィメンズ エアマックス ココ サンダル レディース NKN nike1934",description="NIKEよりレディースサンダルの入荷です。",url="https://store.shopping.yahoo.co.jp/republic/nike1934.html",imageurl="https://item-shopping.c.yimg.jp/i/g/republic_nike1934")
temp_OuterData = ClassLibrary.ItemData(id=str(uuid.uuid4()),name="ノースフェイス（THE NORTH FACE）（メンズ）ザコーチ ジャケット NP72130 K アウター",description="ノースフェイス THE NORTH FACE THE NORTHFACE THENORTHFACE エルブレス ヴィクトリア ビクトリア Victoria L-Breath メンズ 黒 ブラック THE COACH JACKET アウター アウトドア キャンプ トレッキング 2022 おすすめ春ジャケット エルブレス 2022 お得ウェア エルブレス outer1030coup lb22050605bn カーキ オリーブ グリーン 緑 The Coach Jacket NorthFace トレッキングウエア ノースフェイス 秋冬ウェア エルブレス bf_outer2211lb lb230303_アウター エルブレス_bannerlb23ss05vl ノースフェイス 梅春ウェア エルブレス エルブレス 2023SSおすすめ rss20230604_lb",url="https://store.shopping.yahoo.co.jp/supersportsxebio/10779664001.html",imageurl="https://item-shopping.c.yimg.jp/i/g/supersportsxebio_10779664001")

def GetAIAnswer(UserChatData: ClassLibrary.ChatHistory)-> ClassLibrary.ChatHistory:
    UserMessage = UserChatData.chatcontent
    res = openai.ChatCompletion.create(model="gpt-3.5-turbo",
        messages=[
            {
                "role": "system",
                "content": "日本語で返答してください。"
            },
            {
                "role": "user",
                "content": UserMessage
            },
        ],
    )
    AIMessage: str = res.choices[0]["message"]["content"].strip()
    AIChatHistory = ClassLibrary.ChatHistory(id=str(uuid.uuid4()),chatid="1234",chattimestamp=str(datetime.datetime.now()),chatspeaker="AI",chatcontent=AIMessage)
    return AIChatHistory

# 仮のユーザーデータ
userdata = ClassLibrary.UserData(userid="12345678",username="narumiya")


@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "q":q}


@app.get("/LoadingUserData")
def Read_UserData():
    return {"Hello": "World"}


# 端末からデータを受信し、gptの返信内容を送信するとともに、自身のデータを更新する
@app.post("/UpdateUserChatData")
def Update_UserChatData(chatdata: ClassLibrary.ChatHistory):
    userdata.chathisrories.append(chatdata) 
    # AIのchatデータを書き込む
    # gptの代わりの返信内容を送信する
    #AIChatData = GetAIAnswer(chatdata)

    # 実験：YahooショッピングAPIへのリクエストの記述
    Request = YahooKey + "&query=nike" #nikeというキーワードで検索
    res = requests.get(Request)
    jsondata = res.json() #取得したデータをjson型に変換    
    for i in range(len(jsondata["hits"])):
        print(str(i)+"番目："+jsondata["hits"][i]['name']) 
    
    """
    この部分にバックエンド側の処理を記述。
    # ここでデータを格納する(後で実装)
    ResponseAIChatData = ClassLibrary.ItemData(id=str(uuid.uuid4()),name="",description="",url="",imageurl="") # AIの応答データ
    ResponseTopsData = ClassLibrary.ItemData(id=str(uuid.uuid4()),name="",description="",url="",imageurl="") # トップスの応答データ
    ResponseBottomsData = ClassLibrary.ItemData(id=str(uuid.uuid4()),name="",description="",url="",imageurl="") # ボトムスの応答データ
    ResponseShoesData = ClassLibrary.ItemData(id=str(uuid.uuid4()),name="",description="",url="",imageurl="") # シューズの応答データ
    ResponseOuterData = ClassLibrary.ItemData(id=str(uuid.uuid4()),name="",description="",url="",imageurl="") # アウターの応答データ
    """
    # ここでは仮のデータを返答データに格納している。
    userdata.chathisrories.append(temp_AIChatData)
    ResponseData = ClassLibrary.ResponseDataSet(id=str(uuid.uuid4()),AIChatData=temp_AIChatData,TopsWear=temp_TopsData,BottomsWear=temp_BottomsData,ShoesWear=temp_ShoesData,OuterWear=temp_OuterData)

    return ResponseData.dict() 


@app.get("/GetTrendItem")
def Get_TrendItemData():
    return


#userdata.chathisrories.append({"id": chatdata.id, "chatid": chatdata.chatid, "chattimestamp": chatdata.chattimestamp, "chatspeaker": chatdata.chatspeaker, "chatcontent": chatdata.chatcontent})